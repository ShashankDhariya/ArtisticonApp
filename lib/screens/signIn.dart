import 'package:artist_icon/screens/components/myButton.dart';
import 'package:artist_icon/screens/components/myTextField.dart';
import 'package:artist_icon/screens/home.dart';
import 'package:artist_icon/screens/signup.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignInPage extends StatelessWidget {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  SignInPage({super.key});

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
                MyTextField(hintText: 'Username', obsecure: false, icon: Icon(Icons.person,size: MediaQuery.of(context).size.height * 0.035),),
                SizedBox(height: MediaQuery.of(context).size.height * 0.015),
                MyTextField(hintText: 'Password', obsecure: true, icon: Icon(Icons.lock, size: MediaQuery.of(context).size.height * 0.035),),
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
                MyButton(
                  onTap: () {  
                    // check();
                    Navigator.push(context, MaterialPageRoute(builder:(context) {
                      return const HomePage();
                    },));
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