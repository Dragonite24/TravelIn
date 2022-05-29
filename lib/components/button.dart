import 'package:flutter/material.dart';
import 'package:travel_in/constants.dart';

class MyButton extends StatelessWidget {
  final String text;
  final bool disabled;
  final VoidCallback onTap;

  const MyButton(
      {Key key,
      @required this.text,
      @required this.onTap,
      this.disabled = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTap,
        child: Container(
            height: 56,
            width: double.infinity,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: disabled ? CColors.light_grey : CColors.dark_grey,
                borderRadius: BorderRadius.circular(15)),
            child: Text(
              text,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            )),
      );
}
