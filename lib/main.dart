import 'package:expense_tracker_app/authentication_repository.dart';
import 'package:expense_tracker_app/presentation/summary/chart.dart';
// import 'package:expense_tracker_app/theme.dart';
import 'package:expense_tracker_app/transaction_service.dart';
import 'package:expense_tracker_app/presentation/auth/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:yeet/yeet.dart';

// TODO: Implement back button functionality, database features

void main() async {
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
          Yeet(
            path: '/chart',
            builder: (_, __) => Chart([]),
          ),
          // TODO: Have to implement Pie Chart creation
          // Yeet(
          //   path: '/chart',
          //   builder: (_, __) => Chart(),
          // ),
        ],
      ),
    ],
  );
});

class MyApp extends HookWidget {
  // final bool? isLoggedIn;

  @override
  Widget build(BuildContext context) {
    final yeet = useProvider(yeetProvider);

    return MaterialApp.router(
      title: 'Expense Tracker',
      theme: ThemeData.light(),
      routeInformationParser: YeetInformationParser(),
      routerDelegate: YeeterDelegate(
        //   yeet: isLoggedIn!
        //       ? yeet
        //       : useProvider(
        //           Provider<Yeet>((ref) {
        //             ref.watch(authRepositoryProvider);
        //             return Yeet(path: '/login', builder: (_, __) => LoginPage());
        //           }),
        //         ),
        yeet: yeet,
      ),
    );
  }
}
