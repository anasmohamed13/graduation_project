class ChildModel {
  String id;
  String firstName;
  String gender;
  int age;
  String parentEmail;
  String? description;

  ChildModel({
    required this.id,
    required this.firstName,
    required this.gender,
    required this.age,
    required this.parentEmail,
    this.description,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'gender': gender,
      'age': age,
      'parentEmail': parentEmail,
      'description': description,
    };
  }

  factory ChildModel.fromJson(Map<String, dynamic> map) {
    return ChildModel(
      id: map['id'] ?? '',
      firstName: map['firstName'] ?? '',
      gender: map['gender'] ?? '',
      age: map['age']?.toInt() ?? 0,
      parentEmail: map['parentEmail'] ?? '',
      description: map['description'],
    );
  }
}
