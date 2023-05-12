import 'package:artist_icon/models/jobpost.dart';
import 'package:artist_icon/screens/widgets/icon_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController searchControler = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
      body: Column(
        children: [
          Card(
            child: TextField(
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Search...',
              ),
              controller: searchControler,
            ),
          ),
          StreamBuilder(
            stream: FirebaseFirestore.instance.collection("Jobs").snapshots(),
            builder:(context, snapshot) {
              if(snapshot.connectionState == ConnectionState.active){
                if(snapshot.hasError){
                  QuerySnapshot data = snapshot.data as QuerySnapshot;
                  return ListView.builder(
                    itemCount: data.docs.length,
                    itemBuilder:(context, index) {
                      JobPostModel currJob = JobPostModel.fromMap(data.docs[index].data() as Map<String, dynamic>);
                      return Container(
                        width: 250,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.white,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text(currJob.provider.toString(),
                                        style: const TextStyle(
                                          color: Colors.grey,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ))
                                  ],
                                )
                              ],
                            ),
                            const SizedBox(height: 15),
                            Text(currJob.category.toString(),
                                style:
                                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                            const SizedBox(height: 15),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconText(Icons.location_on_outlined, currJob.city.toString()),
                              ],
                            )
                          ],
                        ));
                    },
                  );
                }
                else if(snapshot.hasError){
                  return const Center(child: Text("Error in Showing Jobs"),);
                }
                else {
                  return const Center(child: Text('Nothing to show...'),);
                }
              }
              else {
                return const Center(child: Text("Loading Jobs..."),);
              }
            },
          )
        ]
      ),
    );
  }
}