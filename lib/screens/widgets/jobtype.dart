import 'package:artist_icon/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:artist_icon/screens/widgets/jobposting_home.dart';
import 'package:artist_icon/screens/widgets/rentservice_home.dart';

class PostOrRentModal extends StatelessWidget {
  final UserModel userModel;
  final User firebaseUser;
  const PostOrRentModal(
      {Key? key, required this.userModel, required this.firebaseUser})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.04, vertical: size.height * 0.009),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      height: size.height * 0.45,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return JobPost(
                        firebaseUser: firebaseUser, userModel: userModel);
                  },
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFF43B1B7),
                borderRadius: BorderRadius.circular(20),
              ),
              width: size.width * 0.44,
              height: size.height * 0.15,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.work_outline,
                      size: 40, color: Colors.grey.shade100),
                  SizedBox(height: size.height * 0.01),
                  Text(
                    'Post a Job',
                    style: GoogleFonts.nunito(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade100,
                        fontSize: 18),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return RentService(
                        firebaseUser: firebaseUser, userModel: userModel);
                  },
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFF43B1B7),
                borderRadius: BorderRadius.circular(20),
              ),
              width: size.width * 0.44,
              height: size.height * 0.15,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.home_work_outlined,
                      size: 40, color: Colors.grey.shade100),
                  SizedBox(height: size.height * 0.01),
                  Text(
                    'Rent a Service',
                    style: GoogleFonts.nunito(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade100,
                        fontSize: 18),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
