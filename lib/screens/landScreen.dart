import 'package:artist_icon/screens/components/myButton.dart';
import 'package:artist_icon/screens/signIn.dart';
import 'package:artist_icon/screens/signup.dart';
import 'package:flutter/material.dart';

class LandScreen extends StatelessWidget {
  const LandScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: SizedBox(
          height: size.height * 0.98,
          child: Column(
            children: [
              SizedBox(height: size.height * 0.3),
              Image.asset('assets/images/artistIcon.jpeg', 
                height: size.height * 0.15,
              ),
              SizedBox(height: size.height * 0.3),
              const Text('Search, Post Jobs\nArtistIcon'),
              MyButton(
                onTap:() {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:(context) {
                        return SignUpPage();
                      },
                    )
                  );
                }, 
                text: 'Sign Up', width: size.width * 0.8,
              ),
              SizedBox(height: size.height * 0.02),
              MyButton(
                onTap:() {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:(context) {
                        return SignInPage();
                      },
                    )
                  );
                }, 
                text: 'Sign In', width: size.width * 0.8,
              )
            ],
          ),
        ),
      ),
    );
  }
}