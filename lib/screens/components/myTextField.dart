import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final controller;
  final icon;
  final String hintText;
  final bool obsecure;
  const MyTextField({super.key, this.controller, required this.hintText, required this.obsecure, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.height * 0.03,) ,
      child: TextField(
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(20)
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(20),
          ),
          prefixIcon: icon,
          fillColor: Colors.grey.shade200,
          filled: true,
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey.shade500)
        ),
        obscureText: obsecure,
      ),
    );
  }
}