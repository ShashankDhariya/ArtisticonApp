import 'dart:io';
import 'package:artist_icon/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:restart_app/restart_app.dart';

class EditProfile extends StatefulWidget {
  final UserModel userModel;
  final User firebaseUser;
  const EditProfile({super.key, required this.userModel, required this.firebaseUser});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController professionController = TextEditingController();
  bool state = false;
  File? img;

  void selectImg(ImageSource source) async {
    XFile? pickedFile = await ImagePicker().pickImage(source: source);
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

  void showInputImgOptions() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Select Profile Picture"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  onTap: () {
                    Navigator.pop(context);
                    selectImg(ImageSource.gallery);
                  },
                  leading: const Icon(Icons.photo_album),
                  title: const Text("Select from Gallery"),
                ),
                ListTile(
                  onTap: () {
                    Navigator.pop(context);
                    selectImg(ImageSource.camera);
                  },
                  leading: const Icon(Icons.camera),
                  title: const Text("Take photo"),
                ),
              ],
            ),
          );
        });
  }

  Future<void> submit() async {
    String name = nameController.text.trim();
    String phone = phoneController.text.trim();
    String profession = professionController.text.trim();

    if (name.isEmpty && phone.isEmpty && profession.isEmpty && img == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('No Update')));
    } else {
      if (name.isNotEmpty) {
        FirebaseFirestore.instance.collection('Users').doc(widget.userModel.uid).update({'name': name}).then((value) {}).catchError((error) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to update name: $error')));
        });
      }
      if (phone.isNotEmpty) {
        FirebaseFirestore.instance.collection('Users').doc(widget.userModel.uid).update({'phone': phone}).then((value) {}).catchError((error) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to update number: $error')));
        });
      }
      if (profession.isNotEmpty) {
        FirebaseFirestore.instance.collection('Users').doc(widget.userModel.uid).update({'profession': profession}).then((value) {}).catchError((error) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to update profession: $error')));
        });
      }
      if (img != null) {
        UploadTask uploadTask = FirebaseStorage.instance.ref('ProfilePictures').child(widget.userModel.uid.toString()).putFile(img!);
        TaskSnapshot snapshot = await uploadTask;
        String imgUrl = await snapshot.ref.getDownloadURL();
        FirebaseFirestore.instance.collection('Users').doc(widget.userModel.uid).update({'profilePic': imgUrl}).then((value) {}).catchError((error) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to update profession: $error')));
        });
      }
      Restart.restartApp();
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade100,
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
          'Edit Profile',
          style: GoogleFonts.nunito(
            textStyle: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: Stack(
        children: [
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Container(),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  color: Colors.grey.withOpacity(0.06),
                ),
              ),
            ],
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                  CupertinoButton(
                    onPressed: () { showInputImgOptions();},
                    child: Stack(
                      children: [
                        CircleAvatar(
                          backgroundColor: const Color(0xFFF5CEB8),
                          foregroundColor: Colors.white,
                          radius: MediaQuery.of(context).size.height * 0.1,
                          backgroundImage: NetworkImage(
                              widget.userModel.profilePic.toString()),
                          foregroundImage: img != null ? FileImage(img!) : null,
                          child: widget.userModel.profilePic == null
                              ? const Icon(Icons.person, size: 70)
                              : null,
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xFF43B1B7),
                            ),
                            child: IconButton(
                              onPressed: () { showInputImgOptions();},
                              icon: const Icon(
                                CupertinoIcons.camera_fill,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.03),
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
                      hintText: widget.userModel.name,
                      hintStyle:
                          TextStyle(color: Colors.grey.shade500, fontSize: 14),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  TextField(
                    controller: phoneController,
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
                      prefixIcon: const Icon(Icons.phone),
                      fillColor: Colors.grey.shade100,
                      filled: true,
                      hintText: widget.userModel.phone,
                      hintStyle:
                          TextStyle(color: Colors.grey.shade500, fontSize: 14),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  TextField(
                    controller: professionController,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      prefixIcon: const Icon(Icons.art_track_sharp, size: 20),
                      fillColor: Colors.grey.shade100,
                      filled: true,
                      hintText: widget.userModel.profession,
                      hintStyle:
                          TextStyle(color: Colors.grey.shade500, fontSize: 14),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: submit,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                      backgroundColor: const Color(0xFF43B1B7),
                      fixedSize: const Size(150, 48),
                    ),
                    child: Text('Update',
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