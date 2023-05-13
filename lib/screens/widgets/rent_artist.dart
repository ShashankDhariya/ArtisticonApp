import 'package:artist_icon/screens/widgets/rent_list.dart';
import 'package:flutter/material.dart';

class RentArtist extends StatefulWidget {
  const RentArtist({super.key});

  @override
  State<RentArtist> createState() => _RentArtistState();
}

class _RentArtistState extends State<RentArtist> {
  @override
  Widget build(context) {
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
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [RentList()],
            ),
          )
        ],
      ),
    );
  }
}
