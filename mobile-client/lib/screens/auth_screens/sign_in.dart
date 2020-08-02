import 'package:budget_app/Toast/toasts.dart';
import 'package:budget_app/network/network.dart';
import 'package:budget_app/screens/home_screen.dart';
import 'package:budget_app/models/user_model.dart';
import 'package:budget_app/utilities/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:budget_app/utilities/styles.dart' as Style;
import 'package:budget_app/utilities/constants.dart' as Constant;

class SignIn extends StatelessWidget {
  final GlobalKey<FormState> _signInFormState = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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
              InkResponse(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.arrow_back,
                  color: Style.themeWhite,
                ),
              ),
              Spacer(),
              Text(
                "Sign in to your account",
                style: Style.heading1Text.copyWith(color: Style.themeWhite),
              ),
              Spacer(),
              Form(
                key: _signInFormState,
                child: Column(
                  children: <Widget>[
                    CustomTextFormField(
                      controller: _usernameController,
                      hintText: 'Username',
                      keyboardType: TextInputType.emailAddress,
                      validator: (String username) {
                        if (username.isEmpty) {
                          return 'Enter your username!!';
                        } else if (username.length < 3) {
                          return 'Username is too short!';
                        } else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    CustomTextFormField(
                      controller: _passwordController,
                      hintText: 'Password ',
                      keyboardType: TextInputType.visiblePassword,
                      validator: (String password) {
                        if (password.length < 6) {
                          return 'Password cannot be less than 6 characters';
                        } else if (password.isEmpty) {
                          return " Enter your password!";
                        } else {
                          return null;
                        }
                      },
                    ),
                  ],
                ),
              ),
              Spacer(),
              CustomLongButton(
                onTap: () async {
                  //String login;
//                  if (_signInFormState.currentState.validate()) {
//                    User loginUser = User(
//                        username: _usernameController.text.trim(),
//                        password: _passwordController.text.trim());
//                    Indicator.loading(context);
//                    try {
//                      login = await Api().signIn(loginUser);
//                    } catch (e) {
//                      print('error caught: ${e.toString()}');
//                    }
//                    Navigator.pop(context);
//                    Indicator.snackBarMessage(
//                        context, login.substring(11, 61) ?? "Sign in failed");
                  Navigator.pushReplacement(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => HomeScreen(),
                      ));
                  //}
                },
                label: 'Sign in',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
