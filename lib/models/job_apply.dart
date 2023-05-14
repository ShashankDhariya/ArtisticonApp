class JobApplyModel {
  String? applyJid;
  String? name;
  String? vid;
  String? img;
  String? phone;
  String? portfolio;

  JobApplyModel({
    this.applyJid,
    this.name,
    this.vid,
    this.img,
    this.phone,
    this.portfolio,
  });

  JobApplyModel.fromMap(Map<String, dynamic> map){
    applyJid = map["applyJid"];
    name = map["name"];
    vid = map["vid"];
    img = map["img"];
    phone = map["phone"];
    portfolio = map["portfolio"];
  }

  Map<String, dynamic> toMap(){
    return{
      "applyJid": applyJid,
      "name": name,
      "vid": vid,
      "img": img,
      "phone": phone,
      "portfolio": portfolio,
    };
  }
}
