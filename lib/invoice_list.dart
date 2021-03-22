import "package:flutter/material.dart";
import 'invoice.dart';
import "package:intl/intl.dart";

class InvoiceList extends StatelessWidget {
  final List<Invoice> invoices;
  final Function deleteInvoice;

  InvoiceList(this.invoices, this.deleteInvoice);

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
                          "${invoices[index].amount}€",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        )),
                      )),
                  title: Text(
                    invoices[index].vendor,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  subtitle:
                      Text(DateFormat.yMMMd().format(invoices[index].date)),
                  trailing: IconButton(
                    icon: Icon(Icons.delete, color: Colors.red.shade200),
                    onPressed: () {
                      deleteInvoice(invoices[index].id);
                    },
                  ),
                ));
          },
          itemCount: invoices.length,
        ));
  }
}
