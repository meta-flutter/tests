import 'package:bluez/bluez.dart';
import 'package:flutter/material.dart';


class BluezPage extends StatefulWidget {
  const BluezPage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _BluezState createState() => _BluezState();
}

class _BluezState extends State<BluezPage> {

  final _client = BlueZClient();

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
                if (_client.adapters.isEmpty) {
                    print('No Bluetooth adapters found');
                }
                else {
                  for (var adapter in _client.adapters) {
                    print('Controller ${adapter.address} ${adapter.alias}');
                  }                
                }
              },
              child: const Text('List Adapters'),
            ),
            ElevatedButton(
              onPressed: () async {
                if (_client.adapters.isEmpty) {
                    print('No Bluetooth adapters found');
                    await _client.close();
                    return;
                  }
                  for (var device in _client.devices) {
                    print('Device ${device.address} ${device.alias}');
                  }
              },
              child: const Text('List Devices'),
            ),
            ElevatedButton(
              onPressed: () async {
                if (_client.adapters.isEmpty) {
                  print('No Bluetooth adapters found');
                } else {
                  for (var device in _client.devices) {
                    var services = device.gattServices;
                    if (services.isEmpty) {
                      continue;
                    }
                    print('Device ${device.alias}');
                    await device.connect();
                    for (var service in device.gattServices) {
                      print('  Service ${service.uuid}');
                      for (var characteristic in service.characteristics) {
                        String characteristicValue;
                        try {
                          characteristicValue = '${await characteristic.readValue()}';
                        } on BlueZNotPermittedException {
                          characteristicValue = '<write only>';
                        } on BlueZException catch (e) {
                          characteristicValue = '<${e.message}>';
                        } catch (e) {
                          characteristicValue = '<$e>';
                        }
                        print('    Characteristic ${characteristic.uuid} = $characteristicValue');
                        for (var descriptor in characteristic.descriptors) {
                          String descriptorValue;
                          try {
                            descriptorValue = '${await descriptor.readValue()}';
                          } on BlueZNotPermittedException {
                            descriptorValue = '<write only>';
                          } on BlueZException catch (e) {
                            descriptorValue = '<${e.message}>';
                          } catch (e) {
                            descriptorValue = '<$e>';
                          }
                          print('      Descriptor ${descriptor.uuid} = $descriptorValue');
                        }
                      }
                    }
                  }
                }
              },
              child: const Text('List Services'),
            ),
            ElevatedButton(
              onPressed: () async {
                if (_client.adapters.isEmpty) {
                  print('No Bluetooth adapters found');
                } else {
                  var adapter = _client.adapters[0];
                  print('Searching for devices on ${adapter.name}...');
                  for (var device in _client.devices) {
                    print('  ${device.address} ${device.name}');
                  }
                  _client.deviceAdded.listen((device) => print('  ${device.address} ${device.name}'));
                  await adapter.startDiscovery();
                  await Future.delayed(Duration(seconds: 5));
                  await adapter.stopDiscovery();     
                }
              },
              child: const Text('Scan'),
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

class CardListTile extends StatelessWidget {
  final String name;
  final String? value;

  CardListTile(this.name, this.value);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(value ?? 'N/A'),
        subtitle: Text(name),
      ),
    );
  }
}
