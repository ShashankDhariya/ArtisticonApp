import 'package:artist_icon/screens/jobPosting.dart';
import 'package:artist_icon/screens/widgets/home_artist.dart';
import 'package:artist_icon/screens/widgets/rent_artist.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  final List<Widget> _widgetOptions = [
    const HomeArtist(),
    const JobPosting(),
    const RentArtist(),
  ];

  @override
  Widget build(context) {
    return Scaffold(
      bottomNavigationBar: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
          child: GNav(
            selectedIndex: _selectedIndex,
            onTabChange: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            backgroundColor: Colors.white,
            color: Colors.black,
            tabBackgroundColor: Colors.grey,
            gap: 8,
            padding: const EdgeInsets.all(10),
            tabs: const [
              GButton(
                icon: Icons.work,
                text: 'Home',
              ),
              GButton(
                icon: CupertinoIcons.add_circled_solid,
                text: 'Post',
              ),
              GButton(
                icon: Icons.monetization_on,
                text: 'Rent',
              ),
            ],
          ),
        ),
      ),
      body: _widgetOptions[_selectedIndex],
    );
  }
}
