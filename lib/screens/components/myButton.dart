import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final Function() onTap;
  const MyButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 175,
        padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.025),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Center(
          child: Text(
            'Sign In',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}