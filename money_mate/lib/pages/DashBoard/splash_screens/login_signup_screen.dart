import 'package:flutter/material.dart';
import 'package:money_mate/commonWidgets/custom_outlined_button_widget.dart';
import 'package:money_mate/commonWidgets/containerWidget.dart';

class LoginSignupScreen extends StatelessWidget {
  const LoginSignupScreen({Key? key}) : super(key: key);
  final Color customColor = const Color(0xFF666666);
  final Color appColor = const Color(0xFF64C9AC);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MoneyMate'),
        backgroundColor: appColor,
      ),
      body: CustomContainer(children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(23.0),
                border: Border.all(color: Colors.white, width: 2.0),
              ),
              child: Image.asset(
                '../assets/logo.png',
                width: 180.0,
                height: 180.0,
              ),
            ),
            const SizedBox(height: 10.0),
            Text(
              'MoneyMate',
              style: TextStyle(
                color: customColor,
                fontSize: 25.0,
                decoration: TextDecoration.none,
              ),
            ),
          ],
        ),
        Expanded(
          child: Container(
            color: Colors.white,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomOutlinedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('/login');
                  },
                  text: 'LOGIN',
                  backgroundColor: customColor,
                  textColor: Colors.white,
                  fixedSizeWidth: 350.0,
                  fixedSizeHeight: 50,
                ),
                const SizedBox(height: 10.0),
                CustomOutlinedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('/signup');
                  },
                  text: 'SIGNUP',
                  backgroundColor: appColor,
                  textColor: Colors.white,
                  fixedSizeWidth: 350.0,
                  fixedSizeHeight: 50,
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
