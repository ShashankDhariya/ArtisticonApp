class JobPostModel {
  String? organization;
  String? title;
  String? category;
  String? city;
  num? salary;
  String? requirements;

  JobPostModel({
    this.organization,
    this.title,
    this.category,
    this.city,
    this.salary,
    this.requirements,
  });

  JobPostModel.fromMap(Map<String, dynamic> map){
    organization: map['organization'];
    title: map['title'];
    category: map['category'];
    city: map['city'];
    salary: map['salary'];
    requirements: map['requirements'];
  }

  Map<String, dynamic> toMap(){
    return {
      'organization': organization,
      'title': title,
      'category': category,
      'city': city,
      'salary': salary,
      'requirements': requirements,
    };
  }

}
