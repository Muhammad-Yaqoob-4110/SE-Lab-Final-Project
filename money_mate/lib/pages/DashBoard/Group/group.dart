import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:money_mate/config.dart';
import 'package:money_mate/commonWidgets/inpuptWidget.dart';
import 'package:money_mate/commonFunctions/alerts.dart';

class Group extends StatefulWidget {
  final dynamic data;
  const Group({Key? key, required this.data}) : super(key: key);

  @override
  _GroupState createState() => _GroupState();
}

class _GroupState extends State<Group> {
  final Color customColor = AppThemes.theme.primaryColor;
  final Color appColor = AppThemes.theme.secondaryHeaderColor;
  bool showContent = false;
  List<Map<String, dynamic>> groupList = [];
  final TextEditingController _groupNameController = TextEditingController();
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> _addGroupDialog(BuildContext context) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Create a group'),
          content: CustomInputField(
            label: 'Group name',
            icon: Icons.group_add_sharp,
            controller: _groupNameController,
            customColor: customColor,
            appColor: appColor,
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Done'),
              onPressed: () {
                var groupName = _groupNameController.text.trim();
                if (groupName == "") {
                  showCustomGroupNameAlert(context);
                } else {
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> fetchData() async {
    const getGroups = ApiConstants.getAllGroupsByEmailApi;
    var emailForGroup = widget.data["email"];
    // 'http://localhost:4110/api/groups/${widget.data["email"]}'
    try {
      final response = await http.get(
        Uri.parse("$getGroups/$emailForGroup"),
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: customColor,
        title: Text('Groups List'),
        automaticallyImplyLeading: false,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              _addGroupDialog(context);
            },
          ),
        ],
      ),
      body: ListView(
        children: [
          DataTable(
            columns: const <DataColumn>[
              DataColumn(label: Text('Name')),
              DataColumn(label: Text('Members')),
              DataColumn(label: Text('Actions')),
            ],
            rows: groupList.map((group) {
              return DataRow(
                // Wrap the DataRow with GestureDetector
                onSelectChanged: (isSelected) {
                  if (isSelected != null && isSelected) {
                    // _dialogBuilder(context);
                    // child: const Text('Open Dialog'),
                  }
                },
                cells: <DataCell>[
                  DataCell(Text(group['name'])),
                  DataCell(Text('${group['members'].join(', ')}')),
                  DataCell(
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            // Add your edit logic here
                          },
                          child: Icon(
                            Icons.edit,
                            color: Colors.blue,
                          ),
                        ),
                        const SizedBox(width: 16),
                        InkWell(
                          onTap: () {
                            // Add your delete logic here
                          },
                          child: Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }).toList(),
          )
        ],
      ),
      backgroundColor: appColor,
    );
  }
}
