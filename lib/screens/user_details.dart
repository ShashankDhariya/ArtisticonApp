import 'dart:io';
import 'package:artist_icon/screens/components/my_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class UserDetails extends StatefulWidget {
  const UserDetails({super.key});

  @override
  State<UserDetails> createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {

  TextEditingController nameController = TextEditingController();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
          MyTextField(hintText: 'Name', obsecure: false, icon: Icon(Icons.person_2, size: MediaQuery.of(context).size.height * 0.027), controller: nameController),
          SizedBox(height: MediaQuery.of(context).size.height * 0.05),
        ],
      )
    );
  }
}