class JobPostModel {
  String? jobid;
  String? provider;
  String? category;
  String? desc;
  String? phone;
  String? address;
  String? city;
  String? state;
  String? country;
  String? pay;
  DateTime? time;

  JobPostModel({
    this.jobid,
    this.provider,
    this.desc,
    this.category,
    this.phone,
    this.address,
    this.city,
    this.state,
    this.country,
    this.pay,
    this.time,
  });

  JobPostModel.fromMap(Map<String, dynamic> map){
    jobid = map["jobid"];
    provider = map["provider"];
    desc = map["desc"];
    category = map["category"];
    phone = map["phone"];
    address = map["address"];
    city = map["city"];
    state = map["state"];
    country = map["country"];
    pay = map["pay"];
    time = map["time"].toDate();
  }

  Map<String, dynamic> toMap(){
    return {
      "jobid": jobid,
      "provider": provider,
      "desc": desc,
      "category": category,
      "phone": phone,
      "address": address,
      "city": city,
      "state": state,
      "country": country,
      "pay": pay,
      "time": time,
    };
  }
}
