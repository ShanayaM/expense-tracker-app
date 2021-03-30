import 'package:expense_tracker_app/application/auth/auth_bloc.dart';
import 'package:expense_tracker_app/application/auth/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:yeet/yeet.dart';

class AuthView extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final authState = useProvider(authBlocProvider.state);
    final loginState = useProvider(loginBlocProvider.state);
    final loginBloc = useProvider(loginBlocProvider);

    return Scaffold(
      body: Column(
        children: [
          authState.when(
            loading: () => Center(child: CircularProgressIndicator()),
            authenticated: (user) {
              Future.delayed(Duration(milliseconds: 300)).then((_) {
                context.yeet('/expenses');
              });
              return Center(child: Text('Welcome ${user.id}'));
            },
            unauthenticated: () => Center(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextField(
                      onChanged: (value) {
                        loginBloc.emailChanged(value);
                      },
                      decoration: InputDecoration(
                        errorText: loginState.emailError,
                        border: OutlineInputBorder(),
                        hintText: 'Email',
                      ),
                    ),
                    SizedBox(height: 24),
                    TextField(
                      obscureText: true,
                      onChanged: (value) {
                        loginBloc.passwordChanged(value);
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Password',
                      ),
                    ),
                    SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () {
                        loginBloc.loginPressed();
                      },
                      child: Text('Sign in'),
                    ),
                    SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () {
                        loginBloc.registerPressed();
                      },
                      child: Text('Register'),
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
        ],
      ),
    );
  }
}

// import 'package:expense_tracker_app/application/auth/auth_bloc.dart';
// import 'package:expense_tracker_app/application/auth/login_bloc.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_hooks/flutter_hooks.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:yeet/yeet.dart';
//
// class LoginPage extends HookWidget {
//   final TextStyle textStyle = TextStyle(fontSize: 20.0);
//
//   @override
//   Widget build(BuildContext context) {
//     final authState = useProvider(authBlocProvider.state);
//     final loginState = useProvider(loginBlocProvider.state);
//     final loginBloc = useProvider(loginBlocProvider);
//
//     print('Trying to render login...');
//
//     return Scaffold(
//       body: authState.when(
//         loading: () => Center(child: CircularProgressIndicator()),
//         authenticated: (user) {
//           Future.delayed(Duration(milliseconds: 300)).then((_) {
//             context.yeet('/');
//           });
//           Fluttertoast.showToast(
//               msg: "Welcome back, ${user.id}!",
//               toastLength: Toast.LENGTH_SHORT,
//               gravity: ToastGravity.CENTER,
//               backgroundColor: Colors.grey,
//               textColor: Colors.white,
//               fontSize: 16.0);
//           return;
//         },
//         unauthenticated: () => Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               SizedBox(height: 45),
//               TextField(
//                 onChanged: (value) {
//                   loginBloc.emailChanged(value);
//                 },
//                 style: textStyle,
//                 decoration: InputDecoration(
//                   labelText: "Email",
//                   hintText: "Enter a valid Email ID",
//                   errorText: loginState.emailError,
//                   border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(32.0)),
//                 ),
//               ),
//               SizedBox(height: 25),
//               TextField(
//                 onChanged: (value) {
//                   loginBloc.passwordChanged(value);
//                 },
//                 style: textStyle,
//                 obscureText: true,
//                 decoration: InputDecoration(
//                     labelText: "Password",
//                     hintText: "Enter a secure password",
//                     border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(32.0))),
//               ),
//               SizedBox(height: 35),
//               Material(
//                 elevation: 5.0,
//                 borderRadius: BorderRadius.circular(30.0),
//                 child: MaterialButton(
//                   minWidth: MediaQuery.of(context).size.width,
//                   padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
//                   elevation: 5.0,
//                   color: Colors.green,
//                   child: Text('Register'),
//                   onPressed: () {
//                     loginBloc.registerPressed();
//                   },
//                 ),
//               ),
//               SizedBox(height: 24),
//               TextButton(
//                 onPressed: () {
//                   context.yeet('/reset-pass');
//                 },
//                 child: Text('Forgot Password?'),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
