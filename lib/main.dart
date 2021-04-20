import 'package:flutter/material.dart';
import 'package:gogreen/components/LoginPage.dart';
import 'package:gogreen/screens/home_screen.dart';
import 'package:gogreen/screens/input_screen.dart';
import 'package:gogreen/screens/result_screen.dart';

void main() => runApp(GoGreen());

class GoGreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        LoginPage.id: (context) => LoginPage(),
        HomeScreen.id: (context) => HomeScreen(),
        InputScreen.id: (context) => InputScreen(),
        ResultScreen.id: (context) => ResultScreen(),
      },
      initialRoute: LoginPage.id,
    );
  }
}
