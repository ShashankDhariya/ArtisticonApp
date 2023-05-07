class MyListingsModel {
  String? title;

  MyListingsModel({
    this.title,
  });
  
  MyListingsModel.fromMap(Map<String, dynamic>map){
    title: 'title';
  }

  Map<String, dynamic> toMap(){
    return {
      'title': title,
    };
  }
}