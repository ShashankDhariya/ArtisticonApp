import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final double width;
  final String text;
  final Function() onTap;
  const MyButton({super.key, required this.onTap, required this.text, required this.width});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.025),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}