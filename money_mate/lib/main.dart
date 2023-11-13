import 'package:flutter/material.dart';
import 'package:money_mate/pages/splash_screens/splash_screen.dart';
import 'package:money_mate/pages/splash_screens/login_signup.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(),
      initialRoute: '/', // or any other initial route
      routes: {
        '/': (context) => MoneyMateSplashScreen(),
        '/login-singup-page': (context) => LoginSignup(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
