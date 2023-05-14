import 'package:artist_icon/main.dart';
import 'package:artist_icon/models/mylistings.dart';
import 'package:artist_icon/screens/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:artist_icon/models/jobpost.dart';
import 'package:artist_icon/models/user.dart';
import 'package:artist_icon/screens/components/my_button.dart';
import 'package:artist_icon/screens/components/my_text_field.dart';

class JobPosting extends StatefulWidget {
  final UserModel userModel;
  final User firebaseUser;
  const JobPosting({Key? key, required this.userModel, required this.firebaseUser,}) : super(key: key);

  @override
  State<JobPosting> createState() => _JobPostingState();
}

class _JobPostingState extends State<JobPosting> {
  TextEditingController categoryController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController citycontroller = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController paycontroller = TextEditingController();

  void check(){
    String category = categoryController.text.trim();
    String desc = descController.text.trim();
    String phone = phoneController.text.trim();
    String address = addressController.text.trim();
    String city = citycontroller.text.trim();
    String state = stateController.text.trim();
    String country = countryController.text.trim();
    String pay = paycontroller.text.trim();
    String jobid = uuid.v1();

    JobPostModel jobpost = JobPostModel(
      uid: widget.userModel.uid,
      jobid: jobid,
      provider: widget.userModel.name.toString(),
      category: category,
      desc: desc,
      phone: phone,
      address: address,
      city: city,
      state: state,
      country: country,
      pay: pay,
      time: DateTime.now(),
    );

    MyListingsModel listing = MyListingsModel(
      category: category,
      address: address,
      type: "Job",
      time: DateTime.now(),
      pay: pay,
      id: jobid,
    );
    
    FirebaseFirestore.instance.collection("Users").doc(widget.userModel.uid.toString()).collection("MyListings").doc(jobid).set(listing.toMap());

    FirebaseFirestore.instance.collection("Jobs").doc(jobid).set(jobpost.toMap()).then((value) {
      Navigator.popUntil(context, (route) => route.isFirst);
      Navigator.push(
        context, 
        MaterialPageRoute(
          builder:(context) {
            return HomePage(userModel: widget.userModel, firebaseUser: widget.firebaseUser);
          },
        ));
    });
  }


  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Center(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: size.height * 0.045,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.32,
                      vertical: size.height * 0.03),
                  child: Text(
                    'Job Details',
                    style: GoogleFonts.montserrat(
                      textStyle: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
            MyTextField(
              hintText: 'Category',
              obsecure: false,
              icon: Icon(Icons.person,
                  size: MediaQuery.of(context).size.height * 0.030),
              controller: categoryController,
            ),
            SizedBox(height: size.height * 0.018),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.height * 0.03,
              ),
              child: TextField(
                maxLines: null,
                controller: descController,
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(20)),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    prefixIcon: const Icon(Icons.description),
                    fillColor: Colors.grey.shade100,
                    filled: true,
                    hintText: 'Description',
                    hintStyle: TextStyle(color: Colors.grey.shade500)),
              ),
            ),

            SizedBox(height: size.height * 0.018),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.height * 0.03,
              ),
              child: TextField(
                keyboardType: TextInputType.number,
                controller: phoneController,
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(20)),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    prefixIcon: const Icon(Icons.description),
                    fillColor: Colors.grey.shade100,
                    filled: true,
                    hintText: 'Phone',
                    hintStyle: TextStyle(color: Colors.grey.shade500)),
              ),
            ),

            SizedBox(height: size.height * 0.018),
            MyTextField(
              hintText: 'Address',
              obsecure: false,
              icon: Icon(Icons.map,
                  size: MediaQuery.of(context).size.height * 0.030),
              controller: addressController,
            ),
            SizedBox(height: size.height * 0.025),
            MyTextField(
              hintText: 'City',
              obsecure: false,
              icon: Icon(Icons.location_city,
                  size: MediaQuery.of(context).size.height * 0.030),
              controller: citycontroller,
            ),
            SizedBox(height: size.height * 0.018),
            MyTextField(
              hintText: 'State',
              obsecure: false,
              icon: Icon(Icons.location_on,
                  size: MediaQuery.of(context).size.height * 0.030),
              controller: stateController,
            ),
            SizedBox(height: size.height * 0.018),
            MyTextField(
              hintText: 'Country',
              obsecure: false,
              icon: Icon(Icons.flag,
                  size: MediaQuery.of(context).size.height * 0.030),
              controller: countryController,
            ),
            SizedBox(height: size.height * 0.018),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.height * 0.03,
              ),
              child: TextField(
                keyboardType: TextInputType.number,
                controller: paycontroller,
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(20)),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    prefixIcon: const Icon(Icons.description),
                    fillColor: Colors.grey.shade100,
                    filled: true,
                    hintText: 'Expected Pay',
                    hintStyle: TextStyle(color: Colors.grey.shade500)),
              ),
            ),
            SizedBox(height: size.height * 0.018),
            MyButton(
              text: 'Post Job',
              width: size.width * 0.48,
              onPressed: () {
                check();
              },
            )
          ],
        ),
      ),
    );
  }
}
