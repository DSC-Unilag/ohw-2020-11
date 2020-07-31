import 'package:budget_app/utilities/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:budget_app/utilities/styles.dart' as Style;
import 'package:budget_app/utilities/constants.dart' as Constant;

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Constant.screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: ScreenBackgroundGradient(
        fill: 80,
        child: SingleChildScrollView(
          child: Container(
            constraints: BoxConstraints.tight(Constant.screenSize),
            padding: EdgeInsets.fromLTRB(24, 60, 24, 16),
            child: Column(
              children: <Widget>[
                Align(
                  alignment: Alignment.centerLeft,
                  child: InkWell(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.arrow_back,color: Style.themeWhite,
                    size: 30,),
                  ),
                ),
                Stack(
                  children: <Widget>[
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Style.themeWhite,
                          width: 3,
                        ),
                        shape: BoxShape.circle,
                        color: Style.themeGrey,
                      ),
                    ),
                    Transform.translate(
                      offset: Offset(55, 50),
                      child: Container(
                        padding: EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Style.backgroundColor.withOpacity(0.9),
                        ),
                        child: Icon(
                          Icons.add,
                          color: Style.themeWhite,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 44,
                ),
                Text(
                  'Olamide Gabriel',
                  style:
                      Style.heading2Text.copyWith(color: Style.backgroundColor),
                ),
                Text(
                  'thefayemi@gmail.com',
                  style:
                      Style.labelText.copyWith(color: Style.alternateTextColor),
                ),
                Spacer(),
                Text(
                  'Currency',
                  style:
                      Style.labelText.copyWith(color: Style.alternateTextColor),
                ),
                SizedBox(
                  height: 16,
                ),
                DropdownButton(
                  underline: SizedBox(),
                    icon: Transform.rotate(
                      angle: -22/14,
                        child: Icon(Icons.chevron_left,size: 30,color: Style.backgroundColor,)),
                    onTap: () {},
                    items: [
                      DropdownMenuItem(
                        onTap: () {},
                        child: Text(
                          'Naira (NGN)',
                          style: Style.heading2Text
                              .copyWith(color: Color(0xFF4578FB)),
                        ),
                      ),
                    ],
                    onChanged: (string) {}),
                SizedBox(
                  height: 32,
                ),
                Text(
                  'Language',
                  style:
                      Style.labelText.copyWith(color: Style.alternateTextColor),
                ),
                SizedBox(
                  height: 16,
                ),
                DropdownButton(
                    underline: SizedBox(),
                    onTap: () {},
                    items: [
                      DropdownMenuItem(
                        onTap: () {},
                        child: Text(
                          'English (EN)',
                          style: Style.heading2Text
                              .copyWith(color: Color(0xFF4578FB)),
                        ),
                      ),
                    ],
                    onChanged: (string) {}),
                Spacer(
                  flex: 3,
                ),
                CustomShortButton(
                  label: 'Log out',
                  onTap: (){},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
