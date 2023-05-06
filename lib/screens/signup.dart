import 'dart:developer';
import 'package:artist_icon/screens/components/myButton.dart';
import 'package:artist_icon/screens/components/myTextField.dart';
import 'package:artist_icon/screens/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController cPasswordController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  void check() async {
    String username = usernameController.text.trim();
    String password = passwordController.text.trim();
    String cpassword = cPasswordController.text.trim();
    String name = nameController.text.trim();
    
    if(name.isEmpty && cpassword.isEmpty && password.isEmpty && username.isEmpty){
      log('Empty Fields');
    }

    UserCredential? credential;
    try {
        credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: username,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        log('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        log('The account already exists for that email.');
      }
      } catch (e) {
    // ignore: avoid_print
    print(e);
  }
  if(credential != null)
    Navigator.push(context, MaterialPageRoute(builder:(context) {
      return const HomePage();
  },));
}

  @override
  Widget build(context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: SafeArea(
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
                Text(
                  'Create your account',
                  style: GoogleFonts.nunito(
                    textStyle: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[700],
                      fontWeight: FontWeight.bold
                    )
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.015,),
                MyTextField(hintText: 'Username', obsecure: false, icon: Icon(Icons.person,size: MediaQuery.of(context).size.height * 0.027), controller: usernameController,),
                SizedBox(height: MediaQuery.of(context).size.height * 0.015),
                MyTextField(hintText: 'Password', obsecure: true, icon: Icon(Icons.lock, size: MediaQuery.of(context).size.height * 0.027), controller: passwordController,),
                SizedBox(height: MediaQuery.of(context).size.height * 0.015),
                MyTextField(hintText: 'Confirm Password', obsecure: false, icon: Icon(Icons.lock_person, size: MediaQuery.of(context).size.height * 0.027), controller: cPasswordController,),
                SizedBox(height: MediaQuery.of(context).size.height * 0.015),
                MyTextField(hintText: 'Name', obsecure: false, icon: Icon(Icons.person_2, size: MediaQuery.of(context).size.height * 0.027), controller: nameController,),
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                MyButton(
                  onTap: () {  
                    check();
                  },
                  text: 'Sign Up', width: 175,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}