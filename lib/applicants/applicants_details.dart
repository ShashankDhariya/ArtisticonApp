import 'package:artist_icon/models/job_apply.dart';
import 'package:artist_icon/models/jobpost.dart';
import 'package:artist_icon/screens/widgets/jobposting_home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:artist_icon/models/mylistings.dart';
import 'package:artist_icon/models/user.dart';
import 'package:velocity_x/velocity_x.dart';

class ApplicantsDetails extends StatelessWidget {
  final MyListingsModel listingsModel;
  final UserModel userModel;
  final User firebaseUser;
  const ApplicantsDetails({
    Key? key,
    required this.listingsModel,
    required this.userModel,
    required this.firebaseUser,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: size.height * 0.01, horizontal: size.width * 0.05),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          )),
      height: size.height * 0.5,
      child: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("Jobs").doc(listingsModel.id.toString()).collection("Applications").snapshots(), 
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.active){
            if(snapshot.hasData){
              QuerySnapshot data = snapshot.data as QuerySnapshot;
              return ListView.builder(
                itemCount: data.docs.length,
                itemBuilder:(context, index) {
                  JobApplyModel currApplicant = JobApplyModel.fromMap(data.docs[index].data() as Map<String, dynamic>);
                  return Container(
                    child: Column(
                      children: [
                        Text(currApplicant.name.toString()),
                        Image.network(currApplicant.img.toString(), 
                          height: 100,
                        ),
                        currApplicant.vid == null? circle(): Text(currApplicant.vid.toString()),
                    ]
                    ),
                  );
                },
              );
            }
            else if(snapshot.hasError){
              return const Center(child: Text("Unable to load data"));
            }
            else {
              return const Center(child: Text("Nothing to show"));
            }
          }
          else{
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
