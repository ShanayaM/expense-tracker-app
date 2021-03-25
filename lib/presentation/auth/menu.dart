import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:yeet/yeet.dart';

class MenuPage extends StatelessWidget {
  final buttonRadius = BorderRadius.circular(80);

  final buttonTextStyle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    // foreground: Paint()
    //   ..shader = LinearGradient(
    //     colors: <Color>[
    //       Color(0xffDA44bb),
    //       Color(0xff8921ab),
    //     ],
    //   ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0)),
    color: Colors.white,
  );

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        body: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                MaterialButton(
                  elevation: 5,
                  padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 50.0),
                  onPressed: () {
                    context.yeet('/expenses');
                  },
                  child: Container(
                    width: 300,
                    height: 50,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.teal,
                          Colors.teal.shade200,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: buttonRadius,
                      // boxShadow: [
                      //   BoxShadow(
                      //     color: Colors.black12,
                      //     offset: Offset(5, 5),
                      //     blurRadius: 10,
                      //   )
                      // ],
                    ),
                    child: Center(
                      child: Text(
                        'View past expenses',
                        style: buttonTextStyle,
                      ),
                    ),
                  ),
                ),
                MaterialButton(
                  elevation: 5,
                  padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 50.0),
                  onPressed: () {
                    context.yeet('/expenses');
                  },
                  child: Container(
                    width: 300,
                    height: 50,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.teal,
                          Colors.teal.shade200,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: buttonRadius,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          offset: Offset(5, 5),
                          blurRadius: 10,
                        )
                      ],
                    ),
                    child: Center(
                      child: Text(
                        'Add an expense',
                        style: buttonTextStyle,
                      ),
                    ),
                  ),
                ),
                MaterialButton(
                  elevation: 5,
                  padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  child: Container(
                    width: 300,
                    height: 50,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.teal,
                          Colors.teal.shade200,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: buttonRadius,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          offset: Offset(5, 5),
                          blurRadius: 10,
                        )
                      ],
                    ),
                    child: Center(
                      child: Text(
                        'Create a chart',
                        style: buttonTextStyle,
                      ),
                    ),
                  ),
                  // TODO: Have to implement this
                  onPressed: () {
                    context.yeet('/chart');
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
