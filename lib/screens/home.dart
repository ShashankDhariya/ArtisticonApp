import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'artistpage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Color(0xff2dbdc0),
        unselectedItemColor: Color(0xffaab2ca),
        showUnselectedLabels: false,
        showSelectedLabels: false,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.only(right: 36),
              child: Icon(Icons.home),
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.add_card), label: 'Add'),
          BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(left: 36),
                child: Icon(Icons.person),
              ),
              label: 'Profile')
        ],
      ),
      body: Artistpage(),
    );
  }
}
