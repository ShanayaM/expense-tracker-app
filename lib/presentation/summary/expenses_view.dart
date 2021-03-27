import "package:flutter/material.dart";
import 'package:flutter_hooks/flutter_hooks.dart';
import '../../expense.dart';
import "package:intl/intl.dart";

class View extends HookWidget {
  final List<Expense> recentTransactions;

  View(this.recentTransactions);

  double get todaysSpending {
    var today = DateTime.now();
    double totalSum = 0.0;

    for (var i = 0; i < recentTransactions.length; i++) {
      if (recentTransactions[i].date.day == today.day &&
          recentTransactions[i].date.month == today.month &&
          recentTransactions[i].date.year == today.year) {
        totalSum += recentTransactions[i].amount;
      }
    }
    return totalSum;
  }

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
    return Card(
      margin: EdgeInsets.all(5),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              fit: FlexFit.tight,
              child: Row(
                children: [
                  Wrap(
                    spacing: 100,
                    // crossAxisAlignment: WrapCrossAlignment.center,
                    // alignment: WrapAlignment.center,
                    children: [
                      Column(
                        children: [
                          SizedBox(
                            height: 150,
                            width: 120,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Center(
                                  child: Text(
                                    'Today',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 20,
                                    ),
                                  ),
                                  heightFactor: 2.0,
                                ),
                                Center(
                                  child: Text(
                                    todaysSpending.toString(),
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 20,
                                    ),
                                  ),
                                  heightFactor: 2.0,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 150,
                            width: 120,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Center(
                                  child: Text(
                                    'All time',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 20,
                                    ),
                                  ),
                                  heightFactor: 2.0,
                                ),
                                Center(
                                  child: Text(
                                    maxSpending.toString(),
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 20,
                                    ),
                                  ),
                                  heightFactor: 2.0,
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
