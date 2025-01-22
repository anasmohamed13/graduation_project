// ignore_for_file: non_constant_identifier_names

class UserModel {
  static String collectionParent = "Parent";
  static String collectionDoctor = "Doctor";
  final String fullName;
  final String email;
  final String phoneNumber;
  final String userType;
  final String? medicalLicenseNumber;
  final String? MedicalSpecializatin;

  UserModel({
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    required this.userType,
    this.medicalLicenseNumber,
    this.MedicalSpecializatin,
  });
  UserModel.fromJson(Map<String, dynamic> json)
      : fullName = json['fullName'],
        email = json['email'],
        phoneNumber = json['phoneNumber'],
        userType = json['userType'],
        medicalLicenseNumber = json['medicalLicenseNumber'],
        MedicalSpecializatin = json['MedicalSpecializatin'];

  // To JSON method
  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'email': email,
      'phoneNumber': phoneNumber,
      'userType': userType,
      'medicalLicenseNumber': medicalLicenseNumber,
      'medicalSpecialization': MedicalSpecializatin,
    };
  }
}
