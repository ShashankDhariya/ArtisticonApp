class MyListingsModel {
  String? category;
  String? address;
  String? pay;
  List<String>? list;

  MyListingsModel({
    this.category,
    this.address,
    this.pay,
    this.list,
  });
  
  MyListingsModel.fromMap(Map<String, dynamic>map){
    category: map["category"];
    address: map["address"];
    pay: map["pay"];
    list: map["list"];
  }

  Map<String, dynamic> toMap(){
    return {
      "category": category,
      "address": address,
      "pay": pay,
      "list": list,
    };
  }
}