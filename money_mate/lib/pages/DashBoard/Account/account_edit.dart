import 'package:flutter/material.dart';
import 'package:money_mate/commonWidgets/inpuptWidget.dart';
import 'package:money_mate/commonWidgets/custom_outlined_button_widget.dart';
import 'package:money_mate/commonFunctions/alerts.dart';
import 'package:money_mate/commonWidgets/container_widget_2.dart';
import 'package:money_mate/api_calls/updateaccount.dart';
import 'package:money_mate/pages/DashBoard/dashboard.dart';
import 'package:money_mate/config.dart';

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
  final Color customColor = AppThemes.theme.primaryColor;
  final Color appColor = AppThemes.theme.secondaryHeaderColor;

  @override
  void initState() {
    super.initState();
    _fullNameController.text = widget.userData["fullName"].toString();
    _passwordController.text = widget.userData["password"].toString();
    _phoneController.text = widget.userData["phoneNo"].toString();
  }

  @override
  Widget build(BuildContext context) {
    double containerWidth = MediaQuery.of(context).size.width * 0.8;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile 📝'),
        backgroundColor: appColor,
      ),
      body: Center(
        child: CustomContainer(
          width: containerWidth,
          borderRadius: 6.0,
          padding: 16.0,
          margin: const EdgeInsets.all(10.0),
          color: Colors.white,
          elevation: 4.0,
          children: <Widget>[
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
                            "${ApiConstants.updateUserApi}/${widget.userData["email"]}",
                        fullName: fullName,
                        password: password,
                        phoneNo: phoneNo,
                      ).then((responseData) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DashBoard(
                              data: responseData["user"],
                              initialIndex: 3,
                            ),
                          ),
                        );
                      }).catchError((error) {
                        showCustomErrorOccured(
                            context, "An error occurred: $error");
                      });
                    }
                  },
                  text: 'SAVE CHANGES',
                  backgroundColor: customColor,
                  textColor: Colors.white,
                  fixedSizeWidth: containerWidth * 0.4,
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
                  fixedSizeWidth: containerWidth * 0.4,
                  fixedSizeHeight: 40,
                ),
              ],
            ),
          ],
        ),
      ),
      backgroundColor: appColor,
    );
  }
}
