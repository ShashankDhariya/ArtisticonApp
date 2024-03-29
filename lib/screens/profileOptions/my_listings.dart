import 'package:artist_icon/applicants/applicants_details.dart';
import 'package:artist_icon/models/mylistings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:artist_icon/models/user.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:artist_icon/screens/home.dart';

class MyListings extends StatelessWidget {
  final UserModel userModel;
  final User firebaseUser;
  const MyListings(
      {Key? key, required this.userModel, required this.firebaseUser})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        leading: IconButton(
          icon: const Icon(CupertinoIcons.left_chevron),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        foregroundColor: Colors.black,
        backgroundColor: Colors.grey.shade100,
        centerTitle: true,
        title: Text(
          'My Listings',
          style: GoogleFonts.nunito(
            fontWeight: FontWeight.bold,
            color: Colors.black,
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
          StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("Users")
                .doc(userModel.uid.toString())
                .collection("MyListings")
                .orderBy("time", descending: true)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                if (snapshot.hasData) {
                  QuerySnapshot data = snapshot.data as QuerySnapshot;
                  if (data.docs.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "You haven't listed any job or rented a service",
                            style: GoogleFonts.nunito(
                                fontWeight: FontWeight.w700, fontSize: 16),
                          ),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.02),
                          SizedBox(
                            width: 200,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HomePage(
                                            userModel: userModel,
                                            firebaseUser: firebaseUser)));
                              },
                              style: ElevatedButton.styleFrom(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18),
                                ),
                                backgroundColor: Colors.teal.shade300,
                              ),
                              child: Text(
                                'List Something',
                                style: GoogleFonts.nunito(
                                  textStyle: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  return ListView.builder(
                    itemCount: data.docs.length,
                    itemBuilder: (context, index) {
                      MyListingsModel currListing = MyListingsModel.fromMap(
                          data.docs[index].data() as Map<String, dynamic>);
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 10),
                        child: InkWell(
                          onTap: () {
                            showModalBottomSheet(
                              backgroundColor: Colors.transparent,
                              isScrollControlled: true,
                              context: context,
                              builder: (context) => ApplicantsDetails(
                                  firebaseUser: firebaseUser,
                                  userModel: userModel,
                                  listingsModel: currListing),
                            );
                          },
                          child: Container(
                            height: 120,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Stack(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    image: const DecorationImage(
                                      image: AssetImage(
                                          "assets/images/job_tile_background3.jpg"),
                                      fit: BoxFit.cover,
                                    ),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                ListTile(
                                  trailing: CupertinoButton(
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return CupertinoAlertDialog(
                                            title: const Text('Confirmation'),
                                            content: const Text(
                                                'Are you sure you want to delete this listing?'),
                                            actions: [
                                              TextButton(
                                                child: const Text('Cancel'),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                              TextButton(
                                                child: const Text('Delete'),
                                                onPressed: () {
                                                  // Delete the listing
                                                  FirebaseFirestore.instance
                                                      .collection("Users")
                                                      .doc(userModel.uid
                                                          .toString())
                                                      .collection("MyListings")
                                                      .doc(currListing.id
                                                          .toString())
                                                      .delete();
                                                  FirebaseFirestore.instance
                                                      .collection(
                                                          '${currListing.type}s')
                                                      .doc(currListing.id)
                                                      .delete();
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                    child: Text(
                                      'Delete',
                                      style: GoogleFonts.nunito(
                                        color: Colors.blue.shade700,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                  leading: Text(currListing.type.toString(),
                                      style: GoogleFonts.nunito(
                                          fontWeight: FontWeight.w700)),
                                  title: Text(currListing.category.toString(),
                                      style: GoogleFonts.nunito(
                                          fontWeight: FontWeight.w700)),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 20),
                                      Text('Rs.${currListing.pay}',
                                          style: GoogleFonts.nunito(
                                              fontWeight: FontWeight.w700)),
                                      const SizedBox(height: 10),
                                      Text(
                                          'Date: ${currListing.time.toString().substring(0, 10)}',
                                          style: GoogleFonts.nunito(
                                              fontWeight: FontWeight.w700)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
              }
              return const Center(child: CircularProgressIndicator());
            },
          ),
        ],
      ),
    );
  }
}
