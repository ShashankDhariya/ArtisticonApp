import 'package:cloud_firestore/cloud_firestore.dart';

class MyListingsModel {
  String? category;
  String? address;
  String? pay;
  String? type;
  DateTime? time;
  List<String>? list;

  MyListingsModel({
    this.category,
    this.address,
    this.pay,
    this.type,
    this.time,
    this.list,
  });
  
  MyListingsModel.fromMap(Map<String, dynamic>map){
    category = map["category"];
    address = map["address"];
    pay = map["pay"];
    type = map["type"];
    time = map["time"].toDate();
    list = map["list"];
  }

  Map<String, dynamic> toMap(){
    return {
      "category": category,
      "address": address,
      "pay": pay,
      "type": type,
      "time": Timestamp.fromDate(time!),
      "list": list,
    };
  }
}