import "package:flutter/foundation.dart";

class Invoice {
  @required
  String id;
  @required
  String vendor;
  @required
  double amount;
  @required
  DateTime date;

  Invoice(
      {required this.id,
      required this.vendor,
      required this.amount,
      required this.date});
}
