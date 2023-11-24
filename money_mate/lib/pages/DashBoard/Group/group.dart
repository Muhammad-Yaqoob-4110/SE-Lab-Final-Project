import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:money_mate/config.dart';

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

  @override
  void initState() {
    super.initState();
    fetchData();
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
              // showUserDialog(null); // Pass null to indicate add mode
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
                    // Add your navigation logic here
                    // For example, you can use Navigator to push a new page
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => AnotherPage()),
                    // );
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
