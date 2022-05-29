import 'package:flutter/material.dart';

class CantGetGeo extends StatelessWidget {
  const CantGetGeo({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.location_off),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Нет сети"),
          ),
        ],
      ),
    );
  }
}