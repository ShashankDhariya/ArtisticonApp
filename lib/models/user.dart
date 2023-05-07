class UserModel {
  String? uid;
  String? username;
  String? name;
  String? profilePic;
  
  UserModel({
    this.uid,
    this.username,
    this.name,
    this.profilePic,
  });

  UserModel.fromMap(Map<String,dynamic> map){
    uid: map['uid'];
    username: map['username'];
    name: map['name'];
    profilePic: map['profilePic'];
  }

  Map<String, dynamic> toMap(){
    return {
      'uid': uid,
      'username': username,
      'name': name,
      'profilePic': profilePic,
    };
  }
}