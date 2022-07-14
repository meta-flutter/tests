import 'package:flutter/material.dart';
import 'package:fwupd/fwupd.dart';

class FwupdPage extends StatefulWidget {
  const FwupdPage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _FwupdPageState createState() => _FwupdPageState();
}

class _FwupdPageState extends State<FwupdPage> {

  final _client = FwupdClient();

  @override
  void initState() {
    super.initState();
    _client.connect();
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
                print('${_client.daemonVersion}');
                final devices = await _client.getDevices();
                // ignore: unwaited_futures
                print('Devices:');
                for (var device in devices)
                  print(device.name);
              },
              child: const Text('Print Devices'),
            ),
            ElevatedButton(
              onPressed: () async {
                final devices = await _client.getDevices();
                for (var device in devices) {
                  try {
                    final upgrades = await _client.getUpgrades(device.deviceId);
                    if (upgrades.isNotEmpty) {
                      print('  Upgrades:');
                      for (var upgrade in upgrades) {
                        print('  ${upgrade.name}: ${upgrade.version}');
                      }
                    }
                  } on FwupdException {
                    // No upgrades available
                  }
                }
              },
              child: const Text('Get Upgrades'),
            ),
            ElevatedButton(
              onPressed: () async {
                final devices = await _client.getDevices();
                for (var device in devices) {
                  try {
                    final downgrades = await _client.getDowngrades(device.deviceId);
                    if (downgrades.isNotEmpty) {
                      print('  Downgrades:');
                      for (var downgrade in downgrades) {
                        print('  ${downgrade.name}: ${downgrade.version}');
                      }
                    }
                  } on FwupdException {
                    // No downgrades available
                  }
                }
              },
              child: const Text('Get Downgrades'),
            ),
            ElevatedButton(
              onPressed: () async {
                final remotes = await _client.getRemotes();
                for (var remote in remotes) {
                  print('${remote.title}');
                  print('  ID ${remote.id}');
                  print('  Type ${remote.kind.toString().split('.').last}');
                  print('  Enabled ${remote.enabled}');
                  print('  Filename ${remote.filenameCache}');
                }
              },
              child: const Text('Get Remotes'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _client.close();
  }
}
