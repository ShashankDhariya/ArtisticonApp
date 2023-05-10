import 'dart:io';
import 'package:artist_icon/models/user.dart';
import 'package:artist_icon/screens/components/my_button.dart';
import 'package:artist_icon/screens/components/my_text_field.dart';
import 'package:artist_icon/screens/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class UserDetails extends StatefulWidget {
  final String? password;
  final String? username;
  const UserDetails({super.key, required this.password, required this.username});

  @override
  State<UserDetails> createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  File? img;

  void selectImg(ImageSource source) async{
    XFile? pickedFile =  await ImagePicker().pickImage(source: source);

    if (pickedFile != null) {
      cropImg(pickedFile);
    }
  }

  void cropImg(XFile file) async {
    CroppedFile? croppedImg =  await ImageCropper().cropImage(
      sourcePath: file.path,
      aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
      compressQuality: 20
    );
    if(croppedImg != null){
      setState(() {
        img = File(croppedImg.path);
      });
    }
  }

  void showInputImgOptions(){
    showDialog(context: context, builder: (context) {
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

  void check(){
    String name = nameController.text.trim();
    String phone = phoneController.text.trim();
    
    if(img == null){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Select profile picture')));
    }
    else if(name == ''){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Enter name')));
    }
    else if(phone == ''){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Enter phone number')));
    }
    else {
      signUp(widget.username!, widget.password!);
    }
  }

  void signUp(String username, String password) async {
    UserCredential? credential;
    try {
        credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: username,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('The password provided is too weak.')));
      } else if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('The account already exists for that email.')));
      }
      } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    }

    String name = nameController.text.trim();
    String phone = phoneController.text.trim();

    if(credential != null) {
      uploadData(name, phone, credential.user!.uid, credential.user as User);
    }
  }

  void uploadData(String name, String phone, String uid, User firebaseUser) async{
    UploadTask uploadTask = FirebaseStorage.instance.ref('ProfilePictures').child(uid).putFile(img!);
    TaskSnapshot snapshot = await uploadTask;
    String imgUrl = await snapshot.ref.getDownloadURL();
    
    UserModel newUser = UserModel(
      uid: uid,
      name: name,
      profilePic: imgUrl,
      username: widget.username,
      phone: phone
    );
    FirebaseFirestore.instance.collection('Users').doc(uid).set(newUser.toMap()).then((value){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('New User')));
    });
    Navigator.push(
      context, 
      MaterialPageRoute(
        builder:(context) {
          return HomePage(firebaseUser: firebaseUser, userModel: newUser,);
        },
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              CupertinoButton(
                onPressed: () {
                  showInputImgOptions();
                },
                child: CircleAvatar(
                  backgroundColor: const Color(0xFFF5CEB8),
                  foregroundColor: Colors.white,
                  backgroundImage: img == null? null: FileImage(img!),
                  radius: 50,
                  child: img == null? const Icon(Icons.person, size: 70,): null,
                ),
              ),
              const Text('Complete your details'),
              SizedBox(height: size.height * 0.015),
              MyTextField(hintText: 'Name', obsecure: false, icon: const Icon(Icons.person, size: 20), controller: nameController),
              SizedBox(height: size.height * 0.025),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.height * 0.03,) ,
                child: TextField(
                  keyboardType: TextInputType.phone,
                  controller: phoneController,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(20)
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    prefixIcon: const Icon(Icons.phone),
                    fillColor: Colors.grey.shade200,
                    filled: true,
                    hintText: 'Phone',
                    hintStyle: TextStyle(color: Colors.grey.shade500)
                  ),
                ),
              ),

              SizedBox(height: size.height * 0.025),
              MyButton(
                onPressed: () {  
                  check();
                },
                text: 'Sign Up', width: 175,
              ),
            ],
          ),
        ),
      )
    );
  }
}