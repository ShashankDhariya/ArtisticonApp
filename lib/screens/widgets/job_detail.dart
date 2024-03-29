import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:artist_icon/models/jobpost.dart';
import 'package:artist_icon/models/user.dart';
import 'package:artist_icon/screens/apply_now.dart';
import 'package:artist_icon/screens/components/my_button.dart';
import 'package:artist_icon/screens/widgets/icon_text.dart';
import 'package:google_fonts/google_fonts.dart';

class JobDetail extends StatelessWidget {
  final JobPostModel currJob;
  final UserModel userModel;
  final User firebaseUser;
  const JobDetail(
      {Key? key,
      required this.currJob,
      required this.userModel,
      required this.firebaseUser})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String location =
        '${currJob.address}, ${currJob.city}\n${currJob.state}, ${currJob.country}';
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
      height: size.height * 0.5,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 5,
              width: 70,
              color: Colors.grey.withOpacity(0.3),
            ),
            SizedBox(height: size.height * 0.045),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.person),
                    SizedBox(width: size.width * 0.03),
                    Text(currJob.provider.toString(),
                        style: GoogleFonts.nunito(
                            fontSize: 18, fontWeight: FontWeight.w600)),
                  ],
                ),
                SizedBox(height: size.height * 0.025),
                Text(currJob.category.toString(),
                    style: GoogleFonts.nunito(
                        fontSize: 22, fontWeight: FontWeight.w700)),
                SizedBox(height: size.height * 0.025),
                IconText(Icons.location_on_outlined, location),
                SizedBox(height: size.height * 0.015),
                IconText(Icons.currency_rupee, currJob.pay.toString()),
                SizedBox(height: size.height * 0.020),
                Text('Requirements: ',
                    style: GoogleFonts.nunito(fontWeight: FontWeight.bold)),
                SizedBox(height: size.height * 0.007),
                Container(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(width: size.width * 0.025),
                        ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 300),
                          child: Text(
                            currJob.desc.toString(),
                            style: GoogleFonts.nunito(
                                wordSpacing: 2,
                                height: 1.5,
                                fontWeight: FontWeight.w500),
                          ),
                        )
                      ],
                    )),
                SizedBox(height: size.height * 0.025),
                currJob.uid.toString() == userModel.uid.toString()
                    ? MyButton(
                        text: "Can't apply to own job",
                        width: double.infinity,
                        onPressed: () {},
                      )
                    : MyButton(
                        text: 'Apply Now',
                        width: double.infinity,
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return ApplyNowScreen(
                                firebaseUser: firebaseUser,
                                jobpostmodel: currJob,
                                userModel: userModel);
                          }));
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
