class Rent {
  String provider;
  String title;
  String location;
  String time;
  String pay;
  List<String> req;
  Rent(this.provider, this.title, this.location, this.time, this.pay, this.req);
  static List<Rent> generateRent() {
    return [
      Rent(
        'Prakash Studios',
        'Studio for rent',
        'Rohini Sec 18\nNew delhi',
        'Part time',
        '2000/hr',
        [
          'Studio available for rent',
          'you can conduct dance,singing and zumba classes',
          'Fully furnished with audio system',
          'Full length mirrors available',
        ],
      ),
      Rent(
        'Shashank Costumes',
        'Costumes for rent',
        'Patel Chest, Mukherjee Nagar\nOld Delhi',
        'Part time',
        '1500/hr',
        [
          'Any type of Costumes available for rent at affordable prices',
          'Cotton materials that suits any weather conditions',
          'Negotiable prices',
        ],
      ),
    ];
  }
}
