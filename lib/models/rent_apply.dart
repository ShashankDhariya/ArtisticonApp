class RentApplyModel {
  String? applyRid;
  String? name;
  String? hrs;
  String? people;
  String? phone;
  String? date;
  
  RentApplyModel({
    this.applyRid,
    this.name,
    this.hrs,
    this.people,
    this.phone,
    this.date,
  });

  RentApplyModel.fromMap(Map<String, dynamic> map){
    applyRid = map["applyRid"];
    name = map["name"];
    hrs = map["hrs"];
    people = map["people"];
    phone = map["phone"];
    date = map["date"];
  }

  Map<String, dynamic> toMap(){
    return {
      "applyRid": applyRid,
      "name": name,
      "hrs": hrs,
      "people": people,
      "phone": phone,
      "date": date,
    };
  }
}
