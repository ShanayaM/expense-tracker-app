import "package:flutter/material.dart";
import 'invoice.dart';
import 'invoice_input.dart';
import 'chart.dart';
import 'invoice_list.dart';

class MyInvoices extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyInvoices> {
  final List<Invoice> invoice = [];

  List<Invoice> get _recentInvoices {
    return invoice.where((invoice) {
      return invoice.date.isAfter(DateTime.now().subtract(Duration(days: 30)));
    }).toList();
  }

  void _addNewInvoice(String vendor, double amount, DateTime dateSelector) {
    final newInvoice = Invoice(
        id: DateTime.now().toString(),
        vendor: vendor,
        amount: amount,
        date: dateSelector);

    setState(() {
      invoice.add(newInvoice);
    });
  }

  void _deleteInvoice(String id) {
    setState(() {
      invoice.removeWhere((element) => element.id == id);
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
                            return InvoiceInput(_addNewInvoice);
                          });
                    }),
              ]),
          body: SingleChildScrollView(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                Chart(_recentInvoices),
                InvoiceList(invoice, _deleteInvoice),
              ])),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: Builder(
            builder: (context) => FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () {
                showModalBottomSheet<void>(
                    context: context,
                    builder: (context) {
                      return InvoiceInput(_addNewInvoice);
                    });
              },
            ),
          ),
        ),
      ),
    );
  }
}
