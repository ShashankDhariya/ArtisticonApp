class RentPostModel {
  String? uid;
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
  String? pic;
  String? link;
  DateTime? time;

  RentPostModel({
    this.uid,
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
    this.pic,
    this.link,
    this.time,
  });

  RentPostModel.fromMap(Map<String, dynamic> map){
    uid = map["uid"];
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
    pic = map["pic"];
    link = map["link"];
    time = map["time"].toDate();
  }

  Map<String, dynamic> toMap(){
    return {
      "uid": uid,
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
      "pic": pic,
      "link": link,
      "time": time,
    };
  }
}