class ChildModel {
  String firstName;
  String gender;
  int age;
  String parentEmail;
  String? description;

  ChildModel({
    required this.firstName,
    required this.gender,
    required this.age,
    required this.parentEmail,
    this.description,
  });

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'gender': gender,
      'age': age,
      'parentEmail': parentEmail,
      'description': description,
    };
  }

  factory ChildModel.fromJson(Map<String, dynamic> json) {
    return ChildModel(
      firstName: json['firstName'] ?? '',
      gender: json['gender'] ?? '',
      age: json['age']?.toInt() ?? 0,
      parentEmail: json['parentEmail'] ?? '',
      description: json['description'],
    );
  }
}
