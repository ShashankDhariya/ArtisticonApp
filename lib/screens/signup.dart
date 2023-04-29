import 'package:artist_icon/screens/components/myButton.dart';
import 'package:artist_icon/screens/components/myTextField.dart';
import 'package:artist_icon/screens/home.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/artistIcon.jpeg',
                  height: MediaQuery.of(context).size.height * 0.12,
                ),

                SizedBox(height: MediaQuery.of(context).size.height * 0.075),
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
                MyTextField(hintText: 'Username', obsecure: false, icon: Icon(Icons.person,size: MediaQuery.of(context).size.height * 0.027),),
                SizedBox(height: MediaQuery.of(context).size.height * 0.015),
                MyTextField(hintText: 'Password', obsecure: true, icon: Icon(Icons.lock, size: MediaQuery.of(context).size.height * 0.027),),
                SizedBox(height: MediaQuery.of(context).size.height * 0.015),
                MyTextField(hintText: 'Confirm Password', obsecure: false, icon: Icon(Icons.lock_person, size: MediaQuery.of(context).size.height * 0.027),),
                SizedBox(height: MediaQuery.of(context).size.height * 0.015),
                MyTextField(hintText: 'Name', obsecure: true, icon: Icon(Icons.person_2, size: MediaQuery.of(context).size.height * 0.027),),
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                MyButton(
                  onTap: () {  
                    // check();
                    Navigator.push(context, MaterialPageRoute(builder:(context) {
                      return HomePage();
                    },));
                  }, text: 'Sign Up',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}