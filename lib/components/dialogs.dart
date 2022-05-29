
import 'package:flutter/material.dart';
import 'package:travel_in/screen/auth/auth.dart';

abstract class DialogUtils {
  static Future _showDialogBox(BuildContext context,
      {dismissible: false, Widget child}) {
    return showDialog(
      context: context,
      barrierDismissible: dismissible,
      barrierColor: Color(0xff000000).withOpacity(.3),
      builder: (BuildContext dialogContext) {
        return Dialog(
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: child);
      },
    );
  }

  static Future showAuthDialog(BuildContext context, {dismissible: false}) {
    return _showDialogBox(context,
        dismissible: dismissible, child: AuthPage());
  }
}