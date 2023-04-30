import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ListOption extends StatelessWidget {
  final String text;
  final Icon icon;
  final Color color;
  const ListOption({super.key, required this.text, required this.icon, required this.color});
  
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Colors.grey.shade300,
        ),
        child: icon,
      ),
      title: Text(text, 
        style: TextStyle(
          color: color,
        ),
      ),
      trailing: const Icon(CupertinoIcons.right_chevron),
    );
  }
}