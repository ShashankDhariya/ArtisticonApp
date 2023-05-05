import 'package:artist_icon/screens/landScreen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    _navigatetohome();
  }

  _navigatetohome() async {
   await Future.delayed(const Duration(milliseconds: 2500), (){});
    Navigator.pushReplacement(
      context, 
      MaterialPageRoute(
        builder:(context) {
          return const LandScreen();
        },
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.99,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/artistIcon.jpeg',
                height: MediaQuery.of(context).size.height * 0.18,
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.2,),
              Lottie.asset('assets/images/loadingCircles.json', 
                height: MediaQuery.of(context).size.height * 0.15,
              ),
            ],
          ),
        ),
      ),
    );
  }
}