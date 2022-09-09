import 'package:flutter/material.dart';
import 'package:linux_plugins/fragments/plugins/flutter_secure_storage.dart';
import 'package:linux_plugins/fragments/plugins/geoclue.dart';
import 'package:linux_plugins/navigationDrawer/navigation_drawer.dart';
import 'package:linux_plugins/fragments/plugins/path_provider.dart';
import 'package:linux_plugins/fragments/plugins/shared_preferences.dart';
import 'package:linux_plugins/fragments/plugins/url_launcher.dart';

class MiscPage extends StatelessWidget {
  static const String routeName = '/miscPage';

  const MiscPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
      return DefaultTabController(
            length: 7,
            child: Scaffold(
              drawer: const NavigationDrawer(),
              appBar: AppBar(
                bottom: const TabBar(
                  tabs: [
                    Tab(text: 'Secure Storage'),
                    Tab(text: 'Path'),
                    Tab(text: 'Shared Preferences'),
                    Tab(text: 'URL Launcher'),
                    Tab(text: 'Geoclue'),
                  ],
                ),
                title: const Text('Misc'),
              ),
              body: const TabBarView(
                children: [
                  SecureStorageWidget(),
                  PathProvider(),
                  SharedPreferencesPage(),
                  UrlLauncherPage(title: 'Url Launcher'),
                  GeocluePage(title: 'Geoclue'),
                ],
              ),
          ),
        );
    }

}
