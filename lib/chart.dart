import "package:flutter/material.dart";
import 'package:flutter_hooks/flutter_hooks.dart';
import 'expense.dart';
import 'package:pie_chart/pie_chart.dart';
import "package:intl/intl.dart";

class Chart extends HookWidget {
  final List<Expense> recentTransactions;

  Chart(this.recentTransactions);

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );

      double totalSum = 0.0;

      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year) {
          totalSum += recentTransactions[i].amount;
        }
      }

      return {'day': DateFormat.E().format(weekDay), 'amount': totalSum};
    }).reversed.toList();
  }

  double get maxSpending {
    return groupedTransactionValues.fold(0.0, (sum, item) {
      var x = item['amount'].toString();
      return double.parse(x) + sum;
    });
  }

  @override
  Widget build(BuildContext context) {
    final dataMap = <String, double>{};
    for (final map in groupedTransactionValues) {
      dataMap[map['day'].toString()] = map['amount'] as double;
    }

    List<Color> colorList = [
      Color(0xFF58508D),
      Color(0xff003F5C),
      Color(0xffBC5090),
      Color(0xFFEC6B56),
      Color(0xFFFFC154),
      Color(0xffE6F69D),
      Color(0xffAADEA7)
    ];

    print(groupedTransactionValues);

    return Card(
      elevation: 5,
      margin: EdgeInsets.all(5),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Flexible(
              fit: FlexFit.tight,
              child: PieChart(
                dataMap: dataMap,
                chartLegendSpacing: 30,
                chartRadius: MediaQuery.of(context).size.width / 3.5,
                colorList: colorList,
                initialAngleInDegree: 0,
                chartType: ChartType.ring,
                centerText: maxSpending.toString(),
                ringStrokeWidth: 32,
                legendOptions: LegendOptions(
                  showLegendsInRow: false,
                  legendPosition: LegendPosition.right,
                  showLegends: true,
                  legendShape: BoxShape.circle,
                  legendTextStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                chartValuesOptions: ChartValuesOptions(
                  showChartValueBackground: false,
                  showChartValues: true,
                  showChartValuesInPercentage: false,
                  showChartValuesOutside: true,
                  decimalPlaces: 1,
                  chartValueStyle: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                    backgroundColor: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
