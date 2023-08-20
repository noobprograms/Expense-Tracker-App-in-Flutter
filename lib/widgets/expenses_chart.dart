import 'package:expense_app/models/chart_data.dart';
import 'package:expense_app/models/expense.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ExpensesChart extends StatelessWidget {
  const ExpensesChart(this.expenseData, {super.key});
  final List<Expense> expenseData;
  @override
  Widget build(BuildContext context) {
    BarData myData = BarData(
        leisureAmount:
            ExpensesBucket.fromCategory(expenseData, Category.leisure)
                .totalExpenses,
        workAmount: ExpensesBucket.fromCategory(expenseData, Category.work)
            .totalExpenses,
        travelAmount: ExpensesBucket.fromCategory(expenseData, Category.travel)
            .totalExpenses,
        foodAmount: ExpensesBucket.fromCategory(expenseData, Category.food)
            .totalExpenses);
    myData.initializeData();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        color: Theme.of(context).cardTheme.color,
        width: double.infinity,
        height: 250,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BarChart(
            BarChartData(
                maxY: myData.highestAmount,
                minY: 0,
                gridData: FlGridData(show: false),
                borderData: FlBorderData(show: false),
                titlesData: FlTitlesData(
                  show: true,
                  topTitles:
                      AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  leftTitles:
                      AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  rightTitles:
                      AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, meta) {
                      switch (value.toInt()) {
                        case 0:
                          return Icon(categoryIcons[Category.leisure]);
                        case 1:
                          return Icon(categoryIcons[Category.work]);
                        case 2:
                          return Icon(categoryIcons[Category.travel]);
                        case 3:
                          return Icon(categoryIcons[Category.food]);
                        default:
                          throw Exception("Invalid index");
                      }
                    },
                  )),
                ),
                barGroups: myData.barDataList
                    .map((e) => BarChartGroupData(x: e.x, barRods: [
                          BarChartRodData(
                            toY: e.Y,
                            width: 50,
                            borderRadius: BorderRadius.circular(4),
                            color: Theme.of(context).colorScheme.onSurface,
                          )
                        ]))
                    .toList()),
          ),
        ),
      ),
    );
  }
}
