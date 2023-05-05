import 'package:artist_icon/models/job.dart';
import 'package:flutter/material.dart';

import 'icon_text.dart';

class JobItem extends StatelessWidget {
  final Job job;
  final bool showTime;
  const JobItem(this.job, {super.key, this.showTime = false});
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 250,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(job.provider,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ))
                  ],
                )
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Text(job.title,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconText(Icons.location_on_outlined, job.location),
              ],
            )
          ],
        ));
  }
}