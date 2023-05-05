class Job {
  String provider;
  String title;
  String location;
  String time;
  String pay;
  List<String> req;
  Job(this.provider, this.title, this.location, this.time, this.pay, this.req);
  static List<Job> generateJobs() {
    return [
      Job(
        'Dance pvt Ltd',
        'Choreographer',
        'Rohini Sec 18\nNew delhi',
        'Part time',
        '3000',
        [
          'A Choreographer needed for a wedding events',
          'Wedding will last for 3-4 days',
          'Food and accomodation is covered',
          'Experienced candidates are preferable',
        ],
      ),

      Job(
        'Dance pvt Ltd',
        'Choreographer',
        'Rohini Sec 18\nNew delhi',
        'Part time',
        '3000',
        [
          'A Choreographer needed for a wedding events',
          'Wedding will last for 3-4 days',
          'Food and accomodation is covered',
          'Experienced candidates are preferable',
        ],
      ),

      Job(
        'Dance pvt Ltd',
        'Choreographer',
        'Rohini Sec 18\nNew delhi',
        'Part time',
        '3000',
        [
          'A Choreographer needed for a wedding events',
          'Wedding will last for 3-4 days',
          'Food and accomodation is covered',
          'Experienced candidates are preferable',
        ],
      ),

      Job(
        'Media Entertainment',
        'Photographer',
        'Gtb Nagar\nOld Delhi',
        'Part time',
        '2600',
        [
          'Photographer needed for a professional shoot',
          'Must be experienced',
          'Shoot will last for a day',
          'Travelling expense will be covered'
        ],
      ),
    ];
  }
}
