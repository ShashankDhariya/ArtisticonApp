import 'package:artist_icon/screens/widgets/job_item.dart';
import 'package:flutter/material.dart';
import 'package:artist_icon/models/job.dart';
import 'job_detail.dart';

class JobList extends StatelessWidget {
  final jobList = Job.generateJobs();

  JobList({super.key});
  @override
  Widget build(context) {
    return Column(
      children: [
        Container(
          height: 370,
          child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              scrollDirection: Axis.vertical,
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
                    height: 15,
                  ),
              itemCount: jobList.length),
        ),
      ],
    );
  }
}
