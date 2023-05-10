class UserModel {
  String? uid;
  String? username;
  String? name;
  String? profilePic;
  String? phone;
  
  UserModel({
    this.uid,
    this.username,
    this.profilePic,
    this.name,
    this.phone,
  });

  UserModel.fromMap(Map<String,dynamic> map){
    this.uid = map["uid"];
    this.username = map["username"];
    this.name = map["name"];
    this.profilePic = map["profilePic"];
    this.phone = map["phone"];
  }

  Map<String, dynamic> toMap(){
    return {
      "uid": uid,
      "username": username,
      "name": name,
      "profilePic": profilePic,
      "phone": phone,
    };
  }
}