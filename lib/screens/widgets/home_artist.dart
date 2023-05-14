import 'package:artist_icon/models/user.dart';
import 'package:artist_icon/screens/widgets/job_list.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeArtist extends StatefulWidget {
  final UserModel userModel;
  final User firebaseUser;
  const HomeArtist({super.key, required this.userModel, required this.firebaseUser});

  @override
  State<HomeArtist> createState() => _HomeArtistState();
}

class _HomeArtistState extends State<HomeArtist> {
  @override
  Widget build(context) {
    return Scaffold(
      body: Stack(
        children: [
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Container(),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  color: Colors.grey.withOpacity(0.1),
                ),
              ),
            ],
          ),
            JobList(firebaseUser: widget.firebaseUser, userModel: widget.userModel)
        ],
      ),
    );
  }
}