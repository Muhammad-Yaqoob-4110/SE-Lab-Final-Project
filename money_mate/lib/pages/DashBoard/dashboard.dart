import 'package:flutter/material.dart';
import 'package:money_mate/pages/DashBoard/Account/account.dart';
import 'package:money_mate/pages/DashBoard/Group/group.dart';
import 'package:money_mate/config.dart';

class DashBoard extends StatefulWidget {
  final dynamic data;
  final int initialIndex;

  DashBoard({Key? key, required this.data, this.initialIndex = 0})
      : super(key: key);

  @override
  _HomeScreenState createState() =>
      _HomeScreenState(data: data, initialIndex: initialIndex);
}

class _HomeScreenState extends State<DashBoard> {
  int _currentIndex = 0;
  final Color customColor = AppThemes.theme.primaryColor;
  final Color appColor = AppThemes.theme.secondaryHeaderColor;
  late List<Widget> _pages;

  _HomeScreenState({required dynamic data, required int initialIndex})
      : _currentIndex = initialIndex;

  @override
  void initState() {
    super.initState();

    _pages = [
      Group(data: widget.data),
      const Center(child: Text('Friends')),
      const Center(child: Text('Activity')),
      AccountScreen(data: widget.data),
    ];
  }

  @override
  Widget build(BuildContext context) {
    // final List<String> tabTitles = ['GROUPS', 'FRIENDS', 'ACTIVITY', 'ACCOUNT'];
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(
      //     _currentIndex == 3 ? 'ACCOUNT' : tabTitles[_currentIndex],
      //   ),
      //   backgroundColor: appColor,
      // ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: customColor,
        unselectedItemColor: Colors.white,
        backgroundColor: appColor,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.group),
            label: 'GROUPS',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'FRIENDS',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.trending_up),
            label: 'ACTIVITY',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'ACCOUNT',
          ),
        ],
      ),
    );
  }
}
