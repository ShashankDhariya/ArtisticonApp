class Job {
  String provider;
  String category;
  String phone;
  String address;
  String city;
  String state;
  String country;
  String pay;

  List<String> req;
  Job(this.provider, this.category, this.phone, this.address, this.city,
      this.state, this.country, this.pay, this.req);
  static List<Job> generateJobs() {
    return [
      Job(
        'Dance pvt Ltd',
        'Choreographer',
        '9014527825',
        'Rohini Sec 18',
        'Delhi',
        'New Delhi',
        'India',
        '2000',
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
        '9014527825',
        'Clement Town',
        'Dehradun',
        'Uttarakhand',
        'India',
        '4000',
        [
          'A Photographer needed for a photoshoot',
          'Photoshoot will last for a single day',
          'Experienced candidates are preferable',
          'Food expenses will be reimbursed',
        ],
      ),
    ];
  }
}
