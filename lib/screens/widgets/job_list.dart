import 'package:artist_icon/screens/widgets/job_item.dart';
import 'package:flutter/material.dart';
import 'package:artist_icon/models/job.dart';

import 'job_detail.dart';

class JobList extends StatelessWidget {
  final jobList = Job.generateJobs();

  JobList({super.key});
  @override
  Widget build(context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 25),
      height: 160,
      child: ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) => GestureDetector(
              onTap: () {
                showModalBottomSheet(
                    backgroundColor: Colors.transparent,
                    isScrollControlled: true,
                    context: context,
                    builder: (context) => JobDetail(jobList[index]));
              },
              child: JobItem(jobList[index])),
          separatorBuilder: (_, index) => const SizedBox(
                width: 15,
              ),
          itemCount: jobList.length),
    );
  }
}
