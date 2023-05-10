import 'package:artist_icon/screens/components/my_text_field.dart';
import 'package:artist_icon/screens/components/my_button.dart';
import 'package:artist_icon/screens/user_details.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

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
    final signInMethods = await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);
    return signInMethods.isNotEmpty;
  } catch (e) {
    return false;
  }
}

  void check() async {
    String username = '${usernameController.text.trim()}@artistIcon.com';
    String password = passwordController.text.trim();
    String cpassword = cPasswordController.text.trim();
    
    if(cpassword.isEmpty && password.isEmpty && username.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please enter details')));
    }

    else if(username.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please enter username')));
    }

    else if(password.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please enter password')));
    }

    else if(cpassword.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please confirm password')));
    }

    else if(cpassword != password){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Password do not match')));
    }

    else if(password.length <= 5){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('The password provided is too weak.')));
    }

    else if(cpassword.isNotEmpty && password.isNotEmpty && username.isNotEmpty){
      setState(() {
        state = true;
      });
    }

    else if(await isEmailTaken(username)){
      setState(() {
        state = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('The account already exists for that email.')));  
    }
    
    else {
      setState(() {
        state = false;
      });
      Navigator.push(
        context, 
        MaterialPageRoute(
          builder:(context) {
            return UserDetails(password: password, username: username);
          },
        )
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox(
        height: size.height,
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
                  'Create your account',
                  style: GoogleFonts.nunito(
                    textStyle: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[700],
                      fontWeight: FontWeight.bold
                    )
                  ),
                ),
                SizedBox(height: size.height * 0.015,),
                MyTextField(hintText: 'Username', obsecure: false, icon: Icon(Icons.person,size: MediaQuery.of(context).size.height * 0.027), controller: usernameController,),
                SizedBox(height: size.height * 0.015),
                MyTextField(hintText: 'Password', obsecure: true, icon: Icon(Icons.lock, size: MediaQuery.of(context).size.height * 0.027), controller: passwordController,),
                SizedBox(height: size.height * 0.015),
                MyTextField(hintText: 'Confirm Password', obsecure: false, icon: Icon(Icons.lock_person, size: MediaQuery.of(context).size.height * 0.027), controller: cPasswordController,),
                SizedBox(height: size.height * 0.025),
                state? const CircularProgressIndicator(): 
                MyButton(
                  onPressed: () {  
                    check();
                  },
                  text: 'Sign Up', width: 175,
                ),
          
                SizedBox(height: size.height * 0.025),
          
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
                SizedBox(height: MediaQuery.of(context).size.height * 0.07),
                TextButton(onPressed:() => Navigator.pop(context), child: const Text('Back To Sign In'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}