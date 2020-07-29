import 'package:flutter/material.dart';
import 'package:budget_app/utilities/styles.dart' as Style;

class ScreenBackgroundGradient extends StatelessWidget {
  ScreenBackgroundGradient({this.child, this.padding});

  final Widget child;
  final EdgeInsetsGeometry padding;
  final _gradientColors = [
    Style.backgroundColor,
    Style.backgroundColor,
    Style.themeWhite,
    Style.themeWhite,
  ];

  @override
  Widget build(BuildContext context) {
    final double fillPercent = 70; // fills 70% for container from bottom
    final double fillStop = (100 - fillPercent) / 100;
    final List<double> stops = [0.0, fillStop, fillStop, 1.0];
    return Container(
      padding: padding,
      child: child,
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
