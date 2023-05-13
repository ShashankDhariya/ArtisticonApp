import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final double width;
  final String text;
  final Function() onPressed;
  const MyButton(
    {super.key,
      required this.text,
      required this.width,
      required this.onPressed});

  final buttoncolor = const Color(0xFF43B1B7);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 45,
        width: width,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              elevation: 0,
              backgroundColor: const Color(0xFF43B1B7),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              )),
          onPressed: onPressed,
          child: Text(text),
        ));
  }
}
