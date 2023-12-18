import 'package:flutter/material.dart';

class Account extends StatefulWidget {
  final dynamic token;
  final dynamic data;

  Account({Key? key, this.data, this.token}) : super(key: key);

  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  final Color myColor = const Color(0xFF4CBB9B);
  final TextEditingController userEmailController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();
  String? userName;
  String? userEmail;

  @override
  void initState() {
    super.initState();
    userEmailController.text = widget.data["email"];
    userNameController.text = widget.data["fullName"];
  }

  @override
  Widget build(BuildContext context) {
    String title = userNameController.text;
    String initialLetter = title.isNotEmpty ? title[0].toUpperCase() : "";
    return Scaffold(
      appBar: AppBar(
        backgroundColor: myColor,
        title: const Text("MoneyMate"),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListTile(
        onTap: () {
          print('Item tapped: $title');
          _showEditDialog();
        },
        leading: CircleAvatar(
          backgroundColor: Colors.blue,
          child: Text(initialLetter),
        ),
        title: Text(title),
        trailing: const Icon(Icons.edit),
      ),
    );
  }

  void _showEditDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit User Information'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: const InputDecoration(labelText: 'Name'),
                controller: userNameController,
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Email'),
                controller: userEmailController,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  userName = userNameController.text;
                });
                Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }
}
