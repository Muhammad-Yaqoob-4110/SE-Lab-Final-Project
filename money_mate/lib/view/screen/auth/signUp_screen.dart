// import 'package:flutter/material.dart';

// class SignUpScreen extends StatefulWidget {
//   const SignUpScreen({super.key});

//   @override
//   State<SignUpScreen> createState() => _SignUpScreenState();
// }

// class _SignUpScreenState extends State<SignUpScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: Column(children: [Text("Sign you")]),
//     );
//   }
// }

// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:moneymate/view/basewidget/button/custom_buttton.dart';
import 'package:moneymate/view/basewidget/textfield/custom_password_textfield.dart';
import 'package:moneymate/view/basewidget/textfield/customtextfield.dart';
import 'package:moneymate/view/screen/auth/widget/custom_tool_bar.dart';
import 'package:moneymate/view/screen/home/home_screen.dart';
import 'package:moneymate/alerts/alerts.dart';
import 'package:moneymate/APIs/signupapi.dart';
import 'package:moneymate/config.dart';

class SignUpScreen extends StatefulWidget {
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _nameController = TextEditingController();
  final _numberController = TextEditingController();
  final String signUpApi = ApiConstants.signUpApi;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus!.unfocus();
      },
      child: Scaffold(
        body: CustomScrollView(
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
                              // validatorMessage: "Enter name",
                              hinttext: "Enter Name",
                              controller: _nameController,
                            )),
                        Container(
                            padding:
                                EdgeInsets.only(left: 10, right: 10, top: 10),
                            // margin: EdgeInsets.only(top: 50),
                            child: CustomTextField(
                              // validatorMessage: "Enter email",
                              hinttext: "Enter email",
                              controller: _emailController,
                            )),
                        Container(
                          padding:
                              EdgeInsets.only(left: 10, right: 10, top: 10),
                          child: CustomPasswordTextField(
                            hinttext: "Enter Password",
                            controller: _passController,
                          ),
                        ),
                        Container(
                          padding:
                              EdgeInsets.only(left: 10, right: 10, top: 10),
                          child: CustomPasswordTextField(
                            hinttext: "Enter Phone",
                            controller: _numberController,
                          ),
                        ),
                        Container(
                          padding:
                              EdgeInsets.only(left: 10, right: 10, top: 30),
                          child: CustomTextButton(
                              text: "Sign up",
                              onPress: () {
                                var fullName = _nameController.text.trim();
                                var email = _emailController.text.trim();
                                var password = _passController.text.trim();
                                var phoneNo = _numberController.text.trim();
                                if (fullName == "") {
                                  showCustomNameAlert(context);
                                } else if (isValidEmail(email) == false) {
                                  showCustomEmailAlert(context);
                                } else if (password == "") {
                                  showCustomPaswordAlert(context);
                                } else if (isValidPhoneNumber(phoneNo) ==
                                    false) {
                                  showCustomPhoneAlert(context);
                                } else {
                                  signupUser(
                                          apiUrl: signUpApi,
                                          fullName: fullName,
                                          email: email,
                                          password: password,
                                          phoneNo: phoneNo)
                                      .then((responseData) {
                                    final message = responseData["message"];
                                    if (message ==
                                        "User created successfully") {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  HomeScreen()));
                                    }
                                    // showCustomApiResponce(context, message);
                                  }).catchError((error) {
                                    showCustomErrorOccured(
                                        context, "An error occurred: $error");
                                  });
                                }
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
    );
  }
}
