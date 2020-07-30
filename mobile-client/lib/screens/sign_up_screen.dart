import 'package:budget_app/utilities/widgets.dart';
import 'package:flutter/material.dart';
import 'package:budget_app/utilities/styles.dart' as Style;
import 'package:budget_app/utilities/constants.dart' as Constant;

class SignUp extends StatelessWidget {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

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
              CustomTextFormField(
                controller: fullNameController,
                hintText: 'Full Name ',
                keyboardType: TextInputType.text,
              ),
              SizedBox(
                height: 8,
              ),
              CustomTextFormField(
                controller: emailController,
                hintText: 'Email address ',
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(
                height: 8,
              ),
              CustomTextFormField(
                controller: passwordController,
                hintText: 'Password ',
                keyboardType: TextInputType.visiblePassword,
              ),
              Spacer(),
              CustomLongButton(
                onTap: () {
                  //:Todo Implement account creation
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
