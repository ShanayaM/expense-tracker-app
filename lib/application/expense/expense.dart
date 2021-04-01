class Expense {
  String id;
  String expenseName;
  double amount;
  DateTime date;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'expenseName': expenseName,
      'amount': amount,
      'date': date,
    };
  }

  Expense({
    required this.id,
    required this.expenseName,
    required this.amount,
    required this.date,
  });

  @override
  String toString() {
    return 'Expense{id: $id, name: $expenseName, amount: $amount, date: $date}';
  }
}
