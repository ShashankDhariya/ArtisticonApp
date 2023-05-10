import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:artist_icon/models/user.dart';
import 'package:artist_icon/screens/widgets/home_artist.dart';
import 'package:artist_icon/screens/widgets/jobposting_home.dart';
import 'package:artist_icon/screens/widgets/jobtype.dart';
import 'package:artist_icon/screens/widgets/rent_artist.dart';

class HomePage extends StatefulWidget {
  final UserModel userModel;
  final User firebaseUser;
  const HomePage({super.key, required this.userModel, required this.firebaseUser});
  
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  @override
  Widget build(context) {
    final List<Widget> widgetOptions = [HomeArtist(firebaseUser: widget.firebaseUser, userModel: widget.userModel,), const JobPost(), const RentArtist()];
    return Scaffold(
      bottomNavigationBar: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
          child: GNav(
            selectedIndex: _selectedIndex,
            onTabChange: (index) {
              if (index == 1) {
                showModalBottomSheet(
                  context: context,
                  backgroundColor: Colors.transparent,
                  isScrollControlled: true,
                  builder: (context) => const PostOrRentModal(),
                );
              } else {
                setState(() {
                  _selectedIndex = index;
                });
              }
            },
            backgroundColor: Colors.white,
            color: Colors.black,
            tabBackgroundColor: Colors.grey,
            gap: 8,
            padding: const EdgeInsets.all(10),
            tabs: const [
              GButton(
                icon: Icons.work,
                text: 'Jobs',
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
      body: widgetOptions[_selectedIndex],
    );
  }
}