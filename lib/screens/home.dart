import 'dart:async';
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
import 'package:connectivity_plus/connectivity_plus.dart';

class HomePage extends StatefulWidget {
  final UserModel userModel;
  final User firebaseUser;

  const HomePage({Key? key, required this.userModel, required this.firebaseUser}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  bool _isConnected = true;

  @override
  void initState() {
    super.initState();
    checkConnectivity();
    _connectivitySubscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      setState(() {
        _isConnected = result != ConnectivityResult.none;
      });
      if (!_isConnected) {
        showDialogBox();
      }
    });
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  Future<void> checkConnectivity() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    setState(() {
      _isConnected = connectivityResult != ConnectivityResult.none;
    });
    if (!_isConnected) {
      showDialogBox();
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> widgetOptions = [
      HomeArtist(firebaseUser: widget.firebaseUser, userModel: widget.userModel),
      PostOrRentModal(firebaseUser: widget.firebaseUser, userModel: widget.userModel),
      RentArtist(firebaseUser: widget.firebaseUser, userModel: widget.userModel)
    ];
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        title: Text('Welcome ${widget.userModel.name}',
            style: GoogleFonts.nunito(fontWeight: FontWeight.bold, fontSize: 16)),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return Profile(firebaseUser: widget.firebaseUser,userModel: widget.userModel);
                },
              ));
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              child: CircleAvatar(
                backgroundColor: Colors.white,
                maxRadius: 23,
                backgroundImage: _isConnected?
                      NetworkImage(widget.userModel.profilePic.toString(),)
                    : const AssetImage('assets/images/user.png') as ImageProvider<Object>?,
              ),
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
                  builder: (context) => SizedBox(
                    height: 170, // set the height here
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

  showDialogBox() {
    showDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: const Text("No Connection"),
          content: const Text("Please check your internet connection"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }
}