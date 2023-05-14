import 'package:artist_icon/applicants/applicants_details.dart';
import 'package:artist_icon/models/mylistings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:artist_icon/models/user.dart';

class MyListings extends StatelessWidget {
  final UserModel userModel;
  final User firebaseUser;
  const MyListings({Key? key, required this.userModel, required this.firebaseUser}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        leading: IconButton(icon: const Icon(CupertinoIcons.left_chevron), 
          onPressed: () {
            Navigator.pop(context);
          },),
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text('My Listings'),
      ),

      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("Users").doc(userModel.uid.toString()).collection("MyListings").orderBy("time", descending: true).snapshots(),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.active){
            if(snapshot.hasData){
              QuerySnapshot data = snapshot.data as QuerySnapshot;
              return ListView.builder(
                itemCount: data.docs.length,
                itemBuilder:(context, index) {
                  MyListingsModel currListing = MyListingsModel.fromMap(data.docs[index].data() as Map<String, dynamic>);
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                    child: InkWell(
                      onTap: () {
                        showModalBottomSheet(
                          backgroundColor: Colors.transparent,
                          isScrollControlled: true,
                          context: context,
                          builder: (context) => ApplicantsDetails(firebaseUser: firebaseUser, userModel: userModel, listingsModel: currListing)
                        );
                      },
                      child: Container(
                        height: 120,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ListTile(
                          trailing: CupertinoButton(
                            onPressed: () { 
                              
                            },
                            child: const Text('Delete')),
                          leading: Text(currListing.type.toString()),
                          title: Text(currListing.category.toString()),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 20),
                              Text('Rs.${currListing.pay}'),
                              const SizedBox(height: 10,),
                              Text('Date :${currListing.time.toString()}'),
                            ],
                          ),
                          
                        ),
                      ),
                    ),
                  );
                },
              );
            }
            else if(snapshot.hasError){
              return Center(child: Text('Error: ${snapshot.error}'));
            }
            else{
              return const Center(child: Text("Nothing to show..."));
            }
          }
          else{
            return const Center(child: CircularProgressIndicator());
          }
        }
      ),
    );
  }
}
