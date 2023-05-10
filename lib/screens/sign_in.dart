import 'dart:developer';
import 'package:artist_icon/models/user.dart';
import 'package:artist_icon/screens/components/my_text_field.dart';
import 'package:artist_icon/screens/components/my_button.dart';
import 'package:artist_icon/screens/home.dart';
import 'package:artist_icon/screens/signup.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool state = false;

void check() async {
  String username = '${usernameController.text.trim()}@artistIcon.com';
  String password = passwordController.text.trim();

  if(username.isEmpty && password.isEmpty){
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please Enter Details')));
  }

  else if(username.isEmpty){
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please Enter Username')));
  }

  else if(password.isEmpty){
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please Enter Password')));
  }

  else {
    log(username.toString());
    setState(() {
      state = true;
    });
    signIn(username, password);
  }
}

  void signIn(String username, String password) async {
    UserCredential? credential;
    try {
      credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: username,
        password: password
      );
      String uid = credential.user!.uid;
      DocumentSnapshot userData = await FirebaseFirestore.instance.collection("Users").doc(uid).get();
      UserModel userModel = UserModel.fromMap(userData.data() as Map<String, dynamic>);
      Navigator.popUntil(context, (route) => route.isFirst);
      Navigator.pushReplacement(context, MaterialPageRoute(builder:(context) => HomePage(firebaseUser: credential!.user!, userModel: userModel)));
    } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      setState(() {
        state = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('No user found for that email.')));
    } else if (e.code == 'wrong-password') {
      setState(() {
        state = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Wrong password provided for that user.')));
    }
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.07),
                Image.asset('assets/images/artistIcon.jpeg',
                  height: MediaQuery.of(context).size.height * 0.12,
                ),
          
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                Text(
                  'Please login to your account',
                  style: GoogleFonts.nunito(
                    textStyle: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[700],
                      fontWeight: FontWeight.bold
                    )
                  ),
                ),
          
                SizedBox(height: MediaQuery.of(context).size.height * 0.015,),
                MyTextField(hintText: 'Username', obsecure: false, icon: Icon(Icons.person,size: MediaQuery.of(context).size.height * 0.035), controller: usernameController,),
                SizedBox(height: MediaQuery.of(context).size.height * 0.015),
                MyTextField(hintText: 'Password', obsecure: true, icon: Icon(Icons.lock, size: MediaQuery.of(context).size.height * 0.035), controller: passwordController,),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
                
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.height * 0.035),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Forgot Password?',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
                  
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                state? const CircularProgressIndicator():
                MyButton(
                  onPressed: () {  
                    check();
                  }, text: 'Sign In', width: 175,
                ),
          
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.height * 0.02),
                  child: Row(
                    children: [
                      const Expanded(
                        child: Divider(
                          thickness: 0.6,
                        )
                      ),
                      Text('Or continue with', 
                        style: TextStyle(
                          color: Colors.grey.shade700
                        ),
                      ),
                      const Expanded(
                        child: Divider(
                          thickness: 0.6,
                        )
                      ),
                    ],
                  ),
                ),
          
                SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
          
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.015),
                        child: Image.asset('assets/images/google.png',
                          height: MediaQuery.of(context).size.height * 0.04,
                        ),
                      ),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.height * 0.02),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.015),
                        child: Image.asset('assets/images/apple.png',
                          height: MediaQuery.of(context).size.height * 0.04,
                        ),
                      ),
                    )
                  ],
                ),
          
                SizedBox(height: MediaQuery.of(context).size.height * 0.14),
          
                Text(
                  'Don\'t have an account?',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(width: MediaQuery.of(context).size.height * 0.07),
                                  
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, 
                        MaterialPageRoute(
                          builder: (context){
                            return const SignUpPage();
                        })
                      );
                    },
                    child: Text('Sign up',
                    style: GoogleFonts.nunito(
                      textStyle:const TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}