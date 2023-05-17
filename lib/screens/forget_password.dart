import 'package:artist_icon/screens/components/my_button.dart';
import 'package:artist_icon/screens/components/my_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});
  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}
class _ForgetPasswordState extends State<ForgetPassword> {
  TextEditingController emailController = TextEditingController();
  bool state = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MyTextField(
              hintText: 'Enter your Email',
              obsecure: false,
              icon: Icon(Icons.lock, size: MediaQuery.of(context).size.height * 0.030),
              controller: emailController,
            ),
            const SizedBox(height: 20),
            state? const CircularProgressIndicator()
            :
            MyButton(text: "Submit", width: 175, 
              onPressed:() {
                if(emailController.text.isEmpty){
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please enter your email for reset password mail')));
                }
                else{
                  setState(() {
                  state = true;
                  });
                  FirebaseAuth.instance.sendPasswordResetEmail(email: emailController.text.trim().toString())
                  .then((value) {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Email has been to${emailController.text.trim()}\nCheck your mail')));
                  }).onError((error, stackTrace){
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error.toString())));
                  });
                }
              }
            )
          ],
        )
      ),
    );
  }
}