import 'package:artist_icon/models/job_apply.dart';
import 'package:artist_icon/models/rent_apply.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:artist_icon/models/mylistings.dart';
import 'package:artist_icon/models/user.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:url_launcher/url_launcher.dart';

bool isLink(String text) {
  Uri? uri = Uri.tryParse(text);
  if (uri == null) return false;
  return uri.hasScheme && uri.hasAuthority;
}

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
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          )),
        height: size.height * 0.5,
        child: listingsModel.type.toString() == "Job"
          ? StreamBuilder(
            stream: FirebaseFirestore.instance.collection("Jobs").doc(listingsModel.id.toString()).collection("Applications").snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                if (snapshot.hasData) {
                  QuerySnapshot data = snapshot.data as QuerySnapshot;
                  return ListView.builder(
                    itemCount: data.docs.length,
                    itemBuilder: (context, index) {
                      JobApplyModel currApplicant = JobApplyModel.fromMap(
                          data.docs[index].data() as Map<String, dynamic>);
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Container(
                          decoration: BoxDecoration(
                            image: const DecorationImage(
                              image: AssetImage("assets/images/job_tile_background3.jpg"),fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Column(
                            children: [
                              const SizedBox(height: 10),
                              Text(
                                '~${index + 1}~',
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(currApplicant.name.toString(),
                                style: GoogleFonts.nunito(
                                  color: const Color(0xFF43B1B7),
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16),
                              ),
                              const SizedBox(height: 10),
                              CircleAvatar(
                                radius: 50,
                                child: ClipOval(
                                  child: Image.network(
                                    currApplicant.img.toString(),
                                    height: 150,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              GestureDetector(
                                onTap: () async {
                                  if (!await launchUrl(
                                    Uri.parse(currApplicant.portfolio.toString()),
                                    mode: LaunchMode.externalApplication,
                                  )) {
                                    throw Exception('Could not launch $Uri.parse(currApplicant.portfolio.toString()');
                                  }
                                },
                                child: Text(
                                  'Portfolio',
                                  style: GoogleFonts.nunito(
                                    decoration: TextDecoration.underline,
                                    color: const Color(0xFF43B1B7),
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16),
                                ),
                              ),
                              const SizedBox(height: 10),
                              isLink(currApplicant.vid.toString())
                              ? GestureDetector(
                                  onTap: () async {
                                    if (!await launchUrl(
                                      Uri.parse(
                                          currApplicant.vid.toString()),
                                      mode: LaunchMode
                                          .externalApplication,
                                    )) {
                                      throw Exception(
                                          'Could not launch $Uri.parse(currApplicant.vid.toString()');
                                    }
                                  },
                                  child: Text(
                                    'Video',
                                    style: GoogleFonts.nunito(
                                        decoration:
                                            TextDecoration.underline,
                                        color: const Color(0xFF43B1B7),
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16),
                                  ),
                                )
                              : Text(
                                  "No video attached",
                                  style: GoogleFonts.nunito(
                                      color: const Color(0xFF43B1B7),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16),
                                ),
                              const SizedBox(height: 10),
                              Padding(
                                padding: const EdgeInsets.only(left: 35),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      currApplicant.phone.toString(),
                                      style: GoogleFonts.nunito(
                                          color: const Color(0xFF43B1B7),
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left:10.0), // Add left padding of 10
                                      child: GestureDetector(
                                        onTap: () async {
                                          String phoneNumber = currApplicant.phone.toString();
                                          String url = "https://wa.me/+91$phoneNumber";
                                          launch(url);
                                        },
                                        child: const Icon(LineIcons.whatSApp, color: Colors.green),
                                      ),
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
                } else if (snapshot.hasError) {
                  return const Center(child: Text("Unable to load data"));
                } else {
                  return const Center(child: Text("Nothing to show..."));
                }
              } else {
                return const CircularProgressIndicator();
              }
            },
          )
          :StreamBuilder(
            stream: FirebaseFirestore.instance.collection("Rents").doc(listingsModel.id.toString()).collection("Applications").snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                if (snapshot.hasData) {
                  QuerySnapshot data = snapshot.data as QuerySnapshot;
                  return ListView.builder(
                    itemCount: data.docs.length,
                    itemBuilder: (context, index) {
                      RentApplyModel currApplicant = RentApplyModel.fromMap(
                          data.docs[index].data() as Map<String, dynamic>);
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30)),
                          child: Column(children: [
                            const SizedBox(height: 10),
                            Text('~${index + 1}~'),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text("Name: ",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold)),
                                Text(currApplicant.name.toString()),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text("Number of people: ", style: TextStyle(fontWeight: FontWeight.bold)),
                                Text(currApplicant.people.toString()),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text("Date: ", style: TextStyle(fontWeight: FontWeight.bold)),
                                Text(currApplicant.date.toString()),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text("Number of hours: ", style: TextStyle(fontWeight: FontWeight.bold)),
                                Text(currApplicant.hrs.toString()),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text("Phone: ", style: TextStyle(fontWeight: FontWeight.bold)),
                                Text(currApplicant.phone.toString()),
                              ],
                            ),
                            const SizedBox(height: 10)
                          ]),
                        ),
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return const Center(child: Text("Unable to load data"));
                } else {
                  return const Center(child: Text("Nothing to show..."));
                }
              } else {
                return const CircularProgressIndicator();
              }
            },
          )
        );
  }
}
