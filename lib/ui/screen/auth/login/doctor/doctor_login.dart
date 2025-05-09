import 'package:flutter/material.dart';
import 'package:garduationproject/ui/screen/auth/login/login_page.dart';

class DoctorLogin extends StatelessWidget {
  static const String routName = 'Doctor';
  const DoctorLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return const LoginPage(
      user: 'Doctor',
      color: Color(0xff37908a),
    );
  }
}
