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

  // Expense.fromMap(Map<String, dynamic> map) {
  //   id = map[this.id];
  //   expenseName = map[this.expenseName];
  //   amount = map[this.amount];
  //   date = map[this.date];
  // }

  @override
  String toString() {
    return 'Expense{id: $id, name: $expenseName, amount: $amount, date: $date}';
  }
}
