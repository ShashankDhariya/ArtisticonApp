import 'dart:developer';
import 'package:artist_icon/models/rentpost.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:artist_icon/models/user.dart';

class MyApplications extends StatelessWidget {
  final UserModel userModel;
  final User firebaseUser;
  const MyApplications({Key? key, required this.userModel, required this.firebaseUser}) : super(key: key);

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
        title: const Text('My Applications'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("Users").doc(userModel.uid.toString()).collection("MyApplications").orderBy("time", descending: true).snapshots(),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.active){
            if(snapshot.hasData){
              log(snapshot.data!.docs.length.toString());
              QuerySnapshot data = snapshot.data as QuerySnapshot;
              return ListView.builder(
                itemCount: data.docs.length,
                itemBuilder:(context, index) {
                  RentPostModel currApplication = RentPostModel.fromMap(data.docs[index].data() as Map<String, dynamic>);
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                    child: Container(
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListTile(
                        trailing: Text(currApplication.pay.toString()),
                        title: Text(currApplication.provider.toString(),
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children:  [
                            Text(currApplication.category.toString(), 
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 10),
                            Text('${currApplication.address} ${currApplication.city} ${currApplication.state} ${currApplication.country}'),
                            const SizedBox(height: 10),
                            Text(currApplication.time.toString()),
                          ],
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
