
import 'package:budget_app/utilities/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:budget_app/utilities/styles.dart' as Style;
import 'package:budget_app/utilities/constants.dart' as Constant;

import 'auth_screens/sign_in.dart';
import 'auth_screens/sign_up_screen.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Constant.screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Style.backgroundColor,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.fromLTRB(24, 60, 24, 50),
          constraints: BoxConstraints.tight(Constant.screenSize),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Spacer(
                flex: 3,
              ),
              Text(
                "Welcome to \nBudgito",
                style: Style.heading1Text.copyWith(color: Style.themeWhite),
              ),
              Spacer(),
              CustomLongButton(
                label: 'create account',
                onTap: () {
                  Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => SignUp(),
                      ));
                },
              ),
              CustomLongButton(
                label: 'Sign In',
                onTap: () {
                  Navigator.push(context,
                      CupertinoPageRoute(builder: (context) => SignIn()));
                },
                color: Style.darkBlue,
                labelColor: Style.themeWhite,
              )
            ],
          ),
        ),
      ),
    );
  }
}
