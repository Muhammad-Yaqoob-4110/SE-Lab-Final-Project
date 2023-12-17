import 'package:flutter/material.dart';
import 'package:moneymate/alerts/alerts.dart';
import 'package:moneymate/view/basewidget/textfield/custom_password_textfield.dart';
import 'package:moneymate/config.dart';
import 'package:moneymate/APIs/get_all_groups.dart';
import 'package:moneymate/APIs/create_group_api.dart';
// import 'package:moneymate/APIs/groupsClass.dart';

enum ActiveTab { Friends, Groups, Activity }

// List<Map<String, dynamic>> jsonData = [];

class HomeScreen extends StatefulWidget {
  final dynamic token;
  final dynamic data;

  HomeScreen({Key? key, this.data, this.token}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Color myColor = Color(0xFF4CBB9B);
  List<ItemData> items = [];
  List<ItemData> friends = [];
  List<ItemData> groups = [];
  List<ItemData> activity = [];
  List<ItemData> groupsList = [];
  List<Map<String, dynamic>> jsonData = [];
  int? toalExpense;
  @override
  void initState() {
    super.initState();

    const getGroups = ApiConstants.getGroupsByToken;
    var authT = widget.token;

    getGroupsApi(apiUrl: getGroups, bearerToken: authT).then((response) {
      // print(response.totalExpense);
      setState(() {
        toalExpense = response.totalExpense;
        jsonData = response.groups.map((group) => group.toJson()).toList();
      });
    });
  }

  ActiveTab _activeTab = ActiveTab.Friends;
  TextEditingController emailController = TextEditingController();
  TextEditingController groupNameController = TextEditingController();

  // final TextEditingController _paidByController = TextEditingController();
  String selectedMember = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: myColor,
        title: Text("MoneyMate"),
        centerTitle: true,
        actions: [
          Icon(Icons.search),
          PopupMenuButton(
            onSelected: (value) {
              // your logic
            },
            itemBuilder: (BuildContext bc) {
              return const [
                PopupMenuItem(
                  child: Text("Hello"),
                  value: '/hello',
                ),
                PopupMenuItem(
                  child: Text("About"),
                  value: '/about',
                ),
                PopupMenuItem(
                  child: Text("Contact"),
                  value: '/contact',
                )
              ];
            },
          ),
        ],
      ),
      drawer: Drawer(
        backgroundColor: myColor,
        child: Column(
          children: [
            Container(
              height: 200,
              width: double.infinity,
              color: Color.fromARGB(255, 1, 62, 33),
            ),
            ListTile(
              title: Text('Home'),
              leading: Icon(Icons.home),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.payment),
              title: Text("Payment"),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(color: myColor),
          child: Column(
            children: [
              Text(
                widget.data['fullName'],
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, color: Colors.white),
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
                margin: EdgeInsets.only(left: 20, right: 20),
                height: 120,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text("You are Own"),
                        Text(
                          "1500",
                          style: TextStyle(fontSize: 16),
                        )
                      ],
                    ),
                    Container(
                      height: 60,
                      width: 2,
                      color: const Color.fromARGB(255, 78, 39, 39),
                    ),
                    Column(
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
                    Column(
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
                  margin: EdgeInsets.only(top: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50),
                    ),
                    color: Colors.white,
                  ),
                  width: double.infinity,
                  child: DefaultTabController(
                    length: 3,
                    child: Container(
                      padding: EdgeInsets.only(top: 14),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          TabBar(
                            tabs: <Widget>[
                              Text("Friends"),
                              Text("Groups"),
                              Text("Activity"),
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
                                  // Friends Tab
                                  ListView.builder(
                                    itemCount: friends.length,
                                    itemBuilder: (context, index) {
                                      String friend =
                                          friends[index].email ?? "";
                                      String initialLetter = friend.isNotEmpty
                                          ? friend[0].toUpperCase()
                                          : "";

                                      return Dismissible(
                                        key: Key(friends[index]
                                            .timestamp
                                            .toString()),
                                        onDismissed: (direction) {
                                          setState(() {
                                            friends.removeAt(index);
                                          });
                                        },
                                        background: Container(
                                          color: Colors.red,
                                          child: Icon(Icons.delete,
                                              color: Colors.white),
                                          alignment: Alignment.centerRight,
                                          padding: EdgeInsets.only(right: 16.0),
                                        ),
                                        child: ListTile(
                                          onTap: () {
                                            print('Item tapped: $friend');
                                          },
                                          leading: CircleAvatar(
                                            backgroundColor: Colors.blue,
                                            child: Text(initialLetter),
                                          ),
                                          title: Text(friend),
                                          trailing: Text(
                                              'Rs: ${friends[index].email}'),
                                        ),
                                      );
                                    },
                                  ),
                                  // Groups Tab
                                  ListView.builder(
                                    itemCount: jsonData.length,
                                    itemBuilder: (context, index) {
                                      String groupName =
                                          jsonData[index]["name"] ?? "";
                                      String initialLetter =
                                          groupName.isNotEmpty
                                              ? groupName[0].toUpperCase()
                                              : "";

                                      // Replace 'Rs: ${groups[index].groupName}' with the correct field
                                      String groupAmount =
                                          'Rs: ${jsonData[index]["members"][0]["amount"]}';
                                      List<Map<String, dynamic>> members =
                                          jsonData[0]["members"];
                                      for (var member in members) {
                                        if (member["email"] ==
                                            widget.data["email"]) {
                                          // Accessing and printing the amount
                                          groupAmount =
                                              'Rs: ${member["amount"]}';
                                        }
                                      }
                                      return Dismissible(
                                        key: Key(jsonData[index]["createdAt"]
                                            .toString()),
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
                                          padding: EdgeInsets.only(right: 16.0),
                                        ),
                                        child: ListTile(
                                          onTap: () {
                                            // Replace '_addExpenseDialog(context, groups[index]);' with your logic
                                            print('Item tapped: $groupName');
                                          },
                                          leading: CircleAvatar(
                                            backgroundColor: Colors.blue,
                                            child: Text(initialLetter),
                                          ),
                                          title: Text(groupName),
                                          trailing: Text(groupAmount),
                                        ),
                                      );
                                    },
                                  ),
                                  // Activity Tab

                                  // ListView.builder(
                                  //   itemCount: activity.length,
                                  //   itemBuilder: (context, index) {
                                  //     String title = activity[index].title;
                                  //     String initialLetter = title.isNotEmpty
                                  //         ? title[0].toUpperCase()
                                  //         : "";

                                  //     return Dismissible(
                                  //       key: Key(activity[index]
                                  //           .timestamp
                                  //           .toString()),
                                  //       onDismissed: (direction) {
                                  //         setState(() {
                                  //           activity.removeAt(index);
                                  //         });
                                  //       },
                                  //       background: Container(
                                  //         color: Colors.red,
                                  //         child: Icon(Icons.delete,
                                  //             color: Colors.white),
                                  //         alignment: Alignment.centerRight,
                                  //         padding: EdgeInsets.only(right: 16.0),
                                  //       ),
                                  //       child: ListTile(
                                  //         onTap: () {
                                  //           print('Item tapped: $title');
                                  //         },
                                  //         leading: CircleAvatar(
                                  //           backgroundColor: Colors.blue,
                                  //           child: Text(initialLetter),
                                  //         ),
                                  //         title: Text(title),
                                  //         trailing: Text(
                                  //             'Rs: ${activity[index].amount}'),
                                  //       ),
                                  //     );
                                  //   },
                                  // ),
                                  Center(
                                    child: Text("Activity Screen"),
                                  )
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
                    if (_activeTab == ActiveTab.Friends)
                      TextField(
                        controller: emailController,
                        decoration:
                            InputDecoration(labelText: 'Friend\'s Email'),
                      ),
                    if (_activeTab == ActiveTab.Groups)
                      TextField(
                        controller: groupNameController,
                        decoration: InputDecoration(labelText: 'Group Name'),
                      ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        DateTime currentTime = DateTime.now();
                        ItemData newItem = ItemData(
                          timestamp: currentTime,
                          // Additional data based on the active tab
                          email: _activeTab == ActiveTab.Friends
                              ? emailController.text
                              : null,
                          groupName: _activeTab == ActiveTab.Groups
                              ? groupNameController.text
                              : null,
                        );

                        // Conditionally call different APIs based on the active tab
                        if (_activeTab == ActiveTab.Friends) {
                          // Call the friends API
                          callFriendsApi(newItem);
                        } else if (_activeTab == ActiveTab.Groups) {
                          // Call the groups API
                          callGroupsApi(newItem);
                        }

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
        child: Icon(Icons.add),
      ),
    );
  }

  void callFriendsApi(ItemData newItem) {
    // print(newItem.email);
  }

  void callGroupsApi(ItemData newItem) async {
    const apiUrl = ApiConstants.createGroupApi;
    var groupName = newItem.groupName ?? "";
    var bearerToken = widget.token ?? "";
    // print(bearerToken);
    // print(groupName);

    await createGroupApiCall(
            apiUrl: apiUrl, groupName: groupName, bearerToken: bearerToken)
        .then((response) {
      // print(response['group']);
      setState(() {
        jsonData.add(response['group']);
      });
      // print(jsonData);
    });
  }
}

class ItemData {
  final DateTime timestamp;
  final String? email;
  final String? groupName;

  ItemData({
    required this.timestamp,
    this.email,
    this.groupName,
  });
}
