import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:artist_icon/models/user.dart';
import 'package:artist_icon/screens/job_posting.dart';

class JobPost extends StatefulWidget {
  final UserModel userModel;
  final User firebaseUser;
  const JobPost({Key? key, required this.userModel, required this.firebaseUser})
      : super(key: key);

  @override
  State<JobPost> createState() => _JobPostState();
}

class _JobPostState extends State<JobPost> {
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
                JobPosting(
                  firebaseUser: widget.firebaseUser,
                  userModel: widget.userModel,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
