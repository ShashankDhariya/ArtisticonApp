import 'package:artist_icon/screens/components/myTextField.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController nameController = TextEditingController();

  @override
  Widget build(context) {
    return Scaffold(
      body: Column(
        children: [
          CupertinoButton(
            onPressed: () {
            
            },
            child: const CircleAvatar(
              backgroundColor: Color(0xFFF5CEB8),
              foregroundColor: Colors.white,
              radius: 50,
              child: Icon(Icons.person, size: 70,),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.015,),
          MyTextField(hintText: 'Username', obsecure: false, icon: Icon(Icons.person,size: MediaQuery.of(context).size.height * 0.027), controller: nameController,),
          SizedBox(height: MediaQuery.of(context).size.height * 0.015),
          MyTextField(hintText: 'Password', obsecure: true, icon: Icon(Icons.lock, size: MediaQuery.of(context).size.height * 0.027), controller: nameController,),
        ],
      )
    );
  }
}