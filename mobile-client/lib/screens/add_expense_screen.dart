import 'package:budget_app/models/category_model.dart';
import 'package:budget_app/provider/budget_data.dart';
import 'package:budget_app/utilities/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:budget_app/utilities/styles.dart' as Style;
import 'package:budget_app/utilities/constants.dart' as Constant;
import 'package:provider/provider.dart';

class AddExpense extends StatefulWidget {
  @override
  _AddExpenseState createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  final GlobalKey<FormState> _addExpenseFormKey = GlobalKey<FormState>();

  final TextEditingController _expenseAmountController =
      TextEditingController();
  Category _selectedCategory;

  @override
  Widget build(BuildContext context) {
    Constant.screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: CustomAppBar(
        title: "Add expense",
      ),
      body: SingleChildScrollView(
        child: Container(
          constraints: BoxConstraints.tight(Constant.screenSize),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 48,
              ),
              Text(
                'Amount',
                style:
                    Style.labelText.copyWith(color: Style.alternateTextColor),
              ),
              SizedBox(
                height: 8,
              ),
              Form(
                key: _addExpenseFormKey,
                child: CustomAdditionTextField(
                  controller: _expenseAmountController,
                  hintText: 'Amount',
                  textStyle:
                      Style.heading2Text.copyWith(color: Style.backgroundColor),
                  hintStyle: Style.heading3Text.copyWith(
                    color: Style.themeGrey,
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
              SizedBox(
                height: 24,
              ),
              Text(
                'Category',
                style:
                    Style.labelText.copyWith(color: Style.alternateTextColor),
              ),
              SizedBox(
                height: 16,
              ),
              CategoryDropdownButton(
                category: _selectedCategory ?? transport,
                onTap: () async {
                  Category selected = await showModalBottomSheet<Category>(
                      isDismissible: false,
                      context: context,
                      builder: (context) => CustomDropdown());
                  setState(() {
                    _selectedCategory = selected;
                  });
                },
              ),
              SizedBox(
                height: 24,
              ),
              Spacer(),
              CustomMediumSizedButton(
                label: "Add to records",
                onTap: () {
                  Provider.of<BudgetData>(context, listen: false).addNewExpense(
                      _expenseAmountController.text.trim(), _selectedCategory);
                  Navigator.pop(context);
                },
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
