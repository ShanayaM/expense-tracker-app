import "package:flutter/material.dart";
import 'expense.dart';
import 'expense_input.dart';
// import 'chart.dart';
import 'expense_list.dart';

class MyExpenses extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyExpenses> {
  final List<Expense> expense = [];

  List<Expense> get _recentExpenses {
    return expense.where((expense) {
      return expense.date.isAfter(DateTime.now().subtract(Duration(days: 30)));
    }).toList();
  }

  void _addNewExpense(String vendor, double amount, DateTime dateSelector) {
    final newExpense = Expense(
        id: DateTime.now().toString(),
        vendor: vendor,
        amount: amount,
        date: dateSelector);

    setState(() {
      expense.add(newExpense);
    });
  }

  void _deleteExpense(String id) {
    setState(() {
      expense.removeWhere((element) => element.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primaryColor: Colors.purple.shade300,
          accentColor: Colors.purple.shade500,
          fontFamily: 'QuickSand',
          textTheme: ThemeData.light().textTheme.copyWith(
              headline6: TextStyle(fontFamily: 'OpenSans'),
              button: TextStyle(color: Colors.white)),
          appBarTheme: AppBarTheme(
              textTheme: ThemeData.light().textTheme.copyWith(
                  headline6: TextStyle(
                      fontFamily: 'OpenSans',
                      fontSize: 20,
                      fontWeight: FontWeight.bold)))),
      title: "Expense Tracker",
      home: Builder(
        builder: (context) => Scaffold(
          appBar: AppBar(
              title: Text(
                "Expense Tracker",
              ),
              actions: [
                IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      showModalBottomSheet<void>(
                          context: context,
                          builder: (BuildContext bCtx) {
                            return ExpenseInput(_addNewExpense);
                          });
                    }),
              ]),
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                // Chart(_recentExpenses),
                ExpenseList(expense, _deleteExpense),
              ],
            ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          floatingActionButton: Builder(
            builder: (context) => FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () {
                showModalBottomSheet<void>(
                  context: context,
                  builder: (context) {
                    return ExpenseInput(_addNewExpense);
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
