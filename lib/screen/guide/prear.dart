import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:travel_in/blocs/attractions/attractions_bloc.dart';
import 'package:travel_in/blocs/attractions/attractions_state.dart';
import 'package:travel_in/components/indicator.dart';
import 'package:travel_in/screen/guide/ar.dart';

class PreARPage extends StatefulWidget {
  final num index;

  const PreARPage({Key key, this.index}) : super(key: key);

  @override
  _PreARPageState createState() => _PreARPageState();
}

class _PreARPageState extends State<PreARPage> {
  @override
  Widget build(BuildContext context) {
    postLoad(widget.index);
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

  void postLoad(index) async {
    if (await Permission.microphone.request().isGranted) {
      if (await Permission.camera.request().isGranted) {
        Image.network('picture_url', cacheWidth: 100, cacheHeight: 100);
        Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => ARPage(index: index),
        ));
      }
    }
  }
}
