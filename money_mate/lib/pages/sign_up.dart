import 'package:flutter/material.dart';
import 'package:money_mate/commonWidgets/inpuptWidget.dart';
import 'package:money_mate/commonWidgets/containerWidget.dart';
import 'package:money_mate/commonWidgets/custom_outlined_button_widget.dart';
import 'package:money_mate/commonWidgets/link_widget.dart';
import 'package:money_mate/commonFunctions/alerts.dart';
import 'package:money_mate/api_calls/signupapi.dart';
import 'package:money_mate/pages/DashBoard/dashboard.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final Color customColor = const Color(0xFF666666);
  final Color appColor = const Color(0xFF64C9AC);
  final String signUpApi = "http://localhost:4110/api/users";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SIGNUP'),
        backgroundColor: const Color(0xFF64C9AC),
      ),
      body:
          // Padding(
          // padding: const EdgeInsets.all(16.0),
          CustomContainer(
        // margin: const EdgeInsets.all(
        //     16.0), // Apply margin to the custom container
        children: [
          CustomInputField(
            label: 'Full Name',
            icon: Icons.person,
            controller: _fullNameController,
            customColor: customColor,
            appColor: appColor,
          ),
          const SizedBox(height: 16.0),
          CustomInputField(
            label: 'Email',
            icon: Icons.email,
            controller: _emailController,
            customColor: customColor,
            appColor: appColor,
          ),
          const SizedBox(height: 16.0),
          CustomInputField(
            label: 'Password',
            icon: Icons.lock,
            controller: _passwordController,
            isPassword: true,
            customColor: customColor,
            appColor: appColor,
          ),
          const SizedBox(height: 16.0),
          CustomInputField(
            label: 'Phone No',
            icon: Icons.phone,
            controller: _phoneController,
            customColor: customColor,
            appColor: appColor,
          ),
          const SizedBox(height: 20.0),
          CustomOutlinedButton(
            onPressed: () {
              var fullName = _fullNameController.text.trim();
              var email = _emailController.text.trim();
              var password = _passwordController.text.trim();
              var phoneNo = _phoneController.text.trim();
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
                  showCustomErrorOccured(context, "An error occurred: $error");
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
            text: 'By signing up, you accept the Moneymate Terms of Service',
            customColor: customColor,
            onTap: () {},
          ),
        ],
      ),
      // ),
    );
  }
}
