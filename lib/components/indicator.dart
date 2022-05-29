import 'package:flutter/material.dart';
import 'package:travel_in/constants.dart';

class Indicator {
  static Widget circle = Center(
      child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(
    CColors.dark_grey,
  )));
}
