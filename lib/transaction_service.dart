import 'package:expense_tracker_app/presentation/summary/chart.dart';
import 'package:expense_tracker_app/presentation/summary/expenses_view.dart';
import "package:flutter/material.dart";
import 'expense.dart';
import 'presentation/expense/expense_input.dart';
import 'package:yeet/yeet.dart';
import 'expense_list.dart';
import 'package:hive/hive.dart';

class MyExpenses extends StatefulWidget {
  @override
  _MyExpensesState createState() => _MyExpensesState();
}

class _MyExpensesState extends State<MyExpenses> {
  final List<Expense> expense = [];
  String? selectedKey;

  TextEditingController textController = TextEditingController();

  List<Expense> get _recentExpenses {
    Hive.box('expenses').get('expenses') as List<Expense>;
    return expense.where((expense) {
      return expense.date.isAfter(DateTime.now().subtract(Duration(days: 30)));
    }).toList();
  }

  List<Expense>? getAllExpenses() {
    return Hive.box('expenses').get('expenses') as List<Expense>;
  }

  void _addNewExpense(
      String expenseName, double amount, DateTime dateSelector) {
    final newExpense = Expense(
        id: DateTime.now().toString(),
        expenseName: expenseName,
        amount: amount,
        date: dateSelector);

    setState(() {
      expense.add(newExpense);
      final expenses = getAllExpenses();
      Hive.box('expenses').put('expenses', [newExpense, ...expenses!]);
    });
  }

  void _deleteExpense(String id) {
    setState(() {
      expense.removeWhere((element) => element.id == id);
    });
  }

  void _editExpense(String id) {
    setState(() {
      var ex = expense.singleWhere((element) => element.id == id);
      print(ex);
      final newExpense = Expense(
        id: id,
        expenseName: ex.expenseName,
        amount: ex.amount,
        date: ex.date,
      );

      expense.removeWhere((element) => element.id == id);
      expense.add(newExpense);
    });
  }

  @override
  Widget build(BuildContext context) {
    Hive.openBox('expenses');

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
      home: Builder(
        builder: (context) => Scaffold(
          appBar: AppBar(
            title: Text(
              "Expense Tracker",
            ),
            actions: <Widget>[
              PopupMenuButton<String>(
                onSelected: (value) {
                  switch (value) {
                    case 'Logout':
                      break;
                    case 'View Chart':
                      Chart(_recentExpenses);
                      context.yeet();
                      break;
                  }
                },
                itemBuilder: (BuildContext context) {
                  return {'View Chart', 'Logout'}.map((String choice) {
                    return PopupMenuItem<String>(
                      value: choice,
                      child: Text(choice),
                    );
                  }).toList();
                },
              ),
            ],
          ),
          body: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Container(
                  child: Chart(_recentExpenses),
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  height: 200,
                  child: View(_recentExpenses),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return Container(
                      height: 300,
                      child: ExpenseList(expense, _deleteExpense, _editExpense),
                    );
                  },
                ),
              )
            ],
          ),
          // body: SingleChildScrollView(
          //   child: Column(
          //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //     crossAxisAlignment: CrossAxisAlignment.stretch,
          //     children: <Widget>[
          //       Chart(_recentExpenses),
          //       View(_recentExpenses),
          //       ExpenseList(expense, _deleteExpense, _editExpense),
          //     ],
          //   ),
          // ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          floatingActionButton: Builder(
            builder: (context) => FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () {
                showModalBottomSheet<void>(
                  context: context,
                  builder: (context) {
                    return ExpenseInput(_addNewExpense, _editExpense);
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
