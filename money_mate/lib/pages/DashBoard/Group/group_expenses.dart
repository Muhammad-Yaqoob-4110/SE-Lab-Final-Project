import 'package:flutter/material.dart';
import 'package:money_mate/commonFunctions/alerts.dart';
import 'package:money_mate/config.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:money_mate/commonWidgets/inpuptWidget.dart';
import 'package:money_mate/api_calls/create_expense_api.dart';

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
  List<Map<String, dynamic>> expenseList = [];
  final TextEditingController _discriptionController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  // final TextEditingController _paidByController = TextEditingController();
  String selectedMember = "";

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    const getExpensesApi = ApiConstants.getAllExpensesList;
    var idForGroup = widget.groupDetails["_id"];
    try {
      final response = await http.get(
        Uri.parse("$getExpensesApi/$idForGroup"),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          expenseList = List<Map<String, dynamic>>.from(data['expenses']);
        });
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  Future<void> _addExpenseDialog(BuildContext context) {
    List<dynamic> list = widget.groupDetails["members"] as List<dynamic>;
    String dropdownValue = list.first.toString();
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Create an Expense'),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView(
              shrinkWrap: true,
              children: [
                CustomInputField(
                  label: 'Description',
                  icon: Icons.description,
                  controller: _discriptionController,
                  customColor: customColor,
                  appColor: appColor,
                ),
                const SizedBox(height: 16),
                CustomInputField(
                  label: 'Amount',
                  icon: Icons.money,
                  controller: _amountController,
                  customColor: customColor,
                  appColor: appColor,
                ),
                const SizedBox(height: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Paid By:'),
                    DropdownButton<String>(
                      isDense: true,
                      value: dropdownValue,
                      hint: Text("Select a member"),
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownValue = newValue!;
                        });
                      },
                      items: list.map((dynamic member) {
                        return DropdownMenuItem<String>(
                          value: member.toString(),
                          child: SizedBox(
                            height: 40, // Adjust the height of each item
                            child: Center(child: Text(member.toString())),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ],
            ),
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
                var description = _discriptionController.text.trim();
                var amount = _amountController.text.trim();
                if (description == "") {
                  // print("Click");
                  showDescriptionAlert(context);
                } else if (containsOnlyNumbers(amount) == false) {
                  showAmountAlert(context);
                } else {
                  createExpense(
                          apiUrl: ApiConstants.createExpenseApi,
                          description: description,
                          amount: double.parse(amount),
                          paidBy: dropdownValue,
                          group: widget.groupDetails["_id"])
                      .then((responseData) {
                    print(responseData);
                    final message = responseData["message"];
                    if (message == "Expense Written Successfully") {
                      setState(() {
                        expenseList.add(responseData["newExpense"]);
                      });
                      // print("Reached");
                      _discriptionController.text = "";
                      _amountController.text = "";
                      Navigator.of(context).pop();
                      showCustomApiResponce(context, message);
                    }
                  }).catchError((error) {
                    showCustomErrorOccured(
                        context, "An error occurred: $error");
                  });
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColor,
      appBar: AppBar(
        backgroundColor: customColor,
        title: Text(widget.groupDetails["name"].toString()),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              _addExpenseDialog(context);
            },
          ),
        ],
      ),
      body: ListView(
        children: [
          DataTable(
            columns: const <DataColumn>[
              DataColumn(label: Text('Description')),
              DataColumn(label: Text('Amount')),
              DataColumn(label: Text('Actions')),
            ],
            rows: expenseList.map((expense) {
              return DataRow(
                // Wrap the DataRow with GestureDetector
                // onSelectChanged: (isSelected) {
                //   if (isSelected != null && isSelected) {
                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //         builder: (context) =>
                //             GroupDetailsPage(groupDetails: expense),
                //       ),
                //     );
                //     // print(group);
                //     // _dialogBuilder(context);
                //     // child: const Text('Open Dialog'),
                //   }
                // },
                cells: <DataCell>[
                  DataCell(Text(expense['description'])),
                  DataCell(Text(expense['amount'].toString())),
                  DataCell(
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            // Add your edit logic here
                          },
                          child: Icon(
                            Icons.edit,
                            color: customColor,
                          ),
                        ),
                        const SizedBox(width: 16),
                        InkWell(
                          onTap: () {
                            // Add your delete logic here
                          },
                          child: const Icon(
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
    );
  }
}
