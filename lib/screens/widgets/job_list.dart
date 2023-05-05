import 'package:artist_icon/screens/widgets/job_item.dart';
import 'package:flutter/material.dart';

import '../../models/job.dart';

class JobList extends StatelessWidget {
  final jobList = Job.generateJobs();
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 25),
      height: 160,
      child: ListView.separated(
          padding: EdgeInsets.symmetric(horizontal: 25),
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) => JobItem(jobList[index]),
          separatorBuilder: (_, index) => const SizedBox(
                width: 15,
              ),
          itemCount: jobList.length),
    );
  }
}
