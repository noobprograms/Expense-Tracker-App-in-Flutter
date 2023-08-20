import 'package:expense_app/models/expense.dart';
import 'package:expense_app/widgets/expenses_list/expense_item.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList(this.expenses, this.removingFunc, {super.key});
  final List<Expense> expenses;
  final void Function(Expense exp) removingFunc;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: expenses.length,
        itemBuilder: (ctx, index) => Dismissible(
            key: ValueKey(expenses[index]),
            onDismissed: (direction) {
              removingFunc(expenses[index]);
            },
            background: Container(
              decoration:
                  BoxDecoration(color: Theme.of(context).colorScheme.error),
            ),
            child: ExpenseItem(expenses[index])));
  }
}
