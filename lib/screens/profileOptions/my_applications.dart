import 'package:artist_icon/models/myapplications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:artist_icon/models/user.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:artist_icon/screens/home.dart';

class MyApplications extends StatelessWidget {
  final UserModel userModel;
  final User firebaseUser;
  const MyApplications(
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
        iconTheme: const IconThemeData(color: Colors.black),
        foregroundColor: Colors.black,
        backgroundColor: Colors.grey.shade100,
        centerTitle: true,
        title: Text(
          'My Applications',
          style: GoogleFonts.nunito(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: Stack(
        fit: StackFit.expand,
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
                .doc(userModel.uid)
                .collection("MyApplications")
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                if (snapshot.hasData) {
                  QuerySnapshot data = snapshot.data as QuerySnapshot;
                  if (data.docs.isEmpty) {
                    // Display a message and a button to redirect to the home page
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "You haven't applied to a job or availed a service",
                          style: GoogleFonts.nunito(
                              fontWeight: FontWeight.w700, fontSize: 16),
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02),
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
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18),
                              ),
                              backgroundColor: Colors.teal.shade300,
                            ),
                            child: Text(
                              'Apply or Rent Something',
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
                    );
                  } else {
                    return ListView.builder(
                      itemCount: data.docs.length,
                      itemBuilder: (context, index) {
                        MyApplicationsModel currApplication =
                            MyApplicationsModel.fromMap(data.docs[index].data()
                                as Map<String, dynamic>);
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                          child: Container(
                            height: 130,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(20),
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
                                  leading: Text(currApplication.type.toString(),
                                      style: GoogleFonts.nunito(
                                          fontWeight: FontWeight.w700)),
                                  trailing: CupertinoButton(
                                    onPressed: () {
                                      FirebaseFirestore.instance
                                          .collection("Users")
                                          .doc(userModel.uid.toString())
                                          .collection("MyApplications")
                                          .doc(currApplication.id.toString())
                                          .delete();
                                      FirebaseFirestore.instance
                                          .collection(
                                              '${currApplication.type}s')
                                          .doc(currApplication.id)
                                          .collection('Applications')
                                          .doc(userModel.uid.toString())
                                          .delete();
                                    },
                                    child: Text("Delete",
                                        style: GoogleFonts.nunito(
                                            fontWeight: FontWeight.w700,
                                            color: Colors.blue.shade700)),
                                  ),
                                  title: Text(
                                    currApplication.name.toString(),
                                    style: GoogleFonts.nunito(
                                        fontWeight: FontWeight.w700),
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(currApplication.category.toString(),
                                          style: GoogleFonts.nunito(
                                              fontWeight: FontWeight.w600)),
                                      const SizedBox(height: 7),
                                      Text(currApplication.address.toString(),
                                          style: GoogleFonts.nunito(
                                              fontWeight: FontWeight.w500)),
                                      const SizedBox(height: 7),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                              currApplication.date
                                                  .toString()
                                                  .substring(0, 10),
                                              style: GoogleFonts.nunito(
                                                  fontWeight: FontWeight.w500)),
                                          Text('Rs.${currApplication.pay}',
                                              style: GoogleFonts.nunito(
                                                  fontWeight: FontWeight.w500)),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  return const Center(child: Text("Nothing to show..."));
                }
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ],
      ),
    );
  }
}
