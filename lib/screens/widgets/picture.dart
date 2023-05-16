import 'package:flutter/material.dart';

class PicPage extends StatelessWidget {
  final String img;
  const PicPage({Key? key, required this.img}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          const Center(
            child: CircularProgressIndicator(),
          ),
          Center(child: Image.network(img)),
        ],
      )
    );
  }
}
