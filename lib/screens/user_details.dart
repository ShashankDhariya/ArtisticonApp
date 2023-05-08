import 'dart:io';
import 'package:artist_icon/screens/components/my_button.dart';
import 'package:artist_icon/screens/components/my_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class UserDetails extends StatefulWidget {
  // final String? uid;
  // const UserDetails({super.key, this.uid});

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
    CroppedFile? croppedImg =  (await ImageCropper().cropImage(sourcePath: file.path));
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

  void checkValues(){
    String name = nameController.text.trim();
    
      // uploadData();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CupertinoButton(
            onPressed: () {
              showInputImgOptions();
            },
            child: const CircleAvatar(
              backgroundColor: Color(0xFFF5CEB8),
              foregroundColor: Colors.white,
              radius: 50,
              child: Icon(Icons.person, size: 70,),
            ),
          ),
          const Text('Complete your details'),
          SizedBox(height: size.height * 0.015),
          MyTextField(hintText: 'Name', obsecure: false, icon: Icon(Icons.person, size: MediaQuery.of(context).size.height * 0.027), controller: nameController),
          SizedBox(height: size.height * 0.025),
          MyTextField(hintText: 'Phone', obsecure: false, icon: Icon(Icons.phone, size: MediaQuery.of(context).size.height * 0.027), controller: phoneController),
          SizedBox(height: size.height * 0.025),
          MyButton(
            onPressed: () {  
              
            },
            text: 'Sign Up', width: 175,
          ),
        ],
      )
    );
  }
}