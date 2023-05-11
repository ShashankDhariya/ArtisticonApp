import 'package:artist_icon/screens/apply_now.dart';
import 'package:artist_icon/screens/components/my_button.dart';
import 'package:artist_icon/screens/widgets/icon_text.dart';
import 'package:flutter/material.dart';
import 'package:artist_icon/models/job.dart';

class JobDetail extends StatelessWidget {
  final Job job;
  const JobDetail(this.job, {super.key});

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
                      job.provider,
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: size.height * 0.025),
                Text(job.category,
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    )),
                SizedBox(height: size.height * 0.025),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconText(Icons.location_on_outlined, job.city),
                    IconText(Icons.currency_rupee, job.pay),
                  ],
                ),
                SizedBox(height: size.height * 0.030),
                const Text('Requirements',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    )),
                SizedBox(height: size.height * 0.01),
                ...job.req
                    .map((e) => Container(
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(top: 10),
                              height: 5,
                              width: 5,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(width: size.width * 0.025),
                            ConstrainedBox(
                              constraints: const BoxConstraints(
                                maxWidth: 300,
                              ),
                              child: Text(
                                e,
                                style: const TextStyle(
                                  wordSpacing: 2,
                                  height: 1.5,
                                ),
                              ),
                            )
                          ],
                        )))
                    .toList(),
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
