import 'package:artist_icon/screens/components/my_button.dart';
import 'package:artist_icon/screens/sign_in.dart';
import 'package:artist_icon/screens/signup.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LandScreen extends StatelessWidget {
  const LandScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
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
          Center(
            child: SizedBox(
              height: size.height,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: size.height * 0.08),
                    Text(
                      "ARTISTICON",
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                    // SizedBox(height: size.height * 0.08),
                    // Text("Where artists thrive",
                    //     style: GoogleFonts.nunito(
                    //         fontSize: 24,
                    //         fontWeight: FontWeight.bold,
                    //         color: Colors.black)),
                    SizedBox(height: size.height * 0.10),
                    Image.asset(
                      'assets/images/Artisticon_logo.png',
                      height: size.height * 0.15,
                    ),
                    SizedBox(height: size.height * 0.16),
                    Text(
                      'The Ultimate Creative Marketplace\n      Hire and Rent with ArtistIcon',
                      style: GoogleFonts.montserrat(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: size.height * 0.15),
                    MyButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignUpPage(),
                          ),
                        );
                      },
                      text: 'Sign Up',
                      width: size.width * 0.4,
                    ),
                    SizedBox(height: size.height * 0.02),
                    MyButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignInPage(),
                          ),
                        );
                      },
                      text: 'Sign In',
                      width: size.width * 0.4,
                    ),
                    // SizedBox(height: size.height * 0.030),
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
