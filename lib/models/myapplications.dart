class MyApplicationsModel {
  String? organization;
  String? title;
  String? status;

  MyApplicationsModel({
    this.organization,
    this.title,
    this.status,
  });

  MyApplicationsModel.fromMap(Map<String, dynamic>map){
    organization: 'organization';
    title: 'title';
    status: 'status';
  }

  Map<String, dynamic> toMap(){
    return {
      'organization': organization,
      'title': title,
      'status': status,
    };
  }
}
