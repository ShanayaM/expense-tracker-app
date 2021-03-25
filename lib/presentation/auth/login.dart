import 'package:expense_tracker_app/auth/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:yeet/yeet.dart';

class LoginPage extends HookWidget {
  LoginPage({Key? key}) : super(key: key);

  final TextStyle textStyle = TextStyle(fontSize: 20.0);

  @override
  Widget build(BuildContext context) {
    final authState = useProvider(authBlocProvider.state);
    final authBloc = useProvider(authBlocProvider);

    final emailField = TextField(
      style: textStyle,
      decoration: InputDecoration(
          labelText: "Email",
          hintText: "Enter a valid Email ID",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );

    final passwordField = TextField(
      style: textStyle,
      obscureText: true,
      decoration: InputDecoration(
          labelText: "Password",
          hintText: "Enter a secure password",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
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
          Fluttertoast.showToast(
              msg: "Welcome back, ${user.userName}!",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              backgroundColor: Colors.grey,
              textColor: Colors.white,
              fontSize: 16.0);
          return Text('success');
        }),
        unauthenticated: () => Center(
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(36.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 45),
                  emailField,
                  SizedBox(height: 25.0),
                  passwordField,
                  SizedBox(height: 35.0),
                  Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.circular(30.0),
                    child: MaterialButton(
                      minWidth: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      elevation: 5.0,
                      color: Colors.green,
                      onPressed: () async {
                        authBloc.loginBtnPressed();
                        Fluttertoast.showToast(
                            msg: "Welcome back!",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            backgroundColor: Colors.grey,
                            textColor: Colors.white,
                            fontSize: 16.0);
                        context.yeet('/menu');
                        // } else {
                        //   Fluttertoast.showToast(
                        //       msg: "Please try again...",
                        //       toastLength: Toast.LENGTH_SHORT,
                        //       gravity: ToastGravity.CENTER,
                        //       backgroundColor: Colors.grey,
                        //       textColor: Colors.white,
                        //       fontSize: 16.0);
                        // }
                      },
                      child: Text("Login",
                          textAlign: TextAlign.center,
                          style: textStyle.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Text('New User? Create an Account!')
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
