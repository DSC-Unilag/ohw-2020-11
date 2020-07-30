import 'package:flutter/material.dart';
import 'package:budget_app/utilities/styles.dart' as Style;
import 'package:budget_app/utilities/constants.dart' as Constant;

class ScreenBackgroundGradient extends StatelessWidget {
  ScreenBackgroundGradient({this.child, this.constraints});

  final Widget child;
  final BoxConstraints constraints;
  final _gradientColors = [
    Style.backgroundColor,
    Style.backgroundColor,
    Style.themeWhite,
    Style.themeWhite,
  ];

  @override
  Widget build(BuildContext context) {
    final double fillPercent = 67; // fills 67% for container from bottom
    final double fillStop = (100 - fillPercent) / 100;
    final List<double> stops = [0.0, fillStop, fillStop, 1.0];
    return Container(
      child: child,
      constraints: constraints,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: _gradientColors,
          stops: stops,
          end: Alignment.bottomCenter,
          begin: Alignment.topCenter,
        ),
      ),
    );
  }
}

class HomeBudgetCard extends StatelessWidget {
  const HomeBudgetCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Style.themeWhite,
        borderRadius: BorderRadius.circular(24),
        boxShadow: Constant.boxShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Budget for May",
            style: Style.labelText.copyWith(color: Style.alternateTextColor),
          ),
          Text(
            "N200,000",
            style: Style.heading1Text.copyWith(color: Style.backgroundColor),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "-N5,000 today",
                style: Style.labelText.copyWith(color: Style.themeRed),
              ),
              Container(
                padding: EdgeInsets.all(2),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Style.backgroundColor.withOpacity(0.1)),
                child: Icon(
                  Icons.more_horiz,
                  color: Style.backgroundColor,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

class ExpenseCard extends StatelessWidget {
  const ExpenseCard(
      {Key key,
      @required this.amountRemaining,
      @required this.amountSpent,
      @required this.category,
      @required this.percentageLeft})
      : super(key: key);
  final String category;
  final String percentageLeft;
  final String amountRemaining;
  final String amountSpent;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: 24),
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      decoration: BoxDecoration(
          color: Style.themeWhite,
          borderRadius: BorderRadius.circular(20),
          boxShadow: Constant.boxShadow),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                category,
                style: Style.labelText.copyWith(color: Style.darkBlue),
              ),
              Text(
                'N$amountRemaining',
                style: Style.labelText.copyWith(color: Style.backgroundColor),
              ),
            ],
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
               "$percentageLeft% left",
                style: Style.heading4Text
                    .copyWith(color: Style.alternateTextColor),
              ),
              Text(
                'N$amountSpent spent',
                style: Style.heading4Text
                    .copyWith(color: Style.alternateTextColor),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
