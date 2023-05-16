import 'package:flutter/material.dart';

class IconText extends StatelessWidget {
  final IconData icon;
  final String text;
  const IconText(this.icon, this.text, {super.key});

  @override
  Widget build(context) {
    return Row(
      children: [
        Icon(icon, color: Colors.yellow.shade600),
        Text(text, style: const TextStyle(fontSize: 12, color: Colors.grey),)
      ],
    );
  }
}
