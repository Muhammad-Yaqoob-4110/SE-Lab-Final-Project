import 'package:flutter/material.dart';

enum ActiveTab { Friends, Groups, Activity }

class HomeScreen extends StatefulWidget {
  final dynamic data;

  HomeScreen({Key? key, this.data}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Color myColor = Color(0xFF4CBB9B);
  List<ItemData> items = [];
  List<ItemData> friends = [];
  List<ItemData> groups = [];
  List<ItemData> activity = [];

  ActiveTab _activeTab = ActiveTab.Friends;

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
                                    itemCount: groups.length,
                                    itemBuilder: (context, index) {
                                      String groupName =
                                          groups[index].groupName ?? "";
                                      String initialLetter =
                                          groupName.isNotEmpty
                                              ? groupName[0].toUpperCase()
                                              : "";

                                      return Dismissible(
                                        key: Key(
                                            groups[index].timestamp.toString()),
                                        onDismissed: (direction) {
                                          setState(() {
                                            groups.removeAt(index);
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
                                            print('Item tapped: $groupName');
                                          },
                                          leading: CircleAvatar(
                                            backgroundColor: Colors.blue,
                                            child: Text(initialLetter),
                                          ),
                                          title: Text(groupName),
                                          trailing: Text(
                                              'Rs: ${groups[index].groupName}'),
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
              return AddItemBottomSheet(
                onItemAdded: (ItemData newItem) {
                  switch (_activeTab) {
                    case ActiveTab.Friends:
                      friends.add(newItem);
                      break;
                    case ActiveTab.Groups:
                      groups.add(newItem);
                      break;
                    case ActiveTab.Activity:
                      activity.add(newItem);
                      break;
                  }
                  setState(() {});
                },
                activeTab: _activeTab,
              );
            },
          );
        },
        backgroundColor: myColor,
        child: Icon(Icons.add),
      ),
    );
  }
}

class AddItemBottomSheet extends StatefulWidget {
  final Function(ItemData) onItemAdded;
  final ActiveTab activeTab;

  const AddItemBottomSheet({
    Key? key,
    required this.onItemAdded,
    required this.activeTab,
  }) : super(key: key);

  @override
  _AddItemBottomSheetState createState() => _AddItemBottomSheetState();
}

class _AddItemBottomSheetState extends State<AddItemBottomSheet> {
  TextEditingController emailController = TextEditingController();
  TextEditingController groupNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Additional fields based on the active tab
          if (widget.activeTab == ActiveTab.Friends)
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Friend\'s Email'),
            ),
          if (widget.activeTab == ActiveTab.Groups)
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
                email: widget.activeTab == ActiveTab.Friends
                    ? emailController.text
                    : null,
                groupName: widget.activeTab == ActiveTab.Groups
                    ? groupNameController.text
                    : null,
              );

              widget.onItemAdded(newItem);

              emailController.clear();
              groupNameController.clear();
              Navigator.pop(context);
            },
            child: Text('Add Item'),
          ),
        ],
      ),
    );
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
