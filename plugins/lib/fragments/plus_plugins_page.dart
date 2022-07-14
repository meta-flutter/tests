import 'package:flutter/material.dart';
import 'package:linux_plugins/navigationDrawer/navigation_drawer.dart';
import 'package:linux_plugins/fragments/plugins/device_info_plus.dart';
import 'package:linux_plugins/fragments/plugins/battery_plus.dart';
import 'package:linux_plugins/fragments/plugins/connectivity_plus.dart';
import 'package:linux_plugins/fragments/plugins/network_info_plus.dart';
import 'package:linux_plugins/fragments/plugins/package_info_plus.dart';


class PlusPluginsPage extends StatelessWidget {
  static const String routeName = '/plusPluginsPage';

  const PlusPluginsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
      return DefaultTabController(
            length: 5,
            child: Scaffold(
              drawer: const NavigationDrawer(),
              appBar: AppBar(
                bottom: const TabBar(
                  tabs: [
                    Tab(text: 'Device'),
                    Tab(text: 'Battery'),
                    Tab(text: 'Network Connectivity'),
                    Tab(text: 'Network Info'),
                    Tab(text: 'Package Info'),
                  ],
                ),
                title: const Text('Plus Plugins'),
              ),
              body: const TabBarView(
                children: [
                  DeviceInfoPlusPage(title: 'Device Info'),
                  BatteryPlusPage(title: 'Battery'),
                  ConnectivityPlus(title: 'Connectivity'),
                  NetworkInfoPlusPage(title: 'Network Info'),
                  PackageInfoPlusPage(title: 'Package Info'),
                ],
              ),
          ),
        );
    }

}
