import 'package:flutter/material.dart';
import 'package:godjw/chat/chat_list.dart';
import 'package:godjw/flee_market/flee_main.dart';
import 'package:godjw/home/home.dart';
import 'package:godjw/tips/tips.dart';

class TabsPage extends StatefulWidget {
  @override
  _TabsPageState createState() => _TabsPageState();
}

class _TabsPageState extends State<TabsPage> {
  int _currentIndex = 0;

  final List<Widget> _children = [
    HomePage(),
    EventPage(),
    MyApp(),
    ChatListPage(),
    Text("설정")
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: tabIcon(Icons.home, 0),
            title: tabLabel('Home', 0),
          ),
          BottomNavigationBarItem(
            icon: tabIcon(Icons.mail, 1),
            title: tabLabel('Tips', 1),
          ),
          BottomNavigationBarItem(
            icon: tabIcon(Icons.person, 2),
            title: tabLabel('Market', 2),
          ),
          BottomNavigationBarItem(
            icon: tabIcon(Icons.person, 3),
            title: tabLabel('Chat', 3),
          ),
//          BottomNavigationBarItem(
//            icon: tabIcon(Icons.person, 4),
//            title: tabLabel('Settings', 4),
//          )
        ],
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  Widget tabIcon(IconData icon, int index) {
    return Icon(icon,
        color: _currentIndex != index ? Color(0xffD8D8D9) : Color(0xff5EABF9));
  }

  Widget tabLabel(String text, int index) {
    return Text(
      text,
      style: TextStyle(
          color:
              _currentIndex != index ? Color(0xffD8D8D9) : Color(0xff5EABF9)),
    );
  }
}
