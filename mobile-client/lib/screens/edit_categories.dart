import 'package:budget_app/models/category_model.dart';
import 'package:budget_app/provider/budget_data.dart';
import 'package:budget_app/utilities/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:budget_app/utilities/styles.dart' as Style;
import 'package:budget_app/utilities/constants.dart' as Constant;

class EditCategories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Constant.screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Edit Categories',
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
                itemBuilder: (context, index) {
                  return CategoryCard(
                    category: BudgetData().allCategories[index],
                  );
                },
                separatorBuilder: (context, index) => Divider(),
                itemCount: BudgetData().allCategories.length),
          ),
          CustomMediumSizedButton(
            label: "Add Category",
            onTap: () async {},
          )
        ],
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  CategoryCard({this.category});

  final Category category;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                category.name,
                style: Style.labelText.copyWith(color: Style.darkBlue),
              ),
              SizedBox(
                height: 4,
              ),
              Text(
                category.description,
                style: Style.heading4Text
                    .copyWith(color: Style.alternateTextColor),
              )
            ],
          ),
          InkResponse(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                        contentPadding: EdgeInsets.all(16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        content: Container(
                          height: 110,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: Style.themeWhite,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Are you sure you want to delete the ${category.name} category?',
                                style: Style.labelText.copyWith(
                                  color: Style.darkBlue,
                                ),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  CustomShortButton(
                                    label: "Cancel",
                                    labelColor: Style.backgroundColor,
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    color: Style.themeWhite,
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  CustomShortButton(
                                    label: "Delete",
                                    labelColor: Style.themeWhite,
                                    onTap: () {},
                                    color: Style.themeRed,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ));
            },
            child: Container(
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Style.backgroundColor.withOpacity(0.15)),
              child: Icon(
                Icons.delete_outline,
                size: 25,
                color: Style.backgroundColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
