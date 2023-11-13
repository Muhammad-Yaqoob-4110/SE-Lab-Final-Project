import 'package:flutter/material.dart';
import 'package:money_mate/config.dart';

class Group extends StatelessWidget {
  final dynamic data;
  final Color customColor = AppThemes.theme.primaryColor;
  final Color appColor = AppThemes.theme.secondaryHeaderColor;

  Group({Key? key, required this.data}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // print(data);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: customColor,
          onPressed: () {
            print('Floating Button Pressed!');
          },
          child: const Icon(Icons.add),
        ),
        backgroundColor: appColor,
      ),
    );
  }
}
