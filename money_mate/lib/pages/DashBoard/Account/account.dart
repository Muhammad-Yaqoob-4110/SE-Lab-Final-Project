import 'package:flutter/material.dart';
import 'package:money_mate/pages/splash_screens/login_signup.dart';
import 'package:money_mate/pages/DashBoard/Account/account_edit.dart';
import 'package:money_mate/commonWidgets/card_widget.dart';
import 'package:money_mate/commonFunctions/email_utils.dart';
import 'package:money_mate/commonWidgets/profile_info.dart';
import 'package:money_mate/config.dart';

class AccountScreen extends StatefulWidget {
  final dynamic data;

  const AccountScreen({Key? key, required this.data}) : super(key: key);

  @override
  _AccountScreenState createState() => _AccountScreenState(data: data);
}

class _AccountScreenState extends State<AccountScreen> {
  final dynamic data;
  final Color customColor = AppThemes.theme.primaryColor;
  final Color appColor = AppThemes.theme.secondaryHeaderColor;
  _AccountScreenState({required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(20),
          child: Column(
            children: [
              Column(
                children: <Widget>[
                  ProfileInfo(
                    text: '${data["fullName"]}',
                    fontSize: 12,
                    textColor: Colors.black,
                    fontWeight: FontWeight.normal,
                  ),
                  const SizedBox(height: 10),
                  ProfileInfo(
                    text: '${data["email"]}',
                    fontSize: 12,
                    textColor: Colors.black,
                    fontWeight: FontWeight.normal,
                  ),
                  const SizedBox(height: 10),
                ],
              ),
              const SizedBox(height: 100),
              CustomOptionCard(
                text: "Edit Profile",
                icon: Icons.edit,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditProfileScreen(userData: data),
                    ),
                  );
                },
                cardColor: customColor,
                textColor: Colors.white,
              ),
              const SizedBox(height: 20),
              CustomOptionCard(
                text: "Contact MoneyMate support",
                icon: Icons.contact_mail,
                onTap: () {
                  EmailUtils.sendEmail(
                    from: data["email"],
                    to: 'my6580861@example.com',
                    subject: 'Feedback for Money Mate',
                    body: 'Here is my feedback:',
                  );
                },
                cardColor: customColor,
                textColor: Colors.white,
              ),
              const SizedBox(height: 20),
              CustomOptionCard(
                text: "Sign Out",
                icon: Icons.logout,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginSignup(),
                    ),
                  );
                },
                cardColor: customColor,
                textColor: Colors.white,
              ),
              const SizedBox(height: 20),
              const Text("Made ✨ by Ahmed Raza, Umm-e-Farwa, Ali Ahmed"),
              const Text("Copyrght © 2021-CS-161, 2021-CS-158, 2021-CS-118"),
            ],
          ),
        ),
      ),
      backgroundColor: appColor,
    );
  }
}
