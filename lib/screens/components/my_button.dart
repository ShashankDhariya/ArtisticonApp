import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final double width;
  final String text;
  final Function() onPressed;
  const MyButton({super.key, required this.text, required this.width, required this.onPressed});

  @override
  Widget build(context) {
    var size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * 0.06,
      width: width,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: Theme.of(context).primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          )),
        onPressed: onPressed, 
        child: Text(text),
      )
    );
  }
}