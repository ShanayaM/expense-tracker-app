import "package:flutter/material.dart";
import 'expense.dart';
import "package:intl/intl.dart";

class ExpenseList extends StatelessWidget {
  final List<Expense> expenses;
  final Function deleteExpense;

  ExpenseList(this.expenses, this.deleteExpense);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 550,
        child: ListView.builder(
          itemBuilder: (ctx, index) {
            return Card(
                margin: EdgeInsets.all(10),
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
                    expenses[index].vendor,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  subtitle:
                      Text(DateFormat.yMMMd().format(expenses[index].date)),
                  trailing: IconButton(
                    icon: Icon(Icons.delete, color: Colors.red.shade200),
                    onPressed: () {
                      deleteExpense(expenses[index].id);
                    },
                  ),
                ));
          },
          itemCount: expenses.length,
        ));
  }
}
