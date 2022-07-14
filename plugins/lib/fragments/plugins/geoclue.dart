import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geoclue/geoclue.dart';


class GeocluePage extends StatefulWidget {
  const GeocluePage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _GeocluePageState createState() => _GeocluePageState();
}

class _GeocluePageState extends State<GeocluePage> {

  final _manager = GeoClueManager();

  @override
  void initState() {
    super.initState();
    _manager.connect();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                final _client = await _manager.getClient();
                await _client.setDesktopId('<desktop-id>');
                await _client.setRequestedAccuracyLevel(GeoClueAccuracyLevel.exact);
                await _client.start();

                print('Available accuracy: ${_manager.availableAccuracyLevel.name}');
                print('Requested accuracy: ${_client.requestedAccuracyLevel.name}');
                print('Last known location: ${_client.location ?? 'unknown'}');
                print('Waiting 10s for location updates...');
                late final StreamSubscription sub;
                sub = GeoClue.getLocationUpdates(desktopId: '<desktop-id>')
                    .timeout(const Duration(seconds: 10), onTimeout: (_) => sub.cancel())
                    .listen((location) {
                  print('... $location');
                });
              },
              child: const Text('Client'),
            ),
            ElevatedButton(
              onPressed: () async {
                final location = await GeoClue.getLocation(desktopId: '<desktop-id>');
                print('Current location: $location');

                print('Waiting 10s for location updates...');
                late final StreamSubscription sub;
                sub = GeoClue.getLocationUpdates(desktopId: '<desktop-id>')
                    .timeout(const Duration(seconds: 10), onTimeout: (_) => sub.cancel())
                    .listen((location) {
                  print('... $location');
                });
              },
              child: const Text('Simple'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _manager.close();
  }
}
