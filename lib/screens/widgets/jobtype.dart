import 'package:artist_icon/screens/apply_now.dart';
import 'package:artist_icon/screens/components/my_button.dart';
import 'package:artist_icon/screens/signup.dart';
import 'package:artist_icon/screens/widgets/icon_text.dart';
import 'package:flutter/material.dart';
import '../../models/job.dart';
import '../components/my_text_field.dart';

class PostOrRentModal extends StatelessWidget {
  const PostOrRentModal({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(25),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          )),
      height: 500,
      child: Text('5327'),
    );
  }
}
