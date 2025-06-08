class DoctorModel {
  static const String collectionName = 'Doctors';

  final String fullName;
  final String email;
  final String phoneNumber;
  final String userType;
  final String? medicalLicenseNumber;
  final String? medicalSpecializatin;
  final String? workingHoursFrom;
  final String? workingHoursTo;
  final String? bio;
  final List<String>? workingDaysList;
  final List<String>? workingDays;

  DoctorModel({
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    required this.userType,
    this.medicalLicenseNumber,
    this.medicalSpecializatin,
    this.workingHoursFrom,
    this.workingHoursTo,
    this.bio,
    this.workingDaysList,
    this.workingDays,
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
      workingHoursFrom: json['workingHoursFrom'],
      workingHoursTo: json['workingHoursTo'],
      bio: json['bio'],
      workingDaysList: (json['workingDaysList'] as List<dynamic>?)
          ?.map((e) => e.toString())
          .toList(),
      workingDays: (json['workingDays'] as List<dynamic>?)
          ?.map((e) => e.toString())
          .toList(),
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
      'workingHoursFrom': workingHoursFrom,
      'workingHoursTo': workingHoursTo,
      'bio': bio,
      'workingDaysList': workingDaysList,
      'workingDays': workingDays,
    };
  }
}
