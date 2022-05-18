import 'package:flutter/material.dart';
import 'package:travel_in/constants.dart';

class MyTextField extends StatelessWidget {
  final String text;
  final TextEditingController controller;

  const  MyTextField({Key key, this.text = "", this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        SizedBox(
          height: 58,
          width: double.infinity,
          child: TextField(
            controller: controller,
            style: const TextStyle(color: CColors.dark_grey),
            decoration: InputDecoration(
              border: InputBorder.none,
              focusColor: CColors.light_grey,
              labelText: text,
              fillColor: CColors.light_grey,
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: CColors.light_grey),
                borderRadius: BorderRadius.circular(15),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: CColors.light_grey),
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
        ),
      ]));
}
