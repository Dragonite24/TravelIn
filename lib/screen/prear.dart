import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:travel_in/screen/ar.dart';

class PreARPage extends StatefulWidget {
  @override
  _PreARPageState createState() => _PreARPageState();
}

class _PreARPageState extends State<PreARPage> {
  @override
  Widget build(BuildContext context) {
    postLoad();
    return Scaffold(
      body: Center(
        child: Text(
          "Открытие камеры...",
          style: TextStyle(color: Colors.white),
        ),
      ),
      backgroundColor: Colors.black,
    );
  }

  void postLoad() async {
    if (await Permission.microphone.request().isGranted) {
      if (await Permission.camera.request().isGranted) {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => ARPage(),
        ));
      }
    }
  }
}
