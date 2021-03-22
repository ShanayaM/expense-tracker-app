import 'dart:async';
import 'package:hooks_riverpod/hooks_riverpod.dart';

abstract class AuthRepository {
  Future<bool> login();
}

class UserAuthentication extends AuthRepository {
  @override
  Future<bool> login() async {
    await Future.delayed(Duration(seconds: 3));
    return true;
  }
}

final authRepositoryProvider = Provider((_) => UserAuthentication());
