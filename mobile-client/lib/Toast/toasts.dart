import 'package:flutter/material.dart';
import 'package:budget_app/utilities/styles.dart' as Style;
import 'package:fluttertoast/fluttertoast.dart';

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
                backgroundColor: Style.backgroundColor,
              ),
            ),
          ]);
        });
  }

  static snackBarMessage(BuildContext context, String message) {
    FToast(context).showToast(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
          margin: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            color: Style.darkBlue,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            message,
            style: Style.labelText.copyWith(color: Style.themeWhite),
          ),
        ),
        toastDuration: Duration(seconds: 3),
        gravity: ToastGravity.CENTER);
  }
}
