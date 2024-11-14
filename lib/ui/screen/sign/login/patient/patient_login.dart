import 'package:flutter/material.dart';
import 'package:garduationproject/ui/screen/sign/login/login_page.dart';

class PatientLogin extends StatelessWidget {
  static const String routName = 'patient';
  const PatientLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return const LoginPage(
      user: 'child',
      color: Color(0xff000001),
    );
  }
}
