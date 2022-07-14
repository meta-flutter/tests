import 'package:flutter/material.dart';
import 'package:linux_plugins/fragments/plugins/video_player.dart';
import 'package:linux_plugins/navigationDrawer/navigation_drawer.dart';


class VideoPlayerPage extends StatelessWidget {
  static const String routeName = '/videoPlayerPage';

  const VideoPlayerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Video Player"),
        ),
        drawer: const NavigationDrawer(),
        body: const VideoPlayerPluginPage(title: 'Video Player'));
  }
}
