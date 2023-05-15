import 'package:artist_icon/models/rentpost.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:artist_icon/models/user.dart';
import 'package:google_fonts/google_fonts.dart';

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
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
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
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/background.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          StreamBuilder(
              stream: FirebaseFirestore.instance.collection("Users").doc(userModel.uid.toString()).collection("MyApplications").orderBy("time", descending: true).snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.active) {
                  if (snapshot.hasData) {
                    QuerySnapshot data = snapshot.data as QuerySnapshot;
                    return ListView.builder(
                      itemCount: data.docs.length,
                      itemBuilder: (context, index) {
                        RentPostModel currApplication = RentPostModel.fromMap(
                            data.docs[index].data() as Map<String, dynamic>);
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
                                      image: AssetImage("assets/images/list_tile_background.jpg"),fit: BoxFit.cover,),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                ListTile(
                                  trailing: Text(currApplication.pay.toString()),
                                  title: Text(currApplication.provider.toString(),
                                    style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(currApplication.category.toString(),style: const TextStyle(fontWeight: FontWeight.bold)),
                                      const SizedBox(height: 10),
                                      Text('${currApplication.address} ${currApplication.city}\n${currApplication.state} ${currApplication.country}'),
                                      const SizedBox(height: 10),
                                      Text(currApplication.time.toString().substring(0, 10)),
                                    ],
                                  ),
                                ),
                              ],
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
              }
            ),
        ],
      ),
    );
  }
}
