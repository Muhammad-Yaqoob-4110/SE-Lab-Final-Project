import 'package:flutter/material.dart';
import 'package:money_mate/commonWidgets/inpuptWidget.dart';
import 'package:money_mate/commonWidgets/containerWidget.dart';
import 'package:money_mate/commonWidgets/custom_outlined_button_widget.dart';
import 'package:money_mate/commonWidgets/link_widget.dart';
import 'package:money_mate/commonFunctions/alerts.dart';
import 'package:money_mate/api_calls/loginapi.dart';
import 'package:money_mate/pages/DashBoard/dashboard.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final Color customColor = const Color(0xFF666666);
  final Color appColor = const Color(0xFF64C9AC);
  final String loginUserApi = "http://localhost:4110/api/users/login";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LOGIN'),
        backgroundColor: appColor,
      ),
      body: CustomContainer(
        children: [
          const SizedBox(height: 16.0),
          Text(
            'Welcome back to MoneyMate!😎',
            style: TextStyle(
                fontSize: 24, fontWeight: FontWeight.bold, color: customColor),
            textAlign: TextAlign.center,
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
          const SizedBox(height: 20.0),
          CustomOutlinedButton(
            onPressed: () {
              var email = _emailController.text.trim();
              var password = _passwordController.text.trim();

              if (isValidEmail(email) == false) {
                showCustomEmailAlert(context);
              } else if (password == "") {
                showCustomPaswordAlert(context);
              } else {
                loginUserApiCall(
                        apiUrl: loginUserApi, email: email, password: password)
                    .then((responseData) {
                  final message = responseData["message"];
                  if (message == "Authentication successful") {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DashBoard(
                            data:
                                responseData["data"]), // Pass data to DashBoard
                      ),
                    );
                  }
                  showCustomApiResponce(context, message);
                }).catchError((error) {
                  showCustomErrorOccured(context, "An error occurred: $error");
                });
              }
            },
            text: 'LOGIN',
            backgroundColor: customColor,
            textColor: Colors.white,
            fixedSizeWidth: double.infinity,
            fixedSizeHeight: 40,
          ),
          const SizedBox(height: 20.0),
          CustomLinkWidget(
            text: 'Forget your Password?🤔',
            customColor: customColor,
            onTap: () {},
          ),
        ],
      ),
      // ),
    );
  }
}
