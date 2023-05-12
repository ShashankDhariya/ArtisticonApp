// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:artist_icon/models/rent.dart';
import 'package:artist_icon/models/rentpost.dart';
import 'package:artist_icon/screens/components/my_button.dart';
import 'package:artist_icon/screens/rent_now.dart';
import 'package:artist_icon/screens/widgets/icon_text.dart';

class RentDetail extends StatelessWidget {
  final RentPostModel currRent;
  const RentDetail({
    Key? key,
    required this.currRent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: size.height * 0.01, horizontal: size.width * 0.05),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          )),
      height: size.height * 0.6,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 5,
              width: 60,
              color: Colors.grey.withOpacity(0.3),
            ),
            SizedBox(height: size.height * 0.045),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      height: 20,
                      width: 20,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey.withOpacity(0.1),
                      ),
                    ),
                    SizedBox(width: size.width * 0.03),
                    Text(
                      currRent.provider.toString(),
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: size.height * 0.025),
                Text(currRent.category.toString(),
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    )),
                SizedBox(height: size.height * 0.025),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconText(Icons.location_on_outlined, currRent.city.toString()),
                    IconText(Icons.access_time_outlined, currRent.pay.toString()),
                  ],
                ),
                SizedBox(height: size.height * 0.030),
                const Text('Requirements',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  )
                ),
                SizedBox(height: size.height * 0.025),
                MyButton(
                  text: 'Rent Now',
                  width: double.infinity,
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return const RentNowPage();
                      },
                    ));
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
