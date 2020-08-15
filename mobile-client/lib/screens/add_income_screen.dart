import 'package:budget_app/models/category_model.dart';
import 'package:budget_app/provider/budget_data.dart';
import 'package:budget_app/utilities/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:budget_app/utilities/constants.dart' as Constant;
import 'package:budget_app/utilities/styles.dart' as Style;
import 'package:provider/provider.dart';

class AddIncome extends StatefulWidget {
  @override
  _AddIncomeState createState() => _AddIncomeState();
}

class _AddIncomeState extends State<AddIncome> {
  final GlobalKey<FormState> _addIncomeFormKey = GlobalKey<FormState>();
  final TextEditingController _incomeAmountController = TextEditingController();
  Category newSelectedCategory;

  @override
  Widget build(BuildContext context) {
    Constant.screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: CustomAppBar(
        title: "Add Income",
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
                key: _addIncomeFormKey,
                child: CustomAdditionTextField(
                  validator: (String amount) {},
                  controller: _incomeAmountController,
                  hintText: 'Amount',
                  textStyle:
                      Style.heading2Text.copyWith(color: Style.backgroundColor),
                  hintStyle: Style.heading3Text.copyWith(
                    color: Style.themeGrey,
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
              Spacer(),
              Text(
                'Select Category',
                style:
                    Style.labelText.copyWith(color: Style.alternateTextColor),
              ),
              SizedBox(
                height: 8,
              ),
              CategoryDropdownButton(
                category: newSelectedCategory ?? transport,
                onTap: () async {
                  Category selected = await showModalBottomSheet<Category>(
                      isDismissible: false,
                      context: context,
                      builder: (context) => CustomDropdown());
                  setState(() {
                    newSelectedCategory = selected;
                  });
                },
              ),
              Spacer(
                flex: 3,
              ),
              CustomMediumSizedButton(
                label: "Add to records",
                onTap: () {
                  Provider.of<BudgetData>(context, listen: false).addNewIncome(
                      _incomeAmountController.text.trim(),
                      newSelectedCategory ?? transport);
                  Navigator.pop(context);
                },
              ),
              Spacer(
                flex: 3,
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
