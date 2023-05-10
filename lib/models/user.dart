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
    uid = map["uid"];
    username = map["username"];
    name = map["name"];
    profilePic = map["profilePic"];
    phone = map["phone"];
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