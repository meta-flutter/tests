import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
import 'package:xdg_directories/xdg_directories.dart' as xdg;

class XdgDirectoriesPage extends StatefulWidget {
  const XdgDirectoriesPage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _XdgDirectoriesPageState createState() => _XdgDirectoriesPageState();
}

class _XdgDirectoriesPageState extends State<XdgDirectoriesPage> {

  final Map<String, String> fakeEnv = <String, String>{};
  late Directory tmpDir;

  String testPath(String subdir) => path.join(tmpDir.path, subdir);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                print('cacheHome: ${xdg.cacheHome.path}');
                print('configHome: ${xdg.configHome.path}');
                print('dataHome: ${xdg.dataHome.path}');
                print('runtimeDir: ${xdg.runtimeDir}');
                print('configDirs: ${xdg.configDirs}');
                print('dataDirs: ${xdg.dataDirs}');
              },
              child: const Text('Get environment values'),
            ),
            ElevatedButton(
              onPressed: () {
                final Set<String> userDirs = xdg.getUserDirectoryNames();
                if (userDirs.isEmpty) {
                  print('userDirs is empty');
                }
                else {
                  for (final String key in userDirs) {
                    print('$key: ${xdg.getUserDirectory(key)}');
                  }
                }
              },
              child: const Text('Get userDirs'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    tmpDir.deleteSync(recursive: true);
    // Stop overriding the environment accessor.
    xdg.xdgEnvironmentOverride = null;
  }
}
