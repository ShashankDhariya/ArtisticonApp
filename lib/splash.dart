import 'package:artist_icon/models/user.dart';
import 'package:artist_icon/screens/home.dart';
import 'package:artist_icon/screens/land_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key});
  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    _navigateToLand();
  }

  Future<void> _navigateToLand() async {
    await Future.delayed(const Duration(milliseconds: 2500));
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LandScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/Artisticon_logo.png',
              height: MediaQuery.of(context).size.height * 0.18,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.2,
            ),
            Lottie.asset(
              'assets/images/loadingCircles.json',
              height: MediaQuery.of(context).size.height * 0.15,
            ),
          ],
        ),
      ),
    );
  }
}

class SplashLoggedIn extends StatefulWidget {
  final UserModel userModel;
  final User firebaseUser;
  const SplashLoggedIn({
    Key? key,
    required this.userModel,
    required this.firebaseUser,
  });
  @override
  State<SplashLoggedIn> createState() => _SplashLoggedInState();
}

class _SplashLoggedInState extends State<SplashLoggedIn> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  Future<void> _navigateToHome() async {
    await Future.delayed(const Duration(milliseconds: 2500));
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => HomePage(
          firebaseUser: widget.firebaseUser,
          userModel: widget.userModel,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/Artisticon_logo.png',
              height: MediaQuery.of(context).size.height * 0.18,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.2,
            ),
            Lottie.asset(
              'assets/images/loadingCircles.json',
              height: MediaQuery.of(context).size.height * 0.15,
            ),
          ],
        ),
      ),
    );
  }
}
//opt done
