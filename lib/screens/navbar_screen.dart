import 'package:firebase_007/screens/home/home.dart';
import 'package:firebase_007/screens/more_screen.dart';
import 'package:flutter/material.dart';

class NavBarScreen extends StatefulWidget {
  static const String id = 'navbar_screen';

  @override
  _NavBarScreenState createState() => _NavBarScreenState();
}

class _NavBarScreenState extends State<NavBarScreen> {
  int _selectedIndex = 0;

  // Define the pages for each bottom nav item
  static final List<Widget> _pages = <Widget>[
    Home_Screen(), // Home screen as the first item
    MoreScreen(), // Another screen (you can replace it with another screen)
  ];

  // Update selected index
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex], // Display the selected page
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.more_horiz),
            label: 'More',
          ),
        ],
      ),
    );
  }
}
