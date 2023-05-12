import 'package:flutter/material.dart';
import 'package:artist_icon/models/jobpost.dart';
import 'package:artist_icon/screens/apply_now.dart';
import 'package:artist_icon/screens/components/my_button.dart';
import 'package:artist_icon/screens/widgets/icon_text.dart';

class JobDetail extends StatelessWidget {
  final JobPostModel currJob;
  const JobDetail({
    Key? key,
    required this.currJob,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String location = '${currJob.address}, ${currJob.city}\n${currJob.state}, ${currJob.country}';
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
                      currJob.provider.toString(),
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: size.height * 0.025),
                Text(currJob.category.toString(),
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    )),
                SizedBox(height: size.height * 0.025),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconText(Icons.location_on_outlined, location),
                    IconText(Icons.currency_rupee, currJob.pay.toString()),
                  ],
                ),
                SizedBox(height: size.height * 0.030),
                const Text('Requirements: ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    )),
                SizedBox(height: size.height * 0.01),
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
                          currJob.desc.toString(),
                          style: const TextStyle(
                            wordSpacing: 2,
                            height: 1.5,
                          ),
                        ),
                      )
                    ],
                  )),
                SizedBox(height: size.height * 0.025),
                MyButton(
                  text: 'Apply Now',
                  width: double.infinity,
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return const ApplyNowScreen();
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
