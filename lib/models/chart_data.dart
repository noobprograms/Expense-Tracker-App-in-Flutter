import 'dart:math';

import 'package:expense_app/models/expense.dart';
import 'package:expense_app/models/individual_bar.dart';
import 'package:flutter/material.dart';

class BarData {
  final leisureAmount;
  final workAmount;
  final travelAmount;
  final foodAmount;
  BarData(
      {required this.leisureAmount,
      required this.workAmount,
      required this.travelAmount,
      required this.foodAmount});
  double get highestAmount {
    return [leisureAmount, workAmount, travelAmount, foodAmount]
        .reduce((value, element) => value > element ? value : element);
  }

  List<IndividualBar> barDataList = [];
  void initializeData() {
    barDataList = [
      IndividualBar(x: 0, Y: leisureAmount),
      IndividualBar(x: 1, Y: workAmount),
      IndividualBar(x: 2, Y: travelAmount),
      IndividualBar(x: 3, Y: foodAmount),
    ];
  }
}
