import 'package:expense_tracker_app/application/expense/expense.dart';
import "package:flutter/material.dart";
import "package:intl/intl.dart";

class ExpenseList extends StatelessWidget {
  final List<Expense> expenses;
  final Function deleteExpense;
  // final Function editExpense;

  ExpenseList(this.expenses, this.deleteExpense);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          height: 800,
          child: ListView.builder(
            itemBuilder: (ctx, index) {
              return Card(
                  margin: EdgeInsets.fromLTRB(10, 5, 0, 10),
                  elevation: 5,
                  child: ListTile(
                      onTap: () {},
                      leading: CircleAvatar(
                          radius: 30,
                          backgroundColor: Theme.of(context).accentColor,
                          child: Padding(
                            padding: EdgeInsets.all(6),
                            child: FittedBox(
                                child: Text(
                              "${expenses[index].amount}€",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            )),
                          )),
                      title: Text(
                        expenses[index].expenseName,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      subtitle:
                          Text(DateFormat.yMMMd().format(expenses[index].date)),
                      trailing: Column(
                        children: [
                          Flexible(
                            fit: FlexFit.tight,
                            child: IconButton(
                              color: Colors.black,
                              icon: new Icon(
                                Icons.edit,
                              ),
                              onPressed:
                                  () {}, //=> editExpense(expenses[index].id),
                            ),
                          ),
                          Flexible(
                            fit: FlexFit.tight,
                            child: IconButton(
                                color: Colors.black,
                                icon: new Icon(Icons.delete),
                                onPressed: () =>
                                    deleteExpense(expenses[index].id)),
                          ),
                        ],
                      )));
            },
            itemCount: expenses.length,
          )),
    );
  }
}
