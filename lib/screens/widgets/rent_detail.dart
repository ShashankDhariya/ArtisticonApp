import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:artist_icon/models/rentpost.dart';
import 'package:artist_icon/models/user.dart';
import 'package:artist_icon/screens/components/my_button.dart';
import 'package:artist_icon/screens/rent_now.dart';
import 'package:artist_icon/screens/widgets/icon_text.dart';

class RentDetail extends StatelessWidget {
  final RentPostModel currRent;
  final UserModel userModel;
  final User firebaseUser;
  const RentDetail({
    Key? key,
    required this.currRent,
    required this.userModel,
    required this.firebaseUser,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String location = '${currRent.address}, ${currRent.city}\n${currRent.state}, ${currRent.country}';
    var size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(vertical: size.height * 0.01, horizontal: size.width * 0.05),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30),
        )),
      height: size.height * 0.5,
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
                    IconText(Icons.location_on_outlined, location),
                    IconText(Icons.access_time_outlined, currRent.pay.toString()),
                  ],
                ),
                SizedBox(height: size.height * 0.030),
                const Text('Requirements',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  )
                ),
                SizedBox(height: size.height * 0.015),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(width: size.width * 0.025),
                      ConstrainedBox(
                        constraints: const BoxConstraints(
                          maxWidth: 300,
                        ),
                        child: Text(
                          currRent.desc.toString(),
                          style: const TextStyle(
                            wordSpacing: 2,
                            height: 1.5,
                          ),
                        ),
                      )
                    ],
                  )
                ),
                SizedBox(height: size.height * 0.025),
                currRent.uid.toString == userModel.uid.toString? 
                MyButton(text: "Can't apply to own post", width: double.infinity, onPressed: () {})
                :
                MyButton(
                  text: 'Rent Now',
                  width: double.infinity,
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return RentNowPage(rentPostModel: currRent, userModel: userModel, firebaseUser: firebaseUser,);
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