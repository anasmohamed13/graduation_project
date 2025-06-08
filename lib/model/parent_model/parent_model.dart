class ParentModel {
  final String fullName;
  final String email;
  final String phoneNumber;
  final String userType;

  ParentModel({
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    required this.userType,
  });

  factory ParentModel.fromJson(Map<String, dynamic> json) {
    return ParentModel(
      fullName: json['fullName'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      userType: json['userType'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'email': email,
      'phoneNumber': phoneNumber,
      'userType': userType,
    };
  }
}
