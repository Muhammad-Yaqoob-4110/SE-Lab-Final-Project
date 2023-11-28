// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:moneymate/view/basewidget/button/custom_buttton.dart';
import 'package:moneymate/view/basewidget/textfield/custom_password_textfield.dart';
import 'package:moneymate/view/basewidget/textfield/customtextfield.dart';
import 'package:moneymate/view/screen/auth/widget/custom_tool_bar.dart';
import 'package:moneymate/view/screen/home/home_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus!.unfocus();
      },
      child: Scaffold(
        body: Form(
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 200.0,
                flexibleSpace: CustomAppBar(height: 250),
                automaticallyImplyLeading: false,
              ),
              SliverToBoxAdapter(
                child: Container(
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            border: Border(
                              left: BorderSide(
                                  width: 1,
                                  color:
                                      const Color.fromARGB(255, 210, 210, 210)),
                              right: BorderSide(
                                width: 1,
                                color: Color.fromARGB(255, 210, 210, 210),
                              ),
                              bottom: BorderSide(
                                width: 1,
                                color: Color.fromARGB(255, 210, 210, 210),
                              ),
                            ),
                            color: Colors.white),
                        height: 400,
                        width: 300,
                        child: Column(children: [
                          Container(
                              padding: EdgeInsets.only(left: 10, right: 10),
                              margin: EdgeInsets.only(top: 50),
                              child: CustomTextField(
                                hinttext: "Enter email",
                                controller: _emailController,
                              )),
                          Container(
                            padding:
                                EdgeInsets.only(left: 10, right: 10, top: 10),
                            child: CustomPasswordTextField(
                              hinttext: "Enter Password",
                              controller: _passwordController,
                            ),
                          ),
                          Container(
                            padding:
                                EdgeInsets.only(left: 10, right: 10, top: 30),
                            child: CustomTextButton(
                                text: "Login",
                                onPress: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => HomeScreen()));
                                }),
                          ),
                        ]),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
