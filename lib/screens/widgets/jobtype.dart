import 'package:flutter/material.dart';

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
