import 'package:artist_icon/screens/widgets/job_item.dart';
import 'package:flutter/material.dart';
import 'package:artist_icon/models/job.dart';

class JobList extends StatelessWidget {
  final jobList = Job.generateJobs();

  JobList({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 25),
      height: 180,
      child: ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) => JobItem(jobList[index]),
          separatorBuilder: (_, index) => const SizedBox(
                width: 15,
                height: 15,
              ),
          itemCount: jobList.length),
    );
  }
}
