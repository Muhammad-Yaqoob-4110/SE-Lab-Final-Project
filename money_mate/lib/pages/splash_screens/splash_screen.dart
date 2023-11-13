import 'package:flutter/material.dart';
import 'package:money_mate/pages/splash_screens/login_signup.dart';
import 'package:money_mate/config.dart';

class MoneyMateSplashScreen extends StatelessWidget {
  MoneyMateSplashScreen({Key? key}) : super(key: key);
  final Color customColor = AppThemes.theme.primaryColor;
  final Color appColor = AppThemes.theme.secondaryHeaderColor;

  void navigateToNextPage(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => LoginSignup(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    navigateToNextPage(context);

    return Scaffold(
      body: Container(
        margin: const EdgeInsets.all(20.0),
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Image.asset(
              '../assets/logo.png',
              width: 200.0,
              height: 200.0,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                'MoneyMate',
                style: TextStyle(
                  color: appColor,
                  fontSize: 25.0,
                  decoration: TextDecoration.none,
                ),
              ),
            ),
            const Spacer(),
            Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                'Split bills the easy way',
                style: TextStyle(
                  color: appColor,
                  fontSize: 20.0,
                  decoration: TextDecoration.none,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
