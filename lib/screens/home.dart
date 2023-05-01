import 'package:artist_icon/screens/profile.dart';
import 'package:artist_icon/screens/signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'artistpage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  final List<Widget> _widgetOptions = [const Artistpage(), const SignUpPage(), const Profile()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        color: const Color(0xFFF5CEB8),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
          child: GNav(
            selectedIndex: _selectedIndex,
            onTabChange: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            backgroundColor: const Color(0xFFF5CEB8),
            color: Colors.black,
            tabBackgroundColor: Colors.white,
            gap: 8,
            padding: const EdgeInsets.all(10),
            tabs: const [
               GButton(
                icon: LineIcons.home,
                text: 'Home',
              ),
              GButton(
                icon: CupertinoIcons.add,
                text: 'Post',
              ),
              GButton(
                icon: CupertinoIcons.person,
                text: 'Profile',
              ),
            ],
          ),
        ),
      ),
      body: _widgetOptions[_selectedIndex],
    );
  }
}
