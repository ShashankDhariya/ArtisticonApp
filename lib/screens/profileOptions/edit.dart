import 'package:artist_icon/screens/components/myTextField.dart';
import 'package:artist_icon/screens/components/my_button.dart';
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
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0.0,
        centerTitle: true,
        title: const Text('Edit Profile'),
      ),
      body: Container(
        color: Colors.grey.shade100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
            MyTextField(hintText: 'Name', obsecure: true, icon: Icon(Icons.person_2, size: MediaQuery.of(context).size.height * 0.027), controller: nameController,),
            SizedBox(height: MediaQuery.of(context).size.height * 0.03),
            MyButton(onTap:() {}, text: 'Update', width: 200)
          ],
        ),
      )
    );
  }
}