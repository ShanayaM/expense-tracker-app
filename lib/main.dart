import 'package:expense_tracker_app/authentication_repository.dart';
import 'package:expense_tracker_app/transaction_service.dart';
import 'package:expense_tracker_app/presentation/auth/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hive/hive.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:yeet/yeet.dart';

// TODO: Implement database login/logout features using Firebase

void main() async {
  Hive.init('/hive');
  runApp(ProviderScope(child: MyApp()));
}

final yeetProvider = Provider<Yeet>((ref) {
  ref.watch(authRepositoryProvider);
  return Yeet(
    children: [
      Yeet(
        path: '/',
        builder: (_, __) => MyExpenses(),
        children: [
          Yeet(
            path: '/login',
            builder: (_, __) => LoginPage(),
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
      theme: ThemeData.light(),
      routeInformationParser: YeetInformationParser(),
      routerDelegate: YeeterDelegate(
        yeet: yeet,
      ),
    );
  }
}
