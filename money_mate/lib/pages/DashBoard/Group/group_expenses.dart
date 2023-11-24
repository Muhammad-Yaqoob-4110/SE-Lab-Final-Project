import 'package:flutter/material.dart';
import 'package:money_mate/config.dart';
import 'package:money_mate/commonWidgets/custom_appbar.dart';
import 'package:money_mate/commonWidgets/custombuttonsrow.dart';
import 'package:money_mate/commonWidgets/custom_flat_button_with_text.dart';

class GroupDetailsPage extends StatefulWidget {
  final Map<String, dynamic> groupDetails;

  // Constructor to accept group details
  const GroupDetailsPage({required this.groupDetails, super.key});

  @override
  _GroupDetailsPageState createState() => _GroupDetailsPageState();
}

class _GroupDetailsPageState extends State<GroupDetailsPage> {
  final Color customColor = AppThemes.theme.primaryColor;
  final Color appColor = AppThemes.theme.secondaryHeaderColor;
  bool showContent = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColor,
      body: ListView(children: [
      CustomAppBar(title: widget.groupDetails['name']),
      CustomButtonsRow(
          leftButtonText: "Add Member to a group",
          rightButtonText: "Add Expenses",
          textColor: Colors.white,
          textTabColor: customColor,
          onLeftButtonPressed: () {},
          onRightButtonPressed: () {}),
      CustomFlatWButtonWithText(
          icon: Icons.add, text: "Add Expenses", onPressed: () {})
    ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            // Toggle the state to show/hide content
            showContent = !showContent;
          });
        },
        child: const Icon(Icons.group_add),
      ),
      // body: showContent ? buildContent() : buildPlaceholder(),
    );
  }

  Widget buildContent() {
    // Build your content widget here when FloatingActionButton is clicked
    return ListView(children: [
      // CustomAppBar(title: widget.groupDetails['name']),
// CustomFlatWButtonWithText(icon: icon, text: text, onPressed: onPressed)
    ]);
  }

  Widget buildPlaceholder() {
    // Build your placeholder content here when FloatingActionButton is not clicked
    return ListView(children: [
      CustomAppBar(title: widget.groupDetails['name']),
      CustomButtonsRow(
          leftButtonText: "Add Member to a group",
          rightButtonText: "Add Expenses",
          textColor: Colors.white,
          textTabColor: customColor,
          onLeftButtonPressed: () {},
          onRightButtonPressed: () {}),
      CustomFlatWButtonWithText(
          icon: Icons.add, text: "Add Expenses", onPressed: () {})
    ]);
  }
}
