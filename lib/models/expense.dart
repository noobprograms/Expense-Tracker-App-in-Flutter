import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import 'package:hive/hive.dart';
part 'expense.g.dart';

final uuid = Uuid();
final formatter = DateFormat.yMd();

@HiveType(typeId: 2)
enum Category {
  @HiveField(0)
  food,
  @HiveField(1)
  leisure,
  @HiveField(2)
  work,
  @HiveField(3)
  travel
}

const categoryIcons = {
  Category.food: Icons.dining,
  Category.leisure: Icons.movie,
  Category.work: Icons.business_center,
  Category.travel: Icons.flight_takeoff,
};

@HiveType(typeId: 1)
class Expense {
  Expense(this.title, this.amount, this.date, this.category) : id = uuid.v4();
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final double amount;
  @HiveField(3)
  final DateTime date;
  @HiveField(4)
  final Category category;

  String get formattedDate {
    return formatter.format(date);
  }

  Map<String, dynamic> get expenseMap {
    return {
      'title': title,
      'amount': amount,
      'date': date,
      'category': category.name,
    };
  }

  Expense fromExpenseMap(Map<String, dynamic> mp) {
    return Expense(mp['title'], mp['amount'], mp['date'],
        Category.values.byName(mp['category']));
  }
}

class ExpensesBucket {
  ExpensesBucket(this.expenses, this.category);
  ExpensesBucket.fromCategory(List<Expense> allExpenses, this.category)
      : expenses = allExpenses
            .where((element) => element.category == category)
            .toList();
  final List<Expense> expenses;
  final Category category;
  double get totalExpenses {
    double sum = 0;
    for (Expense i in expenses) {
      sum += i.amount;
    }
    return sum;
  }
}
