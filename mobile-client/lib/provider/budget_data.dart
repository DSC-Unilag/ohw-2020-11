import 'package:budget_app/models/category_model.dart' as Category;
import 'package:budget_app/models/expenditure_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class BudgetData extends ChangeNotifier {
  double totalBalance = 0.0;
  double totalIncome = 0.0;
  double totalExpense = 0.0;
  List<Expenditure> allExpenditure = [];
  List<Category.Category> allCategories = [
    Category.transport,
    Category.transport,
    Category.transport
  ];

  addNewIncome(String amount, Category.Category category) {
    double newIncomeAmount = double.parse(amount ?? "0");
    totalBalance += newIncomeAmount;
    totalIncome += newIncomeAmount;
    Expenditure newIncome = Expenditure(
        amount: newIncomeAmount,
        type: expenditureType.income,
        category: category);
    allExpenditure.add(newIncome);
    notifyListeners();
  }

  addNewExpense(String amount, Category.Category category) {
    double newExpenseAmount = double.parse(amount ?? "0");
    totalBalance -= newExpenseAmount;
    totalExpense += newExpenseAmount;
    Expenditure newExpense = Expenditure(
        amount: newExpenseAmount,
        type: expenditureType.expense,
        category: category);
    allExpenditure.add(newExpense);
    notifyListeners();
  }

  addNewCategory(Category.Category category) {
    allCategories.add(category);
    notifyListeners();
  }
}
