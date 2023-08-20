import 'package:expense_app/models/expense.dart';
import 'package:hive_flutter/hive_flutter.dart';

class DatabaseService {
  //creating the registered users list here
  List<Expense> registeredExpenses = [];

  //referencing my box
  final myBox = Hive.box('expenseBox');

  void loadData() {
    if (myBox.get('EXPENSES') == null) {
      registeredExpenses = [];
      return;
    }
    List<dynamic> tempList = [];
    registeredExpenses = myBox.get('EXPENSES')?.cast<Expense>() ?? [];
  }

  void updateData() {
    myBox.put('EXPENSES', registeredExpenses);
  }
}
