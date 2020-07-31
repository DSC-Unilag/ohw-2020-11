import 'package:flutter/material.dart';

class Indicator {
  static loading(BuildContext context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return SimpleDialog(children: <Widget>[
            Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
              ),
            ),
          ]);
        });
  }
}
