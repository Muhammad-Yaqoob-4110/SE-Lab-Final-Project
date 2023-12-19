import 'package:flutter/material.dart';
// import 'package:moneymate/view/screen/home/home_screen.dart';
import 'package:moneymate/config.dart';
import 'package:moneymate/APIs/get_expenses_api.dart';
import 'package:moneymate/APIs/create_expense_api.dart';
import 'package:moneymate/APIs/add_member_api.dart';

enum ActiveTab { Expenses, Members }

class GroupScreen extends StatefulWidget {
  final dynamic group;
  final dynamic data;
  final dynamic token;

  GroupScreen({Key? key, this.group, this.data, this.token}) : super(key: key);

  @override
  _GroupScreenState createState() => _GroupScreenState();
}

class _GroupScreenState extends State<GroupScreen> {
  Color myColor = Color(0xFF4CBB9B);
  List<ItemData> activity = [];
  List<Map<String, dynamic>> jsonData = [];

  ActiveTab _activeTab = ActiveTab.Expenses;
  TextEditingController descriptionController = TextEditingController();
  TextEditingController amountController = TextEditingController();

  TextEditingController emailController = TextEditingController();
  TextEditingController groupNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    var url = '${ApiConstants.getAllExpensesList}/${widget.group['_id']}';
    getExpensesApi(apiUrl: url).then((response) {
      // print(response);
      setState(() {
        jsonData =
            response.expenses.map((expense) => expense.toJson()).toList();
      });
      // print(jsonData);
    });
  }

  @override
  Widget build(BuildContext context) {
    // print(widget.group._id);
    // print(widget.group['members']);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: myColor,
        title: Text("MoneyMate"),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(color: myColor),
          child: Column(
            children: [
              Text(
                widget.group?['name'] ?? 'Default Name',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 18, color: Colors.white),
              ),
              Row(
                children: [
                  Container(
                    height: 20,
                    width: 2,
                    color: Colors.grey,
                  )
                ],
              ),
              Container(
                margin: const EdgeInsets.only(left: 20, right: 20),
                height: 120,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text("You are Own"),
                        Text(
                          "700",
                          style: TextStyle(fontSize: 16),
                        )
                      ],
                    ),
                    Container(
                      height: 60,
                      width: 2,
                      color: const Color.fromARGB(255, 78, 39, 39),
                    ),
                    const Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text("You are lent"),
                        Text(
                          "1500",
                          style: TextStyle(fontSize: 16),
                        )
                      ],
                    ),
                    Container(
                      height: 60,
                      width: 2,
                      color: Colors.grey,
                    ),
                    const Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text("Total Balance"),
                        Text(
                          "1500",
                          style: TextStyle(fontSize: 16),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(top: 20),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50),
                    ),
                    color: Colors.white,
                  ),
                  width: double.infinity,
                  child: DefaultTabController(
                    length: 2,
                    child: Container(
                      padding: const EdgeInsets.only(top: 14),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          TabBar(
                            tabs: const <Widget>[
                              Text("Expenses"),
                              Text("Members"),
                              // Text("Activity"),
                            ],
                            indicatorWeight: 4,
                            onTap: (index) {
                              setState(() {
                                _activeTab = ActiveTab.values[index];
                              });
                            },
                          ),
                          Expanded(
                            child: Container(
                              child: TabBarView(
                                children: [
                                  // add expense Tab
                                  ListView.builder(
                                    itemCount: jsonData.length,
                                    itemBuilder: (context, index) {
                                      final Map<String, dynamic> currentData =
                                          jsonData[index];
                                      String title =
                                          currentData['description'] ?? '';
                                      String amount =
                                          'Rs: ${currentData['amount'] ?? 0.0}';

                                      return Dismissible(
                                        key: Key(currentData['_id']),
                                        onDismissed: (direction) {
                                          setState(() {
                                            jsonData.removeAt(index);
                                          });
                                        },
                                        background: Container(
                                          color: Colors.red,
                                          child: Icon(Icons.delete,
                                              color: Colors.white),
                                          alignment: Alignment.centerRight,
                                          padding: const EdgeInsets.only(
                                              right: 16.0),
                                        ),
                                        child: ListTile(
                                          onTap: () {
                                            print('Item tapped: $title');
                                          },
                                          leading: CircleAvatar(
                                            backgroundColor: Colors.blue,
                                            child: Text(title.isNotEmpty
                                                ? title[0].toUpperCase()
                                                : ""),
                                          ),
                                          title: Text(title),
                                          trailing: Text(amount),
                                        ),
                                      );
                                    },
                                  ),

                                  // add members Tab
                                  ListView.builder(
                                    itemCount: widget.group['members'].length,
                                    itemBuilder: (context, index) {
                                      String title = widget.group['members']
                                              [index]['email'] ??
                                          "";
                                      String initialLetter = title.isNotEmpty
                                          ? title[0].toUpperCase()
                                          : "";

                                      return Dismissible(
                                        key: Key(widget.group['members'][index]
                                                ['_id']
                                            .toString()),
                                        onDismissed: (direction) {
                                          setState(() {
                                            widget.group['members']
                                                .removeAt(index);
                                          });
                                        },
                                        background: Container(
                                          color: Colors.red,
                                          child: Icon(Icons.delete,
                                              color: Colors.white),
                                          alignment: Alignment.centerRight,
                                          padding: const EdgeInsets.only(
                                              right: 16.0),
                                        ),
                                        child: ListTile(
                                          onTap: () {
                                            print('Item tapped: $title');
                                          },
                                          leading: CircleAvatar(
                                            backgroundColor: Colors.blue,
                                            child: Text(initialLetter),
                                          ),
                                          title: Text(title),
                                          trailing: Text(
                                            'Rs: ${widget.group['members'][index]['amount']}',
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return Container(
                padding: EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Additional fields based on the active tab
                    if (_activeTab == ActiveTab.Expenses)
                      TextField(
                        controller: descriptionController,
                        decoration: InputDecoration(labelText: 'Description'),
                      ),
                    if (_activeTab == ActiveTab.Expenses)
                      TextField(
                        controller: amountController,
                        decoration: InputDecoration(labelText: 'Amount'),
                      ),
                    if (_activeTab == ActiveTab.Members)
                      TextField(
                        controller: emailController,
                        decoration:
                            InputDecoration(labelText: "Friend's Email"),
                      ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        // DateTime currentTime = DateTime.now();
                        // ItemData newItem = ItemData(
                        //   timestamp: currentTime,
                        //   // Additional data based on the active tab
                        //   email: _activeTab == ActiveTab.Friends
                        //       ? emailController.text
                        //       : null,
                        //   groupName: _activeTab == ActiveTab.Groups
                        //       ? groupNameController.text
                        //       : null,
                        // );

                        // Conditionally call different APIs based on the active tab
                        if (_activeTab == ActiveTab.Expenses) {
                          const apiUrl = ApiConstants.createExpenseApi;
                          createExpenseApiCall(
                                  apiUrl: apiUrl,
                                  description: descriptionController.text,
                                  amount: int.parse(amountController.text),
                                  paidById: widget.data['_id'],
                                  groupId: widget.group['_id'])
                              .then((response) {
                            // print(response);
                            setState(() {
                              jsonData.add(response['newExpense']);
                            });
                          });
                        } else if (_activeTab == ActiveTab.Members) {
                          var apiUrl =
                              '${ApiConstants.addMemberToGroupApi}/${widget.group['_id']}/members';
                          var em = emailController.text;
                          var tok = widget.token;
                          print(apiUrl);
                          print(em);
                          print(tok);
                          addMemberApiCall(
                            apiUrl: apiUrl,
                            email: em,
                            bearerToken: tok,
                          ).then((response) {
                            print(response);
                            setState(() {
                              widget.group['members'].add(response['member']);
                            });
                          });
                        }

                        descriptionController.clear();
                        amountController.clear();
                        emailController.clear();
                        groupNameController.clear();
                        Navigator.pop(context);
                      },
                      child: Text('Add Item'),
                    ),
                  ],
                ),
              );
            },
          );
        },
        backgroundColor: myColor,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class ItemData {
  final DateTime timestamp;
  final String? email;
  final String? groupName;
  final String? title;
  final String? description;

  ItemData(
      {required this.timestamp,
      this.email,
      this.groupName,
      this.title,
      this.description});
}
