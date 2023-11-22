import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:money_mate/config.dart';
import 'package:money_mate/commonWidgets/container_widget_2.dart';
import 'package:money_mate/commonWidgets/inpuptWidget.dart';
import 'package:money_mate/commonWidgets/custom_outlined_button_widget.dart';
import 'package:money_mate/commonFunctions/alerts.dart';
import 'package:money_mate/api_calls/creategroupapi.dart';
import 'package:money_mate/pages/DashBoard/dashboard.dart';
import 'package:money_mate/pages/DashBoard/Group/groupExpenses.dart';

class Group extends StatefulWidget {
  final dynamic data;
  static final TextEditingController _groupNameController =
      TextEditingController();
  const Group({Key? key, required this.data}) : super(key: key);

  @override
  _GroupState createState() => _GroupState();
}

class _GroupState extends State<Group> {
  final Color customColor = AppThemes.theme.primaryColor;
  final Color appColor = AppThemes.theme.secondaryHeaderColor;
  bool showContent = false;
  List<Map<String, dynamic>> groupList = [];

  @override
  void initState() {
    super.initState();
    // Fetch group data when the widget is loaded
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final response = await http.get(
        Uri.parse('http://localhost:4110/api/groups/${widget.data["email"]}'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          groupList = List<Map<String, dynamic>>.from(data['groups']);
        });
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: customColor,
          onPressed: () {
            setState(() {
              // Toggle the state to show/hide content
              showContent = !showContent;
            });
          },
          child: const Icon(Icons.group_add),
        ),
        backgroundColor: appColor,
        body: showContent ? buildContent() : buildPlaceholder(context),
      ),
    );
  }

  Widget buildContent() {
    // Build your content widget here
    return ListView(
      children: [
        Center(
          child: CustomContainer(
            width: double.infinity,
            borderRadius: 6.0,
            padding: 16.0,
            margin: const EdgeInsets.all(10.0),
            color: Colors.white,
            elevation: 4.0,
            children: <Widget>[
              CustomInputField(
                label: 'Group name',
                icon: Icons.group_add,
                controller: Group._groupNameController,
                customColor: customColor,
                appColor: appColor,
              ),
              const SizedBox(height: 16.0),
              Row(
                children: [
                  CustomOutlinedButton(
                    onPressed: () {
                      var groupName = Group._groupNameController.text.trim();
                      if (groupName == "") {
                        showCustomGroupNameAlert(context);
                      } else {
                        const apiUrl = ApiConstants.createGroupApi;
                        var name = groupName;
                        var creatorEmail = widget.data["email"].toString();

                        createGroupApiCall(
                          apiUrl: apiUrl,
                          groupName: name,
                          creatorEmail: creatorEmail,
                        ).then((responseData) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DashBoard(
                                data: widget.data,
                              ),
                            ),
                          );
                          final message = responseData["message"];
                          showCustomApiResponce(context, message);
                          Group._groupNameController.text = "";
                        }).catchError((error) {
                          showCustomErrorOccured(
                              context, "An error occurred: $error");
                        });
                      }
                    },
                    text: 'Done',
                    backgroundColor: customColor,
                    textColor: Colors.white,
                    fixedSizeWidth: double.infinity,
                    fixedSizeHeight: 40,
                  ),
                  const SizedBox(width: 16.0),
                  CustomOutlinedButton(
                    onPressed: () {
                      setState(() {
                        // Toggle the state to show/hide content
                        showContent = !showContent;
                      });
                    },
                    text: 'Cancel',
                    backgroundColor: customColor,
                    textColor: Colors.white,
                    fixedSizeWidth: double.infinity,
                    fixedSizeHeight: 40,
                  ),
                ],
              )
            ],
          ),
        )
      ],
    );
  }

  Widget buildPlaceholder(BuildContext context) {
    // Build a placeholder widget here
    return Center(
      child: groupList.isNotEmpty
          ? ListView.builder(
              itemCount: groupList.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 4.0,
                  margin: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 16.0),
                  color: customColor, // Set the background color of the Card
                  child: ListTile(
                    onTap: () {
                      // Uncomment the navigation code
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => GroupDetailsPage(
                            // Pass the group details to the next page
                            groupDetails: groupList[index],
                          ),
                        ),
                      );
                    },
                    leading: const Icon(Icons.group_rounded,
                        color: Colors.white), // Set the color of the icon
                    title: Text(
                      groupList[index]['name'],
                      style: const TextStyle(
                          color: Colors.white), // Set the text color
                    ),
                    subtitle: Text(
                      'Members: ${groupList[index]['members'].join(', ')}',
                      style: const TextStyle(
                          color: Colors.white70), // Set the text color
                    ),
                    // Add more details as needed
                  ),
                );
              },
            )
          : const Text('There is no group'),
    );
  }
}
