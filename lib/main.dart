import 'package:expense_tracker_app/authentication_repository.dart';
// import 'package:expense_tracker_app/chart.dart';
import 'package:expense_tracker_app/transaction_operations.dart';
import 'package:expense_tracker_app/presentation/auth/login.dart';
import 'package:expense_tracker_app/presentation/auth/menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:yeet/yeet.dart';

// TODO: Implement back button functionality, database insertion and
// deletion features
void main() {
  runApp(ProviderScope(child: MyApp()));
}

final yeetProvider = Provider<Yeet>((ref) {
  ref.watch(authRepositoryProvider);
  return Yeet(
    children: [
      Yeet(
        path: '/',
        builder: (_, __) => LoginPage(),
        children: [
          Yeet(
            path: '/menu',
            builder: (_, __) => MenuPage(),
            children: [
              Yeet(
                path: '/expenses',
                builder: (_, __) => MyExpenses(),
              ),
              // TODO: Have to implement Pie Chart creation
              // Yeet(
              //   path: '/chart',
              //   builder: (_, __) => Chart(),
              // ),
            ],
          ),
        ],
      ),
    ],
  );
});

class MyApp extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final yeet = useProvider(yeetProvider);
    return MaterialApp.router(
      title: 'Expense Tracker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routeInformationParser: YeetInformationParser(),
      routerDelegate: YeeterDelegate(yeet: yeet),
    );
  }
}
