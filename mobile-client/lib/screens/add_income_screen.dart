import 'package:budget_app/models/category_model.dart';
import 'package:budget_app/provider/budget_data.dart';
import 'package:budget_app/utilities/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:budget_app/utilities/constants.dart' as Constant;
import 'package:budget_app/utilities/styles.dart' as Style;
import 'package:provider/provider.dart';

class AddIncome extends StatelessWidget {
  final GlobalKey<FormState> _addIncomeFormKey = GlobalKey<FormState>();
  final TextEditingController _incomeAmountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Constant.screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          constraints: BoxConstraints.tight(Constant.screenSize),
          child: Column(
            children: <Widget>[
              CustomAppBar(
                title: "Add Income",
              ),
              SizedBox(
                height: 48,
              ),
              Form(
                key: _addIncomeFormKey,
                child: Column(
                  children: [
                    Text(
                      'Amount',
                      style: Style.labelText
                          .copyWith(color: Style.alternateTextColor),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    CustomAdditionTextField(
                      controller: _incomeAmountController,
                      hintText: 'Amount',
                      textStyle: Style.heading2Text
                          .copyWith(color: Style.backgroundColor),
                      hintStyle: Style.heading3Text.copyWith(
                        color: Style.themeGrey,
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    Text(
                      'Category',
                      style: Style.labelText
                          .copyWith(color: Style.alternateTextColor),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    Text(
                      'Description',
                      style: Style.labelText
                          .copyWith(color: Style.alternateTextColor),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    CustomAdditionTextField(
                      hintText: "Description",
                      hintStyle:
                          Style.labelText.copyWith(color: Style.themeGrey),
                      textStyle:
                          Style.heading3Text.copyWith(color: Style.darkBlue),
                      keyboardType: TextInputType.text,
                    ),
                  ],
                ),
              ),
              Spacer(),
              CustomMediumSizedButton(
                label: "Add to records",
                onTap: () {
                  Provider.of<BudgetData>(context, listen: false).addNewIncome(
                      _incomeAmountController.text.trim(), transport);
                  Navigator.pop(context);
                },
              ),
              SizedBox(
                height: 24,
              )
            ],
          ),
        ),
      ),
    );
  }
}
