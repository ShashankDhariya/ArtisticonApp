import 'dart:developer';
import 'package:artist_icon/models/user.dart';
import 'package:artist_icon/screens/components/my_text_field.dart';
import 'package:artist_icon/screens/components/my_button.dart';
import 'package:artist_icon/screens/forget_password.dart';
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
    String username = usernameController.text.trim();
    String password = passwordController.text.trim();

    if (username.isEmpty && password.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Please Enter Details')));
    } else if (username.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Please Enter Email')));
    } else if (password.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Please Enter Password')));
    } else {
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
      credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: username, password: password);
      String uid = credential.user!.uid;
      DocumentSnapshot userData =
          await FirebaseFirestore.instance.collection("Users").doc(uid).get();
      UserModel userModel =
          UserModel.fromMap(userData.data() as Map<String, dynamic>);
      Navigator.popUntil(context, (route) => route.isFirst);
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => HomePage(
                  firebaseUser: credential!.user!, userModel: userModel)));
    } catch (e) {
      setState(() {
        state = false;
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          SizedBox(
            height: MediaQuery.of(context).size.height,
            child: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * 0.17),
                    Image.asset(
                      'assets/images/Artisticon_logo.png',
                      height: MediaQuery.of(context).size.height * 0.14,
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                    Text(
                      'Please login to your account',
                      style: GoogleFonts.nunito(
                          textStyle: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[700],
                              fontWeight: FontWeight.bold)),
                    ),
                    SizedBox(
                        height: MediaQuery.of(context).size.height * 0.020),
                    MyTextField(
                      hintText: 'Email',
                      obsecure: false,
                      icon: Icon(Icons.person,
                          size: MediaQuery.of(context).size.height * 0.030),
                      controller: usernameController,
                    ),
                    SizedBox(
                        height: MediaQuery.of(context).size.height * 0.015),
                    MyTextField(
                      hintText: 'Password',
                      obsecure: true,
                      icon: Icon(Icons.lock,
                          size: MediaQuery.of(context).size.height * 0.030),
                      controller: passwordController,
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal:
                              MediaQuery.of(context).size.height * 0.035),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) {
                                  return const ForgetPassword();
                                },
                              ));
                            },
                            child: Text(
                              'Forgot Password?',
                              style: GoogleFonts.nunito(
                                textStyle: const TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                        height: MediaQuery.of(context).size.height * 0.025),
                    state
                        ? const CircularProgressIndicator()
                        : MyButton(
                            onPressed: () {
                              check();
                            },
                            text: 'Sign In',
                            width: 175,
                          ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.17),
                    Text(
                      'Don\'t have an account?',
                      style: GoogleFonts.nunito(
                        textStyle: const TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.height * 0.07),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return const SignUpPage();
                        }));
                      },
                      child: Text(
                        'Sign up',
                        style: GoogleFonts.nunito(
                          textStyle: const TextStyle(
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
        ],
      ),
    );
  }
}
