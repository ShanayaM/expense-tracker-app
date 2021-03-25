import "package:flutter/foundation.dart";

class Expense {
  @required
  String id;
  @required
  String vendor;
  @required
  double amount;
  @required
  DateTime date;

  Expense(
      {required this.id,
      required this.vendor,
      required this.amount,
      required this.date});
}
