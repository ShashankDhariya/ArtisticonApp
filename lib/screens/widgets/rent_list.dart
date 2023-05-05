import 'package:artist_icon/screens/widgets/rent_item.dart';
import 'package:flutter/material.dart';
import '../../models/rent.dart';

class RentList extends StatelessWidget {
  final rentList = Rent.generateRent();

  RentList({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 25),
      height: 160,
      child: ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) => RentItem(rentList[index]),
          separatorBuilder: (_, index) => const SizedBox(
                width: 15,
              ),
          itemCount: rentList.length),
    );
  }
}
