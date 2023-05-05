import 'package:artist_icon/models/job.dart';
import 'package:flutter/material.dart';

class JobItem extends StatelessWidget {
  final Job job;
  final bool showTime;
  const JobItem(this.job, {super.key, this.showTime = false});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 270,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.grey,
      ),
      child: const Text('Job Item'),
    );
  }
}
