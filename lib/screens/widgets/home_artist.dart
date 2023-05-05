import 'package:artist_icon/screens/widgets/job_list.dart';
import 'package:artist_icon/screens/widgets/search_bar.dart';
import 'package:flutter/material.dart';

import '../artistpage.dart';

class HomeArtist extends StatefulWidget {
  const HomeArtist({super.key});

  @override
  State<HomeArtist> createState() => _HomeArtistState();
}

class _HomeArtistState extends State<HomeArtist> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Container(),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  color: Colors.grey.withOpacity(0.1),
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [Artistpage(), SearchBar(), JobList()],
          )
        ],
      ),
    );
  }
}
