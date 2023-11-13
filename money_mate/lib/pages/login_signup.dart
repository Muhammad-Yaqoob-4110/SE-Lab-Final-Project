import 'package:flutter/material.dart';
import 'package:money_mate/commonWidgets/imagetextrow.dart';
import 'package:money_mate/commonWidgets/custombuttonsrow.dart';
import 'package:money_mate/commonWidgets/container_widget_2.dart';
import 'package:money_mate/commonWidgets/inpuptWidget.dart';

import 'package:money_mate/commonWidgets/custom_outlined_button_widget.dart';
import 'package:money_mate/commonWidgets/link_widget.dart';
import 'package:money_mate/commonFunctions/alerts.dart';
import 'package:money_mate/api_calls/loginapi.dart';
import 'package:money_mate/pages/DashBoard/dashboard.dart';

import 'package:money_mate/api_calls/signupapi.dart';

class LoginSignup extends StatefulWidget {
  @override
  _LoginSignupState createState() => _LoginSignupState();
}

class _LoginSignupState extends State<LoginSignup> {
  final TextEditingController _signUpFullNameController =
      TextEditingController();
  final TextEditingController _signUpEmailController = TextEditingController();
  final TextEditingController _signUpPasswordController =
      TextEditingController();
  final TextEditingController _signUpPhoneController = TextEditingController();

  final TextEditingController _loginEmailController = TextEditingController();
  final TextEditingController _loginPasswordController =
      TextEditingController();
  final Color customColor = const Color(0xFF666666);
  final Color appColor = const Color(0xFF64C9AC);
  final String loginUserApi = "http://localhost:4110/api/users/login";
  final String signUpApi = "http://localhost:4110/api/users";

  // Use a variable to track which button is clicked
  bool isLoginButtonClicked = true;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: appColor,
        body: ListView(
          children: [
            const ImageTextRow(
              imagePath: '../assets/logo.png',
              imageHeight: 50.0,
              imageWidth: 50.0,
              text: 'Money Mate',
              textColor: Colors.white,
              fontSize: 24.0,
            ),
            CustomButtonsRow(
              leftButtonText: 'LOGIN',
              rightButtonText: 'SIGN UP',
              textColor: Colors.white70,
              textTabColor: Colors.white,
              // Toggle the button state when clicked
              onLeftButtonPressed: () {
                setState(() {
                  isLoginButtonClicked = true;
                });
              },
              onRightButtonPressed: () {
                setState(() {
                  isLoginButtonClicked = false;
                });
              },
            ),
            // Use Visibility widget to conditionally show/hide content
            Visibility(
              visible: isLoginButtonClicked,
              child: CustomContainer(
                width: 300.0,
                borderRadius: 6.0,
                padding: 16.0,
                margin: const EdgeInsets.all(10.0),
                color: Colors.white,
                elevation: 4.0,
                children: <Widget>[
                  CustomInputField(
                    label: 'Email',
                    icon: Icons.email,
                    controller: _loginEmailController,
                    customColor: customColor,
                    appColor: appColor,
                  ),
                  const SizedBox(height: 16.0),
                  CustomInputField(
                    label: 'Password',
                    icon: Icons.lock,
                    controller: _loginPasswordController,
                    isPassword: true,
                    customColor: customColor,
                    appColor: appColor,
                  ),
                  const SizedBox(height: 6.0),
                  Align(
                    alignment: Alignment.centerRight,
                    child: CustomLinkWidget(
                      text: 'Forget your Password?🤔',
                      customColor: customColor,
                      onTap: () {},
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  CustomOutlinedButton(
                    onPressed: () {
                      var email = _loginEmailController.text.trim();
                      var password = _loginPasswordController.text.trim();

                      if (isValidEmail(email) == false) {
                        showCustomEmailAlert(context);
                      } else if (password == "") {
                        showCustomPaswordAlert(context);
                      } else {
                        loginUserApiCall(
                                apiUrl: loginUserApi,
                                email: email,
                                password: password)
                            .then((responseData) {
                          final message = responseData["message"];
                          if (message == "Authentication successful") {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DashBoard(
                                  data: responseData["data"],
                                ),
                              ),
                            );
                          }
                          showCustomApiResponce(context, message);
                        }).catchError((error) {
                          showCustomErrorOccured(
                              context, "An error occurred: $error");
                        });
                      }
                    },
                    text: 'LOGIN',
                    backgroundColor: customColor,
                    textColor: Colors.white,
                    fixedSizeWidth: double.infinity,
                    fixedSizeHeight: 40,
                  ),
                ],
              ),
            ),
            // SignUp
            Visibility(
              visible: !isLoginButtonClicked,
              child: CustomContainer(
                width: 300.0,
                borderRadius: 6.0,
                padding: 16.0,
                margin: const EdgeInsets.all(10.0),
                color: Colors.white,
                elevation: 4.0,
                children: <Widget>[
                  CustomInputField(
                    label: 'Full Name',
                    icon: Icons.person,
                    controller: _signUpFullNameController,
                    customColor: customColor,
                    appColor: appColor,
                  ),
                  const SizedBox(height: 16.0),
                  CustomInputField(
                    label: 'Email',
                    icon: Icons.email,
                    controller: _signUpEmailController,
                    customColor: customColor,
                    appColor: appColor,
                  ),
                  const SizedBox(height: 16.0),
                  CustomInputField(
                    label: 'Password',
                    icon: Icons.lock,
                    controller: _signUpPasswordController,
                    isPassword: true,
                    customColor: customColor,
                    appColor: appColor,
                  ),
                  const SizedBox(height: 16.0),
                  CustomInputField(
                    label: 'Phone No',
                    icon: Icons.phone,
                    controller: _signUpPhoneController,
                    customColor: customColor,
                    appColor: appColor,
                  ),
                  const SizedBox(height: 20.0),
                  CustomOutlinedButton(
                    onPressed: () {
                      var fullName = _signUpFullNameController.text.trim();
                      var email = _signUpEmailController.text.trim();
                      var password = _signUpPasswordController.text.trim();
                      var phoneNo = _signUpPhoneController.text.trim();
                      if (fullName == "") {
                        showCustomNameAlert(context);
                      } else if (isValidEmail(email) == false) {
                        showCustomEmailAlert(context);
                      } else if (password == "") {
                        showCustomPaswordAlert(context);
                      } else if (isValidPhoneNumber(phoneNo) == false) {
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
                          if (message == "User created successfully") {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DashBoard(
                                  data: responseData["user"],
                                ),
                              ),
                            );
                          }
                          showCustomApiResponce(context, message);
                        }).catchError((error) {
                          showCustomErrorOccured(
                              context, "An error occurred: $error");
                        });
                      }

                      // Your button's onPressed action
                    },
                    text: 'SIGNUP',
                    backgroundColor: customColor,
                    textColor: Colors.white,
                    fixedSizeWidth: double.infinity,
                    fixedSizeHeight: 40,
                  ),
                  const SizedBox(height: 20.0),
                  CustomLinkWidget(
                    text:
                        'By signing up, you accept the Moneymate Terms of Service',
                    customColor: customColor,
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
