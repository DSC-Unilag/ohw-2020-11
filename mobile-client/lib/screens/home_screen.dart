import 'package:budget_app/screens/add_expense_screen.dart';
import 'package:budget_app/screens/add_income_screen.dart';
import 'package:budget_app/screens/menu_screen.dart';
import 'package:budget_app/screens/profile_screen.dart';
import 'package:budget_app/utilities/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:budget_app/utilities/styles.dart' as Style;
import 'package:flutter_fab_dialer/flutter_fab_dialer.dart';

class HomeScreen extends StatelessWidget {
  fabMenuItems(BuildContext context) {
    return [
      FabMiniMenuItem.withText(
          Icon(Icons.add), Style.darkBlue, 2, "Button menu", () {
        Navigator.push(context, CupertinoPageRoute(
          builder: (context) => AddIncome()
        ));
      }, "New income", Style.darkBlue, Style.themeWhite, false),
      FabMiniMenuItem.withText(
          Icon(Icons.add),
          Style.darkBlue,
          2,
          "Button menu",
          () {
            Navigator.push(context, CupertinoPageRoute(
              builder: (context) => AddExpense()
            ));
          },
          "New expense",
          Style.darkBlue,
          Style.themeWhite,
          false),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FabDialer(
          fabMenuItems(context),
          Style.darkBlue,
          Icon(
            Icons.add,
            color: Style.themeWhite,
          )),
      body: ScreenBackgroundGradient(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(24, 60, 24, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    InkResponse(
                      onTap: () {
                        Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => MenuScreen(),
                            ));
                      },
                      child: Icon(
                        Icons.sort,
                        size: 30,
                        color: Style.themeWhite,
                      ),
                    ),
                    InkResponse(
                      onTap: () {
                        Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => ProfileScreen(),
                            ));
                      },
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Style.themeGrey,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
                Text(
                  "Budgets",
                  style: Style.heading2Text.copyWith(color: Style.themeWhite),
                ),
                SizedBox(
                  height: 24,
                ),
                HomeBudgetCard(),
                ExpenseCard(
                  category: 'Transport',
                  amountRemaining: "50,000",
                  amountSpent: "10,000",
                  percentageLeft: '75',
                ),
                ExpenseCard(
                  category: 'Food',
                  amountRemaining: "70,000",
                  amountSpent: "50,000",
                  percentageLeft: '31',
                ),
                ExpenseCard(
                  category: 'Airtime',
                  amountRemaining: "70,000",
                  amountSpent: "40,000",
                  percentageLeft: '50',
                ),
                ExpenseCard(
                  category: 'Entertainment',
                  amountRemaining: "10,000",
                  amountSpent: "2,000",
                  percentageLeft: '80',
                ),
                ExpenseCard(
                  category: 'Netflix',
                  amountRemaining: "100,000",
                  amountSpent: "20,000",
                  percentageLeft: '80',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
