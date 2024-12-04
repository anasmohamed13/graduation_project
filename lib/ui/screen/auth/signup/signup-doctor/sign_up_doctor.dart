import 'package:flutter/material.dart';
import 'package:garduationproject/ui/screen/auth/signup/sign_up_page.dart';

class SignUpDoctor extends StatelessWidget {
  static const String routeName = 'SignUpDoctor';
  const SignUpDoctor({super.key});

  @override
  Widget build(BuildContext context) {
    return const SignUpPage(
      userType: 'Doctor',
    );
  }
}
