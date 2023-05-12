class MyApplicationsModel {
  String? organization;
  String? title;
  String? status;
  DateTime? date;

  MyApplicationsModel({
    this.organization,
    this.title,
    this.status,
    this.date,
  });

  MyApplicationsModel.fromMap(Map<String, dynamic>map){
    organization = map['organization'];
    title = map['title'];
    status = map['status'];
    date = map['date'];
  }

  Map<String, dynamic> toMap(){
    return {
      'organization': organization,
      'title': title,
      'status': status,
      'date': date,
    };
  }
}