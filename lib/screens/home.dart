import 'package:artist_icon/screens/profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:artist_icon/models/user.dart';
import 'package:artist_icon/screens/widgets/home_artist.dart';
import 'package:artist_icon/screens/widgets/jobtype.dart';
import 'package:artist_icon/screens/widgets/rent_artist.dart';

class HomePage extends StatefulWidget {
  final UserModel userModel;
  final User firebaseUser;
  const HomePage(
      {super.key, required this.userModel, required this.firebaseUser});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> widgetOptions = [
      HomeArtist(
          firebaseUser: widget.firebaseUser, userModel: widget.userModel),
      PostOrRentModal(
        firebaseUser: widget.firebaseUser,
        userModel: widget.userModel,
      ),
      // JobPost(firebaseUser: widget.firebaseUser, userModel: widget.userModel),
      RentArtist(firebaseUser: widget.firebaseUser, userModel: widget.userModel)
    ];
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        title: Text(
          'Welcome ${widget.userModel.name}',
          style: GoogleFonts.nunito(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return Profile(
                      firebaseUser: widget.firebaseUser,
                      userModel: widget.userModel);
                },
              ));
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              child: CircleAvatar(
                  maxRadius: 23,
                  backgroundImage: NetworkImage(
                    widget.userModel.profilePic.toString(),
                  )),
            ),
          ),
        ],
      ),
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
                  builder: (context) => Container(
                    height: 250, // set the height here
                    child: PostOrRentModal(
                      firebaseUser: widget.firebaseUser,
                      userModel: widget.userModel,
                    ),
                  ),
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
