import 'package:artist_icon/screens/components/my_button.dart';
import 'package:artist_icon/screens/widgets/jobposting_home.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class PostOrRentModal extends StatelessWidget {
  const PostOrRentModal({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.04, vertical: size.height * 0.009),
      decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          )),
      height: size.height * 0.45,
      child: Column(
        children: [
          Container(
            height: 5,
            width: 60,
            color: Colors.grey.withOpacity(0.3),
          ),
          Lottie.asset('assets/images/addIcon.json', height: size.height * 0.25),
          MyButton(text: 'Post a Job', width: double.infinity,
            onPressed:() {
              Navigator.push(
                context, 
                MaterialPageRoute(
                  builder:(context) {
                    return const JobPost();
                  },
                )
              );
            },
          ),
          SizedBox(height: size.height * 0.03),
          MyButton(text: 'Rent a Service', width: double.infinity,
            onPressed:() {
              Navigator.push(
                context, 
                MaterialPageRoute(
                  builder:(context) {
                    return const JobPost();
                  },
                )
              );
            },),
        ]
      )
    );
  }
}
