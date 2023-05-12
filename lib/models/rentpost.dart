class RentPostModel {
  String? rentid;
  String? provider;
  String? category;
  String? desc;
  String? phone;
  String? address;
  String? city;
  String? state;
  String? country;
  String? pay;
  String? duration;

  RentPostModel({
    this.rentid,
    this.provider,
    this.desc,
    this.category,
    this.phone,
    this.address,
    this.city,
    this.state,
    this.country,
    this.pay,
    this.duration,
  });

  RentPostModel.fromMap(Map<String, dynamic> map){
    rentid = map["rentid"];
    provider = map["provider"];
    desc = map["desc"];
    category = map["category"];
    phone = map["phone"];
    address = map["address"];
    city = map["city"];
    state = map["state"];
    country = map["country"];
    pay = map["pay"];
    duration = map["duration"];
  }

  Map<String, dynamic> toMap(){
    return {
      "rentid": rentid,
      "provider": provider,
      "desc": desc,
      "category": category,
      "phone": phone,
      "address": address,
      "city": city,
      "state": state,
      "country": country,
      "pay": pay,
      "duration": duration,
    };
  }
}
