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
          height: size.height * 0.98,
          child: Column(
            children: [
              SizedBox(height: size.height * 0.2),
              Image.asset('assets/images/artistIcon.jpeg', 
                height: size.height * 0.15,
              ),
              SizedBox(height: size.height * 0.2),
              const Text('Search, Post Jobs'),
              SizedBox(height: size.height * 0.2),
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
              SizedBox(height: size.height * 0.035),
              Text('~ by Artisisticon', 
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