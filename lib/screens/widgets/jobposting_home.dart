import 'package:artist_icon/screens/jobPosting.dart';
import 'package:artist_icon/screens/jobPosting.dart';
import 'package:flutter/material.dart';

class JobPost extends StatefulWidget {
  const JobPost({super.key});

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
                  color: Colors.grey.withOpacity(0.1),
                ),
              ),
            ],
          ),
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [JobPosting()],
            ),
          )
        ],
      ),
    );
  }
}
