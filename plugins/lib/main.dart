import 'package:flutter/material.dart';
import 'package:linux_plugins/fragments/plus_plugins_page.dart';
import 'fragments/home_page.dart';
import 'fragments/misc_page.dart';
import 'fragments/plus_plugins_page.dart';
import 'fragments/video_player_page.dart';
import 'fragments/linux_page.dart';
import 'routes/page_route.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NavigationDrawer Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
      routes: {
        PageRoutes.home: (context) => const HomePage(),
        PageRoutes.misc: (context) => const MiscPage(),
        PageRoutes.plusPlugins: (context) => const PlusPluginsPage(),
        PageRoutes.videoPlayer: (context) => const VideoPlayerPage(),
        PageRoutes.linux: (context) => const LinuxPage(),
      },
    );
  }
}