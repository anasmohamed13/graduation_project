class ParentModel {
  final String fullName;
  final String email;
  final String phoneNumber;
  final String userType;
  final String doctorEmail; // New field

  ParentModel({
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    required this.userType,
    required this.doctorEmail, // Include in constructor
  });

  factory ParentModel.fromJson(Map<String, dynamic> json) {
    return ParentModel(
      fullName: json['fullName'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      userType: json['userType'],
      doctorEmail: json['doctorEmail'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'email': email,
      'phoneNumber': phoneNumber,
      'userType': userType,
      'doctorEmail': doctorEmail,
    };
  }
}
