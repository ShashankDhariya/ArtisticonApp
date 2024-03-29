import 'package:artist_icon/models/myapplications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:artist_icon/main.dart';
import 'package:artist_icon/models/rent_apply.dart';
import 'package:artist_icon/models/rentpost.dart';
import 'package:artist_icon/models/user.dart';
import 'package:artist_icon/screens/components/my_button.dart';
import 'package:artist_icon/screens/home.dart';

class RentNowPage extends StatefulWidget {
  final UserModel userModel;
  final User firebaseUser;
  final RentPostModel rentPostModel;
  const RentNowPage({Key? key, required this.userModel, required this.firebaseUser,required this.rentPostModel}): super(key: key);

  @override
  State<RentNowPage> createState() => _RentNowPageState();
}

class _RentNowPageState extends State<RentNowPage> {
  late DateTime _selectedDate;
  TextEditingController nameController = TextEditingController();
  TextEditingController hoursController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController peopleController = TextEditingController();
  bool state = false;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    dateController.text = DateFormat('yyyy-MM-dd').format(_selectedDate);
  }

  void submit() {
    String name = nameController.text.trim();
    String hrs = hoursController.text.trim();
    String people = peopleController.text.trim();
    String date = dateController.text.trim();

    if (name.isEmpty || hrs.isEmpty || people.isEmpty || date.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Fill out all the Fields")));
    } else {
      String applyRid = uuid.v1();
      RentApplyModel rentApply = RentApplyModel(
        applyRid: applyRid,
        name: name,
        date: date,
        phone: widget.userModel.phone,
        hrs: hrs,
        people: people,
      );
      // More Details can Also be added
      MyApplicationsModel myApplications = MyApplicationsModel(
        appyid: applyRid,
        id: widget.rentPostModel.rentid.toString(),
        name: widget.rentPostModel.provider.toString(),
        category: widget.rentPostModel.category.toString(),
        type: "Rent",
        address: '${widget.rentPostModel.address}, ${widget.rentPostModel.city}\n${widget.rentPostModel.state}, ${widget.rentPostModel.country}',
        pay: widget.rentPostModel.pay.toString(),
        date: DateTime.now(),
      );

      setState(() {
        state = true;
      });
      FirebaseFirestore.instance.collection("Users").doc(widget.userModel.uid.toString()).collection("MyApplications").doc(widget.rentPostModel.rentid.toString()).set(myApplications.toMap());
      FirebaseFirestore.instance.collection("Rents").doc(widget.rentPostModel.rentid.toString()).collection("Applications").doc(widget.userModel.uid.toString()).set(rentApply.toMap()).then((value) {
        Navigator.popUntil(context, (route) => route.isFirst);
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return HomePage(
              userModel: widget.userModel, firebaseUser: widget.firebaseUser);
          },
        ));
      });
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime(2100));
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        dateController.text = DateFormat('yyyy-MM-dd').format(_selectedDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF43B1B7),
        foregroundColor: Colors.black,
        elevation: 0.4,
        leading: IconButton(
          icon: const Icon(CupertinoIcons.left_chevron),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        centerTitle: true,
        title: Text('Rent Now',
          style: GoogleFonts.nunito(
            textStyle: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/background.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                  Image.asset('assets/images/Artisticon_logo.png', height: 105),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                  const SizedBox(height: 16.0),
                  TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      prefixIcon: const Icon(Icons.person),
                      fillColor: Colors.grey.shade100,
                      filled: true,
                      hintText: 'Name',
                      hintStyle:
                          TextStyle(color: Colors.grey.shade500, fontSize: 14),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  TextField(
                    controller: hoursController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      prefixIcon: const Icon(Icons.access_time_outlined),
                      fillColor: Colors.grey.shade100,
                      filled: true,
                      hintText: 'Enter number of hours',
                      hintStyle:
                          TextStyle(color: Colors.grey.shade500, fontSize: 14),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  TextField(
                    controller: peopleController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      prefixIcon: const Icon(Icons.group),
                      fillColor: Colors.grey.shade100,
                      filled: true,
                      hintText: 'Enter number of people',
                      hintStyle:
                          TextStyle(color: Colors.grey.shade500, fontSize: 14),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  GestureDetector(
                    onTap: () => _selectDate(context),
                    child: AbsorbPointer(
                      child: TextFormField(
                        controller: dateController,
                        keyboardType: TextInputType.datetime,
                        decoration: InputDecoration(
                          hintText: 'Select date',
                          prefixIcon: const Icon(Icons.calendar_today),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(color: Colors.black),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.shade500),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.shade500),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          filled: true,
                          fillColor: Colors.grey.shade100,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  state? const Center(child: CircularProgressIndicator()) : MyButton(text: "Submit", width: double.infinity, onPressed: submit)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}