import 'package:artist_icon/screens/profile.dart';
import 'package:artist_icon/screens/signIn.dart';
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
  List<Widget> _widgetOptions = [Artistpage(), SignUpPage(), Profile()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
          child: GNav(
            selectedIndex: _selectedIndex,
            onTabChange: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            backgroundColor: Colors.black,
            color: Colors.white,
            tabBackgroundColor: Colors.grey,
            gap: 8,
            padding: const EdgeInsets.all(10),
            tabs: [
              GButton(
                icon: LineIcons.home,
                text: 'Home',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Artistpage()),
                  );
                },
              ),
              GButton(
                icon: CupertinoIcons.add,
                text: 'Post',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignInPage()),
                  );
                },
              ),
              GButton(
                icon: CupertinoIcons.person,
                text: 'Profile',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Profile()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      body: _widgetOptions[_selectedIndex],
    );
  }
}
