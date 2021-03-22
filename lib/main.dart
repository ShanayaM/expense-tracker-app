import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:yeet/yeet.dart';
import 'authentication_repository.dart';
import 'invoice_operations.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

final yeetProvider = Provider<Yeet>((ref) {
  ref.watch(authRepositoryProvider);
  return Yeet(
    children: [
      Yeet(
        path: '/',
        builder: (_, __) => LoginPage(
          title: 'Expense Tracker',
        ),
        children: [
          Yeet(
            path: '/invoices',
            builder: (_, __) => MyInvoices(),
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

class LoginPage extends StatefulWidget {
  LoginPage({Key? key, required this.title}) : super(key: key);

  final String? title;
  final AuthRepository authRepository = UserAuthentication();

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool waiting = false;
  TextStyle textStyle = TextStyle(fontSize: 20.0);

  @override
  Widget build(BuildContext context) {
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
        title: Text(widget.title!),
      ),
      body: Center(
        child: Container(
          color: Colors.white,
          child: waiting
              ? CircularProgressIndicator()
              : Padding(
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
                            setState(() {
                              waiting = true;
                            });
                            final result = await widget.authRepository.login();
                            setState(() {
                              waiting = false;
                            });
                            if (result) {
                              Fluttertoast.showToast(
                                  msg: "Welcome back!",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  backgroundColor: Colors.grey,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                              context.yeet('/invoices');
                            } else {
                              Fluttertoast.showToast(
                                  msg: "Please try again...",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  backgroundColor: Colors.grey,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                            }
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
    );
  }
}
