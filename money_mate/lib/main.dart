import 'package:flutter/material.dart';
import 'package:money_mate/pages/DashBoard/splash_screens/splash_screen.dart';
import 'package:money_mate/pages/sign_up.dart';
import 'package:money_mate/pages/login.dart';

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
        '/': (context) => const MoneyMateSplashScreen(),
        '/signup': (context) => const SignUp(),
        '/login': (context) => const Login(),
        // '/dashboard': (context) => const DashBoard(),
        // '/signup': (context) => SignUp(),
        // '/dashboard': (context) => DashBoard(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
