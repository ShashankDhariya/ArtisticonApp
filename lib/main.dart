import 'dart:developer';
import 'package:artist_icon/models/get_firebase_user.dart';
import 'package:artist_icon/models/user.dart';
import 'package:artist_icon/splash.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  User? currentUser = FirebaseAuth.instance.currentUser;
  if(currentUser != null){
    UserModel? fetchUserModel = await FirebaseHelper.getuserModelById(currentUser.uid);
    log(currentUser.uid);
    if(fetchUserModel != null){
      runApp(MyAppLoggedIn(userModel: fetchUserModel, firebaseUser: currentUser));
    }
    else {
      runApp(const MyApp());
    }
  }
  else {
    runApp(const MyApp());
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: const Color(0xFF43B1B7),
      ),
      home: const Splash(),
    );
  }
}

class MyAppLoggedIn extends StatelessWidget{
  final UserModel userModel;
  final User firebaseUser;
  
  const MyAppLoggedIn({super.key, required this.userModel, required this.firebaseUser});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashLoggedIn(firebaseUser: firebaseUser, userModel: userModel,)
    );
  }
}