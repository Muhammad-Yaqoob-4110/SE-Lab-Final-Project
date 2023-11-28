import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    // print(widget.data);
    // print(widget.data["fullName"]);
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
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => HomeScreen()));
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
                          ),
                          Expanded(
                            child: Container(
                              child: TabBarView(
                                children: [
                                  // Friends Tab
                                  ListView.builder(
                                    itemCount: items.length,
                                    itemBuilder: (context, index) {
                                      String title = items[index].title;
                                      String initialLetter = title.isNotEmpty
                                          ? title[0].toUpperCase()
                                          : "";

                                      return Dismissible(
                                        key: Key(items[index]
                                            .timestamp
                                            .toString()), // Use a unique key
                                        onDismissed: (direction) {
                                          // Remove the item
                                          setState(() {
                                            items.removeAt(index);
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
                                          leading: CircleAvatar(
                                            // Display the initial letter dynamically
                                            backgroundColor: Colors.blue,
                                            child: Text(initialLetter),
                                          ),
                                          title: Text(title),
                                          trailing: Text(
                                              'Rs: ${items[index].amount}'),
                                        ),
                                      );
                                    },
                                  ),
                                  // Groups Tab
                                  // ... (similar implementation for other tabs)
                                  ListView.builder(
                                    itemCount: groups.length,
                                    itemBuilder: (context, index) {
                                      String title = groups[index].title;
                                      String initialLetter = title.isNotEmpty
                                          ? title[0].toUpperCase()
                                          : "";

                                      return Dismissible(
                                        key: Key(groups[index]
                                            .timestamp
                                            .toString()), // Use a unique key
                                        onDismissed: (direction) {
                                          // Remove the item
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
                                          leading: CircleAvatar(
                                            // Display the initial letter dynamically
                                            backgroundColor: Colors.blue,
                                            child: Text(initialLetter),
                                          ),
                                          title: Text(title),
                                          trailing: Text(
                                              'Rs: ${groups[index].amount}'),
                                        ),
                                      );
                                    },
                                  ),
                                  // Center(child: Text("Content for Tab 2")),
                                  // Activity Tab
                                  ListView.builder(
                                    itemCount: activity.length,
                                    itemBuilder: (context, index) {
                                      String title = activity[index].title;
                                      String initialLetter = title.isNotEmpty
                                          ? title[0].toUpperCase()
                                          : "";

                                      return Dismissible(
                                        key: Key(activity[index]
                                            .timestamp
                                            .toString()), // Use a unique key
                                        onDismissed: (direction) {
                                          // Remove the item
                                          setState(() {
                                            activity.removeAt(index);
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
                                          leading: CircleAvatar(
                                            // Display the initial letter dynamically
                                            backgroundColor: Colors.blue,
                                            child: Text(initialLetter),
                                          ),
                                          title: Text(title),
                                          trailing: Text(
                                              'Rs: ${activity[index].amount}'),
                                        ),
                                      );
                                    },
                                  )
                                  // Center(child: Text("Content for Tab 3")),
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
          // Show a bottom sheet for adding new items
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return AddItemBottomSheet(onItemAdded: (ItemData newItem) {
                // Add the new item to the list
                setState(() {
                  items.add(newItem);
                });
              });
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

  const AddItemBottomSheet({Key? key, required this.onItemAdded})
      : super(key: key);

  @override
  _AddItemBottomSheetState createState() => _AddItemBottomSheetState();
}

class _AddItemBottomSheetState extends State<AddItemBottomSheet> {
  TextEditingController titleController = TextEditingController();
  TextEditingController amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: titleController,
            decoration: InputDecoration(labelText: 'Title'),
          ),
          TextField(
            controller: amountController,
            decoration: InputDecoration(labelText: 'Amount'),
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              // Validate input
              if (titleController.text.isNotEmpty &&
                  amountController.text.isNotEmpty) {
                // Set the current time
                DateTime currentTime = DateTime.now();

                // Create a new item with the current time
                ItemData newItem = ItemData(
                  title: titleController.text,
                  amount: amountController.text,
                  timestamp: currentTime,
                );

                // Pass the new item to the callback
                widget.onItemAdded(newItem);

                // Clear the text fields
                titleController.clear();
                amountController.clear();

                // Close the bottom sheet
                Navigator.pop(context);
              }
            },
            child: Text('Add Item'),
          ),
        ],
      ),
    );
  }
}

class ItemData {
  final String title;
  final String amount;
  final DateTime timestamp;

  ItemData(
      {required this.title, required this.amount, required this.timestamp});
}
