import 'package:artist_icon/applicants/applicants_details.dart';
import 'package:artist_icon/models/mylistings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:artist_icon/models/user.dart';
import 'package:google_fonts/google_fonts.dart';

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
        fit: StackFit.expand,
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/background.jpg"),
                fit: BoxFit.cover,
              ),
            ),
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
                    return ListView.builder(
                      itemCount: data.docs.length,
                      itemBuilder: (context, index) {
                        MyListingsModel currListing = MyListingsModel.fromMap(
                            data.docs[index].data() as Map<String, dynamic>);
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                          child: InkWell(
                            onTap: () {
                              showModalBottomSheet(
                                  backgroundColor: Colors.transparent,
                                  isScrollControlled: true,
                                  context: context,
                                  builder: (context) => ApplicantsDetails(
                                      firebaseUser: firebaseUser,
                                      userModel: userModel,
                                      listingsModel: currListing));
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
                                              "assets/images/list_tile_background.jpg"),
                                          fit: BoxFit.cover,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                  ),
                                  ListTile(
                                    trailing: CupertinoButton(
                                        onPressed: () {
                                          FirebaseFirestore.instance
                                              .collection("Users")
                                              .doc(userModel.uid.toString())
                                              .collection("MyListings")
                                              .doc(currListing.id.toString())
                                              .delete();
                                          FirebaseFirestore.instance
                                              .collection(
                                                  '${currListing.type}s')
                                              .doc(currListing.id)
                                              .delete();
                                        },
                                        child: Text('Delete',
                                            style: GoogleFonts.nunito(
                                              color: Colors.blue.shade700,
                                              fontWeight: FontWeight.w700,
                                            ))),
                                    leading: Text(currListing.type.toString()),
                                    title:
                                        Text(currListing.category.toString()),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(height: 20),
                                        Text('Rs.${currListing.pay}'),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                            'Date: ${currListing.time.toString().substring(0, 10)}'),
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
                  } else {
                    return const Center(child: Text("Nothing to show..."));
                  }
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              }),
        ],
      ),
    );
  }
}
