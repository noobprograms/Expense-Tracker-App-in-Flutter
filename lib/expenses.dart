import 'package:expense_app/utils/database_service.dart';
import 'package:expense_app/widgets/expenses_chart.dart';
import 'package:expense_app/widgets/expenses_list/expenses_list.dart';
import 'package:expense_app/models/expense.dart';
import 'package:expense_app/widgets/new_expense.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  DatabaseService db = DatabaseService();
  @override
  void initState() {
    super.initState();
    db.loadData();
  }

  void _registerExpense(Expense exp) {
    setState(() {
      db.registeredExpenses.add(exp);
    });
    db.updateData();
  }

  void _removeExpense(Expense exp) {
    final expenseIndex = db.registeredExpenses.indexOf(exp);
    setState(() {
      db.registeredExpenses.remove(exp);
    });
    db.updateData();
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Removed an expense"),
        action: SnackBarAction(
            label: 'Undo',
            onPressed: () {
              setState(() {
                db.registeredExpenses.insert(expenseIndex, exp);
              });
            }),
      ),
    );
  }

  void showBottomOverlay() {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(10), topLeft: Radius.circular(10))),
      builder: ((context) {
        return NewExpense(_registerExpense);
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    Widget mainContent =
        Center(child: Text('No expenses to display. Maybe add some?'));
    if (db.registeredExpenses.isNotEmpty) {
      mainContent = ExpensesList(db.registeredExpenses, _removeExpense);
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Expenses'),
        actions: [
          IconButton(
            onPressed: showBottomOverlay,
            iconSize: 30,
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: width < 600
          ? Column(
              children: [
                ExpensesChart(db.registeredExpenses),
                Expanded(child: mainContent),
              ],
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: ExpensesChart(db.registeredExpenses)),
                Expanded(child: mainContent),
              ],
            ),
    );
  }
}
