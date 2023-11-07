import 'package:flutter/material.dart';
import 'package:money_mate/commonWidgets/inpuptWidget.dart';
import 'package:money_mate/commonWidgets/custom_outlined_button_widget.dart';
import 'package:money_mate/commonFunctions/alerts.dart';
import 'package:money_mate/commonWidgets/containerWidget.dart';
import 'package:money_mate/api_calls/updateaccount.dart';
import 'package:money_mate/pages/DashBoard/dashboard.dart';

class EditProfileScreen extends StatefulWidget {
  final dynamic userData;

  EditProfileScreen({required this.userData});

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final Color customColor = const Color(0xFF666666);
  final Color appColor = const Color(0xFF64C9AC);

  @override
  void initState() {
    super.initState();
    _fullNameController.text = widget.userData["fullName"].toString();
    _passwordController.text = widget.userData["password"].toString();
    _phoneController.text = widget.userData["phoneNo"].toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile 📝'),
        backgroundColor: appColor,
      ),
      body: CustomContainer(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Edit Profile!📝',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16.0),
              CustomInputField(
                label: 'Full Name',
                icon: Icons.person,
                controller: _fullNameController,
                customColor: customColor,
                appColor: appColor,
              ),
              const SizedBox(height: 16.0),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomOutlinedButton(
                    onPressed: () {
                      var fullName = _fullNameController.text.trim();
                      var password = _passwordController.text.trim();
                      var phoneNo = _phoneController.text.trim();
                      if (fullName == "") {
                        showCustomNameAlert(context);
                      } else if (password == "") {
                        showCustomPaswordAlert(context);
                      } else if (isValidPhoneNumber(phoneNo) == false) {
                        showCustomPhoneAlert(context);
                      } else {
                        updateUserInformation(
                                apiUrl:
                                    "http://localhost:4110/api/users/${widget.userData["email"]}",
                                fullName: fullName,
                                password: password,
                                phoneNo: phoneNo)
                            .then((responseData) {
                          // showCustomApiResponce(
                          //     context, responseData["message"]);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DashBoard(
                                  data: responseData["user"], initialIndex: 3),
                            ),
                          );
                        }).catchError(
                          (error) {
                            showCustomErrorOccured(
                                context, "An error occurred: $error");
                          },
                        );
                      }
                    },
                    text: 'SAVE CHANGES',
                    backgroundColor: customColor,
                    textColor: Colors.white,
                    fixedSizeWidth: double.infinity,
                    fixedSizeHeight: 40,
                  ),
                  const SizedBox(width: 16.0),
                  CustomOutlinedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    text: 'CANCEL',
                    backgroundColor: appColor,
                    textColor: Colors.white,
                    fixedSizeWidth: double.infinity,
                    fixedSizeHeight: 40,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
