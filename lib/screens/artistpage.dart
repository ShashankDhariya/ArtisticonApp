import 'package:artist_icon/screens/profile.dart';
import 'package:flutter/material.dart';

class Artistpage extends StatelessWidget {
  const Artistpage({super.key});

  @override
  Widget build(context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top,
          left: 25,
          right: 25,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text(
              'Welcome Groot',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            
            const Spacer(),
            GestureDetector(
              onTap:() {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const Profile();
                    },
                  )
                );
              },
              child: Image.asset(
                'assets/images/avatar.png',
                width: 50,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
