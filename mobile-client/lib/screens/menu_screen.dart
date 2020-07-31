import 'package:budget_app/utilities/widgets.dart';
import 'package:flutter/material.dart';
import 'package:budget_app/utilities/styles.dart' as Style;
import 'package:budget_app/utilities/constants.dart' as Constant;

class MenuScreen extends StatelessWidget {
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
            children: <Widget>[
              Align(
                alignment: Alignment.centerRight,
                child: InkResponse(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.clear,
                    color: Style.themeWhite,
                  ),
                ),
              ),
              Spacer(),
              CircleAvatar(
                radius: 35,
                backgroundColor: Style.themeGrey,
              ),
              SizedBox(
                height: 32,
              ),
              Text(
                'Gabriel Olamide',
                style: Style.heading2Text.copyWith(
                  color: Style.themeWhite,
                ),
              ),
              Spacer(),
              MenuButton(
                onTap: () {},
                label: 'Budgets',
              ),
              MenuButton(
                onTap: () {},
                label: 'Timeline',
              ),
              MenuButton(
                onTap: () {},
                label: 'Statistics',
                pressed: true,
              ),
              Spacer(
                flex: 3,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
