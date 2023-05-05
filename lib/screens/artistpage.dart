import 'package:artist_icon/screens/profile.dart';
import 'package:artist_icon/screens/widgets/search_bar.dart';
import 'package:flutter/material.dart';

class Artistpage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
              behavior: HitTestBehavior.translucent,
              onTap: () {
                const Profile();
              },
              child: AbsorbPointer(
                child: ClipOval(
                  child: Image.asset(
                    'assets/images/avatar.png',
                    width: 50,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
