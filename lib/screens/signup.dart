import 'package:artist_icon/screens/components/my_text_field.dart';
import 'package:artist_icon/screens/components/my_button.dart';
import 'package:artist_icon/screens/user_details.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController cPasswordController = TextEditingController();
  bool state = false;

  Future<bool> isEmailTaken(String email) async {
    try {
      final signInMethods =
          await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);
      return signInMethods.isNotEmpty;
    } catch (e) {
      return false;
    }
  }

  void check() async {
    String username = usernameController.text.trim();
    String password = passwordController.text.trim();
    String cpassword = cPasswordController.text.trim();

    if (cpassword.isEmpty && password.isEmpty && username.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please enter details')));
    } else if (username.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please enter username')));
    } else if (password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please enter password')));
    } else if (cpassword.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please confirm password')));
    } else if (cpassword != password) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Password do not match')));
    } else if (password.length <= 5) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('The password provided is too weak.')));
    } else if (await isEmailTaken('$username@artistIcon.com')) {
      setState(() {
        state = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('The account already exists for that email.')));
    } else {
      setState(() {
        state = false;
      });
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return UserDetails(password: password, username: username);
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
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
            height: size.height,
            child: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * 0.15),
                    Image.asset(
                      'assets/images/Artisticon_logo.png',
                      height: MediaQuery.of(context).size.height * 0.14,
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                    Text(
                      'Create your account',
                      style: GoogleFonts.nunito(
                          textStyle: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[700],
                              fontWeight: FontWeight.bold)),
                    ),
                    SizedBox(height: size.height * 0.015),
                    MyTextField(
                      hintText: 'Username',
                      obsecure: false,
                      icon: Icon(Icons.person,
                          size: MediaQuery.of(context).size.height * 0.027),
                      controller: usernameController,
                    ),
                    SizedBox(height: size.height * 0.015),
                    MyTextField(
                      hintText: 'Password',
                      obsecure: true,
                      icon: Icon(Icons.lock,
                          size: MediaQuery.of(context).size.height * 0.027),
                      controller: passwordController,
                    ),
                    SizedBox(height: size.height * 0.015),
                    MyTextField(
                      hintText: 'Confirm Password',
                      obsecure: true,
                      icon: Icon(Icons.lock_person,
                          size: MediaQuery.of(context).size.height * 0.027),
                      controller: cPasswordController,
                    ),
                    SizedBox(height: size.height * 0.025),
                    state
                        ? const CircularProgressIndicator()
                        : MyButton(
                            onPressed: () {
                              check();
                            },
                            text: 'Sign Up',
                            width: 175,
                          ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.15),
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        'Back To Sign In',
                        style: GoogleFonts.nunito(
                          textStyle: const TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    )
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
