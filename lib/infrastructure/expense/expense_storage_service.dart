// import 'package:expense_tracker_app/model/expense.dart';
// import 'package:hive/hive.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';

// class SaveExpenseService {
//   SaveExpenseService() {
//     Hive.openBox('expenses');
//   }

//   List<Expense>? getAllExpenses() {
//     return Hive.box('expenses').get('expenses') as List<Expense>;
//   }

//   void addExpense(Expense expense) {
//     final expenses = getAllExpenses();
//     Hive.box('expenses').put('expenses', [expense, ...expenses!]);
//   }
// }

// final saveExpenseServiceProvider = Provider((_) => SaveExpenseService());
