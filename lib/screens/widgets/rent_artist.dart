import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:artist_icon/models/user.dart';
import 'package:artist_icon/screens/widgets/rent_list.dart';

class RentArtist extends StatefulWidget {
  final UserModel userModel;
  final User firebaseUser;
  const RentArtist({Key? key,required this.userModel, required this.firebaseUser}) : super(key: key);

  @override
  State<RentArtist> createState() => _RentArtistState();
}

class _RentArtistState extends State<RentArtist> {
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
                child: Container(color: Colors.grey.withOpacity(0.1)),
              ),
            ],
          ),
          RentList(firebaseUser: widget.firebaseUser, userModel: widget.userModel)
        ],
      ),
    );
  }
}