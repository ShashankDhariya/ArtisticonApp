import 'package:artist_icon/models/user.dart';
import 'package:artist_icon/screens/components/list_options.dart';
import 'package:artist_icon/screens/profileOptions/edit.dart';
import 'package:artist_icon/screens/profileOptions/information.dart';
import 'package:artist_icon/screens/profileOptions/my_applications.dart';
import 'package:artist_icon/screens/profileOptions/my_listings.dart';
import 'package:artist_icon/screens/profileOptions/privacy_policy.dart';
import 'package:artist_icon/screens/widgets/picture.dart';
import 'package:artist_icon/splash.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Profile extends StatefulWidget {
  final UserModel userModel;
  final User firebaseUser;
  const Profile({
    Key? key,
    required this.userModel,
    required this.firebaseUser,
  }) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool showPrivacyPolicy = false;

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

    void showPrivacyPolicyDialog(BuildContext context) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Privacy Policy'),
            content: const Text('Add your privacy policy content here.'),
            actions: [
              TextButton(
                child: const Text('Close'),
                onPressed: () {
                  Navigator.of(context).pop();
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
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () {
              setState(() {
                showPrivacyPolicy = !showPrivacyPolicy;
              });
            },
          ),
        ],
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
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return PicPage(
                              img: widget.userModel.profilePic.toString());
                        },
                      ));
                    },
                    child: CircleAvatar(
                      radius: MediaQuery.of(context).size.height * 0.08,
                      backgroundImage:
                          NetworkImage(widget.userModel.profilePic.toString()),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.010),
                  Text(
                    widget.userModel.name.toString(),
                    style: GoogleFonts.montserrat(),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.015),
                  Text(widget.userModel.username.toString()),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.015),
                  Text(
                    widget.userModel.profession.toString(),
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
                              firebaseUser: widget.firebaseUser,
                              userModel: widget.userModel,
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
                              userModel: widget.userModel,
                              firebaseUser: widget.firebaseUser,
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
                              userModel: widget.userModel,
                              firebaseUser: widget.firebaseUser,
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
          Positioned(
            top: kToolbarHeight + MediaQuery.of(context).padding.top - 100,
            right: -11,
            child: GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const PrivacyPolicy();
                }));
              },
              child: Visibility(
                visible: showPrivacyPolicy,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    'Privacy Policy',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
