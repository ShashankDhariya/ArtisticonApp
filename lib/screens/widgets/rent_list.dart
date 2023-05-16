import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:artist_icon/models/rentpost.dart';
import 'package:artist_icon/models/user.dart';
import 'package:artist_icon/screens/widgets/rent_detail.dart';
import 'icon_text.dart';

class RentList extends StatefulWidget {
  final UserModel userModel;
  final User firebaseUser;
  const RentList({Key? key,required this.userModel,required this.firebaseUser}) : super(key: key);

  @override
  State<RentList> createState() => _RentListState();
}

class _RentListState extends State<RentList> {
  String search = "";
  String location = "";
  @override
  Widget build(context) {
    var size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * 0.9,
      child: Column(children: [
        // Search Option Bar
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 25),
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 25,
          ),
          height: 290,
          width: double.maxFinite,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            image: const DecorationImage(
              image: AssetImage('assets/images/search_bg.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Fast Search',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'You can search quickly for any service you want',
                style: TextStyle(
                  height: 1.8,
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 30),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        onChanged: (val) {
                          setState(() {
                            search = val;
                          });
                        },
                        decoration: const InputDecoration(
                          hintText: 'Search',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: Image.asset(
                        'assets/images/search.png',
                        height: 20,
                        width: 20,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        onChanged: (val) {
                          setState(() {
                            location = val;
                          });
                        },
                        decoration: const InputDecoration(
                          hintText: 'Location',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: Image.asset('assets/images/search.png',
                        height: 20,
                        width: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // List of Available Jobs
        Expanded(
          child: StreamBuilder(
            stream: FirebaseFirestore.instance.collection("Rents").orderBy("time", descending: true).snapshots(),
            builder: (context, snapshot) {
              return snapshot.connectionState == ConnectionState.waiting
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    RentPostModel currRent = RentPostModel.fromMap(
                        snapshot.data!.docs[index].data());

                    if (search.isEmpty && location.isEmpty) {
                      return Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: size.width * 0.05,
                            vertical: size.height * 0.01),
                        child: GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                              backgroundColor: Colors.transparent,
                              isScrollControlled: true,
                              context: context,
                              builder: (context) => RentDetail(
                                currRent: currRent,
                                firebaseUser: widget.firebaseUser,
                                userModel: widget.userModel));
                          },
                          child: Container(
                              height: 135,
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                image: const DecorationImage(
                                  image: AssetImage("assets/images/job_tile_background3.jpg"), fit: BoxFit.cover,),
                                borderRadius: BorderRadius.circular(20)),
                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Text(currRent.provider.toString(),
                                            style: const TextStyle(
                                              color: Colors.grey,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            )
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                  const SizedBox(height: 15),
                                  Text(currRent.category.toString(),
                                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                                  const SizedBox(height: 15),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      IconText(Icons.location_on_outlined, currRent.city.toString()),
                                    ],
                                  )
                                ],
                              )
                            ),
                        ),
                      );
                    }

                    if (currRent.city.toString().toLowerCase().contains(location.toLowerCase()) &&
                        currRent.category.toString().toLowerCase().contains(search.toLowerCase())) {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: size.width * 0.05, vertical: size.height * 0.01),
                        child: GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                              backgroundColor: Colors.transparent,
                              isScrollControlled: true,
                              context: context,
                              builder: (context) => RentDetail(currRent: currRent,firebaseUser: widget.firebaseUser,userModel: widget.userModel));
                          },
                          child: Container(
                              height: size.height * 0.18,
                              width: size.width * 0.8,
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: Colors.grey.shade100,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Text(currRent.provider.toString(),
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
                                  Text(currRent.category.toString(),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16)),
                                  const SizedBox(height: 15),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [IconText(Icons.location_on_outlined, currRent.city.toString())],
                                  )
                                ],
                              )),
                        ),
                      );
                    }
                    return Container();
                  },
                );
            },
          ),
        )
      ]),
    );
  }
}