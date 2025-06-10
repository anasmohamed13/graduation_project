class DoctorModel {
  final String fullName;
  final String email;
  final String phoneNumber;
  final String userType;
  final String? medicalLicenseNumber;
  final String? medicalSpecializatin;

  DoctorModel({
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    required this.userType,
    this.medicalLicenseNumber,
    this.medicalSpecializatin,
  });

  /// fromJson constructor
  factory DoctorModel.fromJson(Map<String, dynamic> json) {
    return DoctorModel(
      fullName: json['fullName'] ?? '',
      email: json['email'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      userType: json['userType'] ?? '',
      medicalLicenseNumber: json['medicalLicenseNumber'],
      medicalSpecializatin: json['medicalSpecializatin'],
    );
  }

  /// toJson method
  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'email': email,
      'phoneNumber': phoneNumber,
      'userType': userType,
      'medicalLicenseNumber': medicalLicenseNumber,
      'medicalSpecializatin': medicalSpecializatin,
    };
  }
}
