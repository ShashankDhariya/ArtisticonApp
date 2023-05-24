import 'package:artist_icon/screens/widgets/picture.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:artist_icon/models/rentpost.dart';
import 'package:artist_icon/models/user.dart';
import 'package:artist_icon/screens/components/my_button.dart';
import 'package:artist_icon/screens/rent_now.dart';
import 'package:artist_icon/screens/widgets/icon_text.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

bool isLink(String text) {
  Uri? uri = Uri.tryParse(text);
  if (uri == null) return false;
  return uri.hasScheme && uri.hasAuthority;
}

class RentDetail extends StatelessWidget {
  final RentPostModel currRent;
  final UserModel userModel;
  final User firebaseUser;
  const RentDetail(
      {Key? key,
      required this.currRent,
      required this.userModel,
      required this.firebaseUser})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String location =
        '${currRent.address}, ${currRent.city}\n${currRent.state}, ${currRent.country}';
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
              width: 60,
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
                    Text(
                      currRent.provider.toString(),
                      style: GoogleFonts.nunito(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                SizedBox(height: size.height * 0.025),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(currRent.category.toString(),
                        style: GoogleFonts.nunito(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                        )),
                    InkWell(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return PicPage(img: currRent.pic.toString());
                        }));
                      },
                      child: CircleAvatar(
                          backgroundImage:NetworkImage(currRent.pic.toString())),
                    )
                  ],
                ),
                SizedBox(height: size.height * 0.025),
                IconText(Icons.location_on_outlined, location),
                SizedBox(height: size.height * 0.015),
                IconText(Icons.currency_rupee, currRent.pay.toString()),
                SizedBox(height: size.height * 0.02),
                Text('Requirements',
                    style: GoogleFonts.nunito(
                      fontWeight: FontWeight.bold,
                    )),
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
                            currRent.desc.toString(),
                            style: GoogleFonts.nunito(
                                wordSpacing: 2,
                                height: 1.5,
                                fontWeight: FontWeight.w500),
                          ),
                        )
                      ],
                    )),
                SizedBox(height: size.height * 0.015),
                Text('Gallery',
                  style: GoogleFonts.nunito(
                    fontWeight: FontWeight.bold,
                  )),
                SizedBox(height: size.height * 0.01),
                isLink(currRent.link.toString())
                ? GestureDetector(
                    onTap: () async {
                      if (!await launchUrl(
                        Uri.parse(currRent.link.toString()),
                        mode: LaunchMode.externalApplication,
                      )) {
                        throw Exception(
                            'Could not launch $Uri.parse(currApplicant.vid.toString()');
                      }
                    },
                    child: Row(
                      children: [
                        Text('Link',
                          style: GoogleFonts.nunito(
                              decoration:
                                  TextDecoration.underline,
                              color: const Color(0xFF43B1B7),
                              fontWeight: FontWeight.w600,
                              fontSize: 15),
                        ),
                        const Icon(Icons.link)
                      ],
                    ),
                  )
                : Text("No photo/video attached",
                  style: GoogleFonts.nunito(
                    color: const Color(0xFF43B1B7),
                    fontWeight: FontWeight.w500,
                    fontSize: 15),
                ),
                SizedBox(height: size.height * 0.025),
                currRent.uid.toString() == userModel.uid.toString()
                ? MyButton(
                    text: "Can't apply to own service",
                    width: double.infinity,
                    onPressed: () {})
                : MyButton(
                    text: 'Rent Now',
                    width: double.infinity,
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return RentNowPage(
                            rentPostModel: currRent,
                            userModel: userModel,
                            firebaseUser: firebaseUser,
                          );
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
