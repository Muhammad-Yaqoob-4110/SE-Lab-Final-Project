import 'package:flutter/material.dart';
import 'package:money_mate/config.dart';

class GroupDetailsPage extends StatefulWidget {
  final Map<String, dynamic> groupDetails;

  // Constructor to accept group details
  GroupDetailsPage({required this.groupDetails});

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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            // Toggle the state to show/hide content
            showContent = !showContent;
          });
        },
        child: const Icon(Icons.group_add),
      ),
      body: showContent ? buildContent() : buildPlaceholder(),
    );
  }

  Widget buildContent() {
    // Build your content widget here when FloatingActionButton is clicked
    return Center(
      child: Text("Content when FloatingActionButton is clicked"),
    );
  }

  Widget buildPlaceholder() {
    // Build your placeholder content here when FloatingActionButton is not clicked
    return Center(
      child:
          Text("Placeholder content when FloatingActionButton is not clicked"),
    );
  }
}
