import 'package:budget_app/models/category_model.dart';

class Expenditure {
  double amount;
  expenditureType type;
  Category category;

  Expenditure({this.amount, this.category, this.type});
}

enum expenditureType { income, expense }
