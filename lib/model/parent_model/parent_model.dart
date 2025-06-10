class ParentModel {
  final String fullName;
  final String email;
  final String phoneNumber;
  final String userType;
  final String doctorEmail;
  final String childName;

  ParentModel({
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    required this.userType,
    required this.doctorEmail,
    required this.childName,
  });

  factory ParentModel.fromJson(Map<String, dynamic> json) {
    return ParentModel(
      fullName: json['fullName'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      userType: json['userType'],
      doctorEmail: json['doctorEmail'] ?? '',
      childName: json['childName'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'email': email,
      'phoneNumber': phoneNumber,
      'userType': userType,
      'doctorEmail': doctorEmail,
      'childName': childName
    };
  }
}
