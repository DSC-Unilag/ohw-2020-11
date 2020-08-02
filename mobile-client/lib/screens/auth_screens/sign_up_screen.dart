import 'package:budget_app/Toast/toasts.dart';
import 'package:budget_app/network/network.dart';
import 'package:budget_app/screens/auth_screens/sign_in.dart';
import 'package:budget_app/utilities/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:budget_app/utilities/styles.dart' as Style;
import 'package:budget_app/utilities/constants.dart' as Constant;
import 'package:budget_app/models/user_model.dart';

class SignUp extends StatelessWidget {
  final GlobalKey<FormState> _signUpFormKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final Api api = Api();

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
                "Create an account",
                style: Style.heading1Text.copyWith(color: Style.themeWhite),
              ),
              Spacer(),
              Form(
                key: _signUpFormKey,
                child: Column(
                  children: <Widget>[
                    CustomTextFormField(
                      controller: _firstNameController,
                      hintText: 'First Name ',
                      keyboardType: TextInputType.text,
                      validator: (String firstName) {
                        if (firstName.isEmpty) {
                          return 'Enter your First Name';
                        } else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    CustomTextFormField(
                      controller: _lastNameController,
                      hintText: 'Last Name ',
                      keyboardType: TextInputType.text,
                      validator: (String lastName) {
                        if (lastName.isEmpty) {
                          return 'Enter your Last Name';
                        } else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    CustomTextFormField(
                      controller: _userNameController,
                      hintText: 'username',
                      keyboardType: TextInputType.text,
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
                      controller: _emailController,
                      hintText: 'Email address ',
                      keyboardType: TextInputType.emailAddress,
                      validator: (String email) {
                        if (email.isEmpty) {
                          return " Enter your email address!";
                        } else if (!email.contains('.') ||
                            !email.contains('@')) {
                          return " Enter a valid email!";
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
                    SizedBox(
                      height: 8,
                    ),
                    CustomTextFormField(
                      controller: _confirmPasswordController,
                      hintText: 'Confirm password ',
                      keyboardType: TextInputType.visiblePassword,
                      validator: (String confirmPassword) {
                        if (confirmPassword != _passwordController.text) {
                          return "Passwords do not match";
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
                  if (_signUpFormKey.currentState.validate()) {
                    Indicator.loading(context);
                    User newUser = User(
                      firstName: _firstNameController.text.trim(),
                      lastName: _lastNameController.text.trim(),
                      username: _userNameController.text.trim(),
                      email: _emailController.text.trim(),
                      password: _passwordController.text.trim(),
                      confirmPassword: _passwordController.text.trim(),
                    );
                    try {
                      var signUp = await api.createAccount(newUser);
                      print(signUp.toString());
                      print("done");
                      Navigator.pop(context);
                       Indicator.snackBarMessage(context,
                          "Account successfully created\nPlease check your mail to activate your account");
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => SignIn(),
                          ));
                    } catch (e) {
                      print(e.toString());
                      Navigator.pop(context);
                    }
                  }
                },
                label: 'create account',
              )
            ],
          ),
        ),
      ),
    );
  }
}

///SIGN UP RESPONSE EXAMPLE
//I/flutter (18006): {
// "detail": "account created subject to activation",
// "user_data":{
// "id":8,
// "email":"gabrielolamideakorede@gmail.com",
// "first_name":"Olamide",
// "last_name":"Gabriel"
// }
// }

