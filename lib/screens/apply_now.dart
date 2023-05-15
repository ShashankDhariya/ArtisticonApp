import 'dart:io';
import 'package:artist_icon/models/jobpost.dart';
import 'package:artist_icon/screens/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import 'package:artist_icon/models/job_apply.dart';
import 'package:artist_icon/models/user.dart';

class ApplyNowScreen extends StatefulWidget {
  final UserModel userModel;
  final User firebaseUser;
  final JobPostModel jobpostmodel;
  const ApplyNowScreen({
    Key? key,
    required this.userModel,
    required this.firebaseUser,
    required this.jobpostmodel,
  }) : super(key: key);

  @override
  State<ApplyNowScreen> createState() => _ApplyNowScreenState();
}

class _ApplyNowScreenState extends State<ApplyNowScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController videoLinkController = TextEditingController();
  File? portfolioFile;
  File? img;

  void uploadPortfolio() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      setState(() {
        portfolioFile = File(result.files.single.path!);
      });
    }
  }

  void uploadPhoto() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      cropImg(pickedFile);
    }
  }

  void cropImg(XFile file) async {
    CroppedFile? croppedImg = await ImageCropper().cropImage(
        sourcePath: file.path,
        aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
        compressQuality: 20);
    if (croppedImg != null) {
      setState(() {
        img = File(croppedImg.path);
      });
    }
  }

  Future<void> submit() async {
    String vidLink = videoLinkController.text;
    String name = nameController.text.trim();

    if (name.isEmpty || img == null || portfolioFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please fill all the fields')));
    } else {
      var applyJid = const Uuid().v1();
      UploadTask uploadTask1 =
          FirebaseStorage.instance.ref('Images').child(applyJid).putFile(img!);
      TaskSnapshot snapshot1 = await uploadTask1;
      String imgUrl = await snapshot1.ref.getDownloadURL();

      UploadTask uploadTask2 = FirebaseStorage.instance
          .ref('Portfolio')
          .child(applyJid)
          .putFile(portfolioFile!);
      TaskSnapshot snapshot2 = await uploadTask2;
      String portfolioUrl = await snapshot2.ref.getDownloadURL();

      JobApplyModel applyjob = JobApplyModel(
        applyJid: applyJid,
        name: name,
        phone: widget.userModel.phone,
        img: imgUrl,
        portfolio: portfolioUrl,
        vid: vidLink,
      );

      JobPostModel myApplications = JobPostModel(
        jobid: widget.jobpostmodel.jobid.toString(),
        provider: widget.jobpostmodel.provider.toString(),
        desc: widget.jobpostmodel.desc.toString(),
        category: widget.jobpostmodel.category.toString(),
        phone: widget.jobpostmodel.phone.toString(),
        address: widget.jobpostmodel.address.toString(),
        city: widget.jobpostmodel.city.toString(),
        state: widget.jobpostmodel.state.toString(),
        country: widget.jobpostmodel.country.toString(),
        pay: widget.jobpostmodel.pay.toString(),
        time: DateTime.now(),
      );

      FirebaseFirestore.instance
          .collection("Users")
          .doc(widget.userModel.uid.toString())
          .collection("MyApplications")
          .doc(widget.jobpostmodel.jobid.toString())
          .set(myApplications.toMap());

      FirebaseFirestore.instance
          .collection("Jobs")
          .doc(widget.jobpostmodel.jobid.toString())
          .collection("Applications")
          .doc(widget.userModel.uid.toString())
          .set(applyjob.toMap())
          .then((value) {
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
        title: Text(
          'Apply Now',
          style: GoogleFonts.nunito(
            textStyle: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
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
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.07),
                  Image.asset(
                    'assets/images/Artisticon_logo.png',
                    height: 105,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.07),
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
                  SizedBox(height: MediaQuery.of(context).size.height * 0.015),
                  TextField(
                    controller: videoLinkController,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      prefixIcon: const Icon(Icons.videocam),
                      fillColor: Colors.grey.shade100,
                      filled: true,
                      hintText: 'Video Link (optional)',
                      hintStyle:
                          TextStyle(color: Colors.grey.shade500, fontSize: 14),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.015),
                  ElevatedButton(
                    onPressed: uploadPortfolio,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                      backgroundColor: Colors.teal.shade300,
                    ),
                    child: Text(
                      'Upload Portfolio',
                      style: GoogleFonts.nunito(
                        textStyle: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  if (portfolioFile != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        portfolioFile!.path,
                        style: const TextStyle(fontSize: 14.0),
                      ),
                    ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.015),
                  ElevatedButton(
                    onPressed: uploadPhoto,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                      backgroundColor: Colors.teal.shade300,
                    ),
                    child: Text(
                      'Upload Photograph',
                      style: GoogleFonts.nunito(
                          textStyle: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                  if (img != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Image.file(
                        img!,
                        height: 200.0,
                        fit: BoxFit.cover,
                      ),
                    ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.035),
                  ElevatedButton(
                    onPressed: submit,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                      backgroundColor: const Color(0xFF43B1B7),
                    ),
                    child: Text(
                      'Submit',
                      style: GoogleFonts.nunito(
                        textStyle: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
