import 'package:bhandaram/addscreen.dart';
import 'package:bhandaram/categoryscreen.dart';
import 'package:bhandaram/homescreen.dart';
import 'package:bhandaram/settingsscreen.dart';
import 'package:bhandaram/statisticsscreen.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({
    Key? key,
  }) : super(key: key);

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _currentindex = 0;
  final List _children = [
    const HomeScreen(),
    const CategoryScreen(),
    const AddScreen(),
    const StatisticsScreen(),
    const SettingsScreen()
  ];
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _children[_currentindex],
        bottomNavigationBar: ConvexAppBar(
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xff49c3a7), Color(0xff7baab9)],
          ),
          color: Colors.white,
          initialActiveIndex: _currentindex,
          onTap: (newindex) {
            setState(() {
              _currentindex = newindex;
            });
          },
          items: const [
            TabItem(icon: Icons.home, title: 'Home'),
            TabItem(icon: Icons.category_outlined, title: 'Category'),
            TabItem(icon: Icons.add, title: 'Add'),
            TabItem(icon: Icons.pie_chart, title: 'Statistics'),
            TabItem(icon: Icons.settings, title: 'Settings'),
          ],
        ));
  }
}
