// import 'package:artist_icon/models/user.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:lottie/lottie.dart';
// import 'package:artist_icon/screens/components/my_button.dart';
// import 'package:artist_icon/screens/widgets/jobposting_home.dart';
// import 'package:artist_icon/screens/widgets/rentservice_home.dart';
//
// class PostOrRentModal extends StatelessWidget {
//   final UserModel userModel;
//   final User firebaseUser;
//   const PostOrRentModal(
//       {Key? key, required this.userModel, required this.firebaseUser})
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     var size = MediaQuery.of(context).size;
//     return Container(
//         padding: EdgeInsets.symmetric(
//             horizontal: size.width * 0.04, vertical: size.height * 0.009),
//         decoration: BoxDecoration(
//             color: Colors.grey.shade100,
//             borderRadius: const BorderRadius.only(
//               topLeft: Radius.circular(30),
//               topRight: Radius.circular(30),
//             )),
//         height: size.height * 0.45,
//         child: Column(children: [
//           // Container(
//           //   height: 5,
//           //   width: 60,
//           //   color: Colors.grey.withOpacity(0.3),
//           // ),
//           // Lottie.asset('assets/images/addIcon.json',
//           //     height: size.height * 0.25),
//           MyButton(
//             text: 'Post a Job',
//             width: double.infinity,
//             onPressed: () {
//               Navigator.push(context, MaterialPageRoute(
//                 builder: (context) {
//                   return JobPost(
//                       firebaseUser: firebaseUser, userModel: userModel);
//                 },
//               ));
//             },
//           ),
//           SizedBox(height: size.height * 0.03),
//           MyButton(
//             text: 'Rent a Service',
//             width: double.infinity,
//             onPressed: () {
//               Navigator.push(context, MaterialPageRoute(
//                 builder: (context) {
//                   return RentService(
//                       firebaseUser: firebaseUser, userModel: userModel);
//                 },
//               ));
//             },
//           ),
//         ]));
//   }
// }
import 'package:artist_icon/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:artist_icon/screens/components/my_button.dart';
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
                  const Icon(Icons.work_outline, size: 40, color: Colors.black),
                  SizedBox(height: size.height * 0.01),
                  Text(
                    'Post a Job',
                    style: GoogleFonts.nunito(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade300,
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
                  const Icon(Icons.home_work_outlined,
                      size: 40, color: Colors.black),
                  SizedBox(height: size.height * 0.01),
                  Text(
                    'Rent a Service',
                    style: GoogleFonts.nunito(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade300,
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
