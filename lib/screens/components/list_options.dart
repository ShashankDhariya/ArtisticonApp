import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ListOption extends StatelessWidget {
  final String text;
  final Icon icon;
  final Color color;
  final Function() ontap;
  const ListOption({super.key, required this.text, required this.icon, required this.color, required this.ontap});
  
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          leading: Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
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
        ),
      ),
    );
  }
}