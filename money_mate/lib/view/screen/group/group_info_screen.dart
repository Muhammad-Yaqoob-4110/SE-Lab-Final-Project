import 'package:flutter/material.dart';
import 'package:moneymate/view/screen/home/home_screen.dart';

enum ActiveTab { Members, Expenses }

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

  ActiveTab _activeTab = ActiveTab.Members;
  TextEditingController emailController = TextEditingController();
  TextEditingController groupNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    print(widget.group);
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
                widget.data?['fullName'] ?? 'Default Name',
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
                              Text("Members"),
                              Text("Expenses"),
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
                                  // add members Tab
                                  ListView.builder(
                                    itemCount: activity.length,
                                    itemBuilder: (context, index) {
                                      String title =
                                          activity[index].email ?? "";
                                      String initialLetter = title.isNotEmpty
                                          ? title[0].toUpperCase()
                                          : "";

                                      return Dismissible(
                                        key: Key(activity[index]
                                            .timestamp
                                            .toString()),
                                        onDismissed: (direction) {
                                          setState(() {
                                            activity.removeAt(index);
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
                                          trailing: const Text(
                                            'Rs: 0',
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                  // add expenses Tab
                                  ListView.builder(
                                    itemCount: activity.length,
                                    itemBuilder: (context, index) {
                                      String title =
                                          activity[index].email ?? "";
                                      String initialLetter = title.isNotEmpty
                                          ? title[0].toUpperCase()
                                          : "";

                                      return Dismissible(
                                        key: Key(activity[index]
                                            .timestamp
                                            .toString()),
                                        onDismissed: (direction) {
                                          setState(() {
                                            activity.removeAt(index);
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
                                          trailing: const Text(
                                            'Rs: 0',
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
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: emailController,
                      decoration:
                          const InputDecoration(labelText: 'Friend\'s Email'),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        ItemData randomItemData = ItemData(
                            timestamp: DateTime.timestamp(),
                            email: emailController.text);
                        setState(() {
                          activity.add(randomItemData);
                        });

                        emailController.clear();
                        Navigator.pop(context);
                      },
                      child: const Text('Add Friend'),
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

  ItemData({
    required this.timestamp,
    this.email,
    this.groupName,
    this.title,
  });
}
