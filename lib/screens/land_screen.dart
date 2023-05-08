import 'package:artist_icon/screens/components/my_button.dart';
import 'package:artist_icon/screens/sign_in.dart';
import 'package:artist_icon/screens/signup.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LandScreen extends StatelessWidget {
  const LandScreen({super.key});

  @override
  Widget build(context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: SizedBox(
          height: size.height,
          child: Column(
            children: [
              SizedBox(height: size.height * 0.20),
              Image.asset('assets/images/artistIcon.jpeg', 
                height: size.height * 0.15,
              ),
              SizedBox(height: size.height * 0.15),
              const Text('Search Job\nPost Job\nGet Job\nRent Servives\n'),
              SizedBox(height: size.height * 0.15),
              MyButton(
                onPressed:() {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:(context) {
                        return const SignUpPage();
                      },
                    )
                  );
                }, 
                text: 'Sign Up', width: size.width * 0.9,
              ),
              SizedBox(height: size.height * 0.02),
              MyButton(
                onPressed:() {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:(context) {
                        return const SignInPage();
                      },
                    )
                  );
                }, 
                text: 'Sign In', width: size.width * 0.9,
              ),
              SizedBox(height: size.height * 0.030),
              Text('~ by Aditya Aswal', 
                style: GoogleFonts.pacifico(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}