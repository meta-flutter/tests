import 'package:flutter/material.dart';
import 'package:dbus/dbus.dart';
import 'package:gsettings/gsettings.dart';


class GSettingsPage extends StatefulWidget {
  const GSettingsPage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _GSettingsPageState createState() => _GSettingsPageState();
}

class _GSettingsPageState extends State<GSettingsPage> {

  final _settings = GSettings('org.gnome.desktop.interface');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                final value = await _settings.get('font-name');
                var font = (value as DBusString).value;
                print('Current font set to: $font');
              },
              child: const Text('Font Name'),
            ),
            ElevatedButton(
              onPressed: () async {
                var schemas = await listGSettingsSchemas();
                for (var schema in schemas) {
                  print(schema);
                }
              },
              child: const Text('Settings Schemas'),
            ),
            ElevatedButton(
              onPressed: () async {
                final settings = GSettings('org.gnome.desktop.notifications.application',
                path: '/org/gnome/desktop/notifications/application/org-gnome-terminal/');
                var id = (await settings.get('application-id') as DBusString).value;
                var enable = (await settings.get('enable') as DBusBoolean).value;
                print('Notifications for $id: $enable');
              },
              child: const Text('Relocatable Schema'),
            ),
            ElevatedButton(
              onPressed: () async {
                var settings = GSettings('org.gnome.desktop.interface');
                await settings.set('show-battery-percentage', const DBusBoolean(true));
              },
              child: const Text('Set'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _settings.close();
  }
}
