import 'dart:async';
import 'package:flutter/material.dart';
import 'package:moneymate/util/images.dart';
import 'package:moneymate/util/text.dart';
import 'package:moneymate/view/screen/auth/login_screen.dart';
// import 'package:splitwise/view/screen/home/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 2),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginScreen())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(Images.logoImage),
              Text(Alltext.moneymate,
                  style: TextStyle(fontSize: 18, color: Colors.green)),
              Padding(
                padding: const EdgeInsets.only(top: 250.0),
                child: Text(Alltext.splashtext),
              ),
            ]),
      ),
    );
  }
}
