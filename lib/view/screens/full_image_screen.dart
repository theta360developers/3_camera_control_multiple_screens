import 'package:flutter/material.dart';
import 'package:panorama/panorama.dart';

class FullImageScreen extends StatelessWidget {
  const FullImageScreen({Key? key, required this.fileUrl}) : super(key: key);
  final String fileUrl;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black54,
        ),
        body: Panorama(child: Image.network(fileUrl)));
  }
}
