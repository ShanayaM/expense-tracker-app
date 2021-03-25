import 'package:expense_tracker_app/auth/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AuthView extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final authState = useProvider(authBlocProvider.state);
    final authBloc = useProvider(authBlocProvider);

    return Scaffold(
      body: authState.when(
          loading: () => Center(child: CircularProgressIndicator()),
          failed: (failure) => Center(
                child: Text(failure.when(
                  wrongPassword: () => "Incorrect password!",
                  userNotFound: () => 'User doesn\'t exist',
                  generalAuthFailure: () => 'Server error, please try again',
                )),
              ),
          authenticated: (user) => Builder(builder: (context) {
                return Text('Welcome back, ${user.userName}!');
              }),
          unauthenticated: () => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        authBloc.loginBtnPressed();
                      },
                      child: Text('Log in'),
                    ),
                  ],
                ),
              )),
    );
  }
}
