import 'package:flutter/material.dart';

import '../../main.dart';
import '../screens/video_settings.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      children: [
        const DrawerHeader(
            decoration: BoxDecoration(color: Colors.black45),
            child: Text('Menu')),
        // ListTile(
        //   title: const Text('Main'),
        //   onTap: () {
        //     Navigator.push(context,
        //         MaterialPageRoute(builder: (context) => const MyApp()));
        //   },
        // ),
        ListTile(
          title: const Text('Shooting Settings'),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const VideoSettings()));
          },
        ),
      ],
    ));
  }
}
