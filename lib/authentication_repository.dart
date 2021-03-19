import 'dart:async';

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
