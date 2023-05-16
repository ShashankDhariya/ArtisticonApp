import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:artist_icon/models/user.dart';
import 'package:artist_icon/screens/renting_service.dart';

class RentService extends StatefulWidget {
  final UserModel userModel;
  final User firebaseUser;
  const RentService({Key? key, required this.userModel, required this.firebaseUser}) : super(key: key);

  @override
  State<RentService> createState() => _RentServiceState();
}

class _RentServiceState extends State<RentService> {
  @override
  Widget build(BuildContext context) {
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
                  color: Colors.grey.withOpacity(0.06),
                ),
              ),
            ],
          ),
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RentingService(firebaseUser: widget.firebaseUser, userModel: widget.userModel)
              ],
            ),
          )
        ],
      ),
    );
  }
}