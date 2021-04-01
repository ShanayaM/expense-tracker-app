import 'package:expense_tracker_app/application/auth/auth_bloc.dart';
import 'package:expense_tracker_app/application/auth/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:yeet/yeet.dart';

class AuthView extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final authState = useProvider(authBlocProvider.state);
    final loginState = useProvider(loginBlocProvider.state);
    final loginBloc = useProvider(loginBlocProvider);

    final isMounted = useIsMounted();
    useEffect(() {
      if (isMounted()) {}
    }, []);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          authState.when(
            loading: () => Center(child: CircularProgressIndicator()),
            authenticated: (user) {
              Future.delayed(Duration(milliseconds: 300)).then((_) {
                Fluttertoast.showToast(
                    msg: "Welcome back, ${user.id}!",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.white,
                    textColor: Colors.grey.shade500,
                    fontSize: 16.0);
                context.yeet('/expenses');
              });
              return Center(child: Text(''));
            },
            unauthenticated: () => Expanded(
              flex: 2,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(36.0),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 110,
                          child: CircleAvatar(
                            radius: 50,
                            backgroundImage: ExactAssetImage(
                              'assets/app_icon.png',
                              scale: 0.5,
                            ),
                          ),
                          decoration: new BoxDecoration(
                            shape: BoxShape.circle,
                            border: new Border.all(
                              color: Colors.green,
                              width: 2.0,
                            ),
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(bottom: 15)),
                        TextField(
                          onChanged: (value) {
                            loginBloc.emailChanged(value);
                          },
                          decoration: InputDecoration(
                            errorText: loginState.emailError,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(32.0)),
                            hintText: 'Enter a valid Email ID',
                            labelText: 'Email',
                          ),
                        ),
                        SizedBox(height: 24),
                        TextField(
                          obscureText: true,
                          onChanged: (value) {
                            loginBloc.passwordChanged(value);
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(32.0)),
                            hintText: 'Password',
                            labelText: 'Enter your password',
                          ),
                        ),
                        SizedBox(height: 24),
                        ElevatedButton(
                          onPressed: () {
                            loginBloc.loginPressed();
                          },
                          child: Text('Login!'),
                        ),
                        SizedBox(height: 24),
                        ElevatedButton(
                          onPressed: () {
                            loginBloc.registerPressed();
                          },
                          child: Text('Not a user? Register now!'),
                        ),
                        SizedBox(height: 24),
                        TextButton(
                            onPressed: () {
                              context.yeet('/reset-pass');
                            },
                            child: Text('Forgot password?'))
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
