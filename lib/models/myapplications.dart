import 'package:cloud_firestore/cloud_firestore.dart';

class MyApplicationsModel {
  String? appyid;
  String? id;
  String? name;
  String? category;
  String? type;
  String? address;
  String? pay;
  String? status;
  DateTime? date;

  MyApplicationsModel({
    this.appyid,
    this.id,
    this.name,
    this.category,
    this.type,
    this.address,
    this.pay,
    this.status,
    this.date,
  });

  MyApplicationsModel.fromMap(Map<String, dynamic>map){
    appyid = map['appyid'];
    id = map['id'];
    name = map['name'];
    category = map['category'];
    type = map['type'];
    address = map['address'];
    pay = map['pay'];
    status = map['status'];
    date = map['date'].toDate();
  }

  Map<String, dynamic> toMap(){
    return {
      'appyid': appyid,
      'id': id,
      'name': name,
      'category': category,
      'type': type,
      'address': address,
      'pay': pay,
      'status': status,
      'date': Timestamp.fromDate(date!),
    };
  }
}