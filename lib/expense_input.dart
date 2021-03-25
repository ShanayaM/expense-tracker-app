import "package:flutter/material.dart";
import "package:intl/intl.dart";

class ExpenseInput extends StatefulWidget {
  final Function addTx;

  ExpenseInput(this.addTx);

  @override
  ExpenseInputState createState() => ExpenseInputState();
}

class ExpenseInputState extends State<ExpenseInput> {
  String? titleInput;
  String? amountInput;

  final textController = TextEditingController();
  final amountController = TextEditingController();
  DateTime? dateSelector;

  // @override
  // void initState() {
  //   super.initState();
  //   textController.addListener(() {

  //   });
  //   amountController.addListener(() {});
  // }

  void submitData() {
    final titleText = textController.text;
    final amountText = double.parse(amountController.text);

    if (titleText.isEmpty || amountText <= 0) {
      return;
    }

    widget.addTx(titleText, amountText, dateSelector);
    Navigator.of(context).pop();
  }

  void _datePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        dateSelector = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(labelText: 'Expense'),
                controller: textController,
                onChanged: (value) {
                  titleInput = value;
                },
                onSubmitted: (_) => submitData,
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Amount'),
                controller: amountController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => submitData,
              ),
              Container(
                  height: 70,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                            child: Text(dateSelector == null
                                ? "Please select a date"
                                : "Date selected: ${DateFormat.yMMMd().format(dateSelector!)}")),
                        new Builder(
                            builder: (context) => new MaterialButton(
                                onPressed: _datePicker,
                                textColor: Theme.of(context).primaryColor,
                                child: Text(
                                  'Choose Date',
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontWeight: FontWeight.bold),
                                )))
                      ])),
              ElevatedButton(
                child: Text('Add Expense'),
                style: ElevatedButton.styleFrom(
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0),
                  ),
                ),
                onPressed: submitData,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
