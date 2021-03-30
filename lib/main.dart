import 'package:expense_tracker_app/application/auth/auth_bloc.dart';
import 'package:expense_tracker_app/presentation/auth/auth_view.dart';
import 'package:expense_tracker_app/transaction_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
// import 'package:hive/hive.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:yeet/yeet.dart';

// TODO: Implement hive support

void main() async {
  // Hive.init('/hive');
  // Hive.box('expenses').clear();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ProviderScope(child: MyApp()));
}

final yeetProvider = Provider<Yeet>((ref) {
  final authState = ref.watch(authBlocProvider.state);
  var x = authState.maybeWhen(
    authenticated: (user) => Yeet(
      children: [
        Yeet(
          path: '/',
          builder: (_, __) => MyExpenses(),
        ),
      ],
    ),
    orElse: () => Yeet(
      children: [
        Yeet(
          path: '/',
          builder: (_, __) => AuthView(),
        ),
        Yeet(
          path: '/expenses',
          builder: (_, __) => MyExpenses(),
        ),
      ],
    ),
  );
  return x;
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
