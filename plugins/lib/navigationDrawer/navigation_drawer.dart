import 'package:flutter/material.dart';
import 'package:linux_plugins/routes/page_route.dart';
import 'package:linux_plugins/widgets/create_drawer_body_item.dart';
import 'package:linux_plugins/widgets/create_drawer_header.dart';

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          createDrawerHeader(),
          createDrawerBodyItem(
            icon: Icons.home,
            text: 'Home',
            onTap: () =>
                Navigator.pushReplacementNamed(context, PageRoutes.home),
          ),
          const Divider(),
          createDrawerBodyItem(
            icon: Icons.directions,
            text: 'Misc',
            onTap: () =>
                Navigator.pushReplacementNamed(
                    context, PageRoutes.misc),
          ),
          createDrawerBodyItem(
            icon: Icons.event_note,
            text: 'Plus Plugins',
            onTap: () =>
                Navigator.pushReplacementNamed(
                    context, PageRoutes.plusPlugins),
          ),
          createDrawerBodyItem(
            icon: Icons.video_stable,
            text: 'Video Player',
            onTap: () =>
                Navigator.pushReplacementNamed(context, PageRoutes.videoPlayer),
          ),
          createDrawerBodyItem(
            icon: Icons.notifications_active,
            text: 'Linux Specific',
            onTap: () =>
                Navigator.pushReplacementNamed(context, PageRoutes.linux),
          ),
          const Divider(),
          ListTile(
            title: const Text('App version 1.0.0'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}