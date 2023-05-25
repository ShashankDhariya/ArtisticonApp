import 'package:artist_icon/models/user.dart';
import 'package:artist_icon/screens/components/list_options.dart';
import 'package:artist_icon/screens/profileOptions/edit.dart';
import 'package:artist_icon/screens/profileOptions/information.dart';
import 'package:artist_icon/screens/profileOptions/my_applications.dart';
import 'package:artist_icon/screens/profileOptions/my_listings.dart';
import 'package:artist_icon/screens/widgets/picture.dart';
import 'package:artist_icon/splash.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Profile extends StatelessWidget {
  final UserModel userModel;
  final User firebaseUser;
  const Profile({
    Key? key,
    required this.userModel,
    required this.firebaseUser,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<void> showLogoutConfirmationDialog() async {
      return showDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: const Text('Confirm Logout'),
            content: const Text('Are you sure you want to logout?'),
            actions: <Widget>[
              TextButton(
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text('Logout'),
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.popUntil(context, (route) => route.isFirst);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const Splash()),
                  );
                },
              ),
            ],
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade100,
        elevation: 0.4,
        leading: IconButton(
          icon: const Icon(CupertinoIcons.left_chevron),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        centerTitle: true,
        title: Text(
          'Profile',
          style: GoogleFonts.nunito(
            textStyle: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Container(),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  color: Colors.grey.withOpacity(0.06),
                ),
              ),
            ],
          ),
          SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.width * 0.05,
              ),
              child: Column(
                children: [
                  CupertinoButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:(context) {
                            return PicPage(img: userModel.profilePic.toString());
                          },
                        )
                      );
                    },
                    child: CircleAvatar(
                      radius: MediaQuery.of(context).size.height * 0.08,
                      backgroundImage:
                          NetworkImage(userModel.profilePic.toString()),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.010),
                  Text(
                    userModel.name.toString(),
                    style: GoogleFonts.montserrat(),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.015),
                  Text(userModel.username.toString()),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.015),
                  Text(
                    userModel.profession.toString(),
                    style: GoogleFonts.pacifico(),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                  const Divider(),
                  ListOption(
                    icon: const Icon(Icons.book),
                    text: 'My Applications',
                    color: Colors.black,
                    ontap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return MyApplications(
                              firebaseUser: firebaseUser,
                              userModel: userModel,
                            );
                          },
                        ),
                      );
                    },
                  ),
                  ListOption(
                    icon: const Icon(CupertinoIcons.book_circle),
                    text: 'My Listings',
                    color: Colors.black,
                    ontap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return MyListings(
                              userModel: userModel,
                              firebaseUser: firebaseUser,
                            );
                          },
                        ),
                      );
                    },
                  ),
                  ListOption(
                    icon: const Icon(CupertinoIcons.pen),
                    text: 'Edit Profile',
                    color: Colors.black,
                    ontap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return EditProfile(
                              userModel: userModel,
                              firebaseUser: firebaseUser,
                            );
                          },
                        ),
                      );
                    },
                  ),
                  ListOption(
                    icon: const Icon(Icons.info),
                    text: 'About App',
                    color: Colors.black,
                    ontap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return const Information();
                          },
                        ),
                      );
                    },
                  ),
                  ListOption(
                    icon: const Icon(Icons.exit_to_app),
                    text: 'Log out',
                    color: Colors.red,
                    ontap: showLogoutConfirmationDialog,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
