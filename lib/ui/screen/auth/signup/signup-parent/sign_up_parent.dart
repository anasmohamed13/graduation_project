import 'package:flutter/material.dart';
import 'package:garduationproject/ui/screen/auth/signup/sign_up_page.dart';

class SignUpParent extends StatelessWidget {
  static const String routeName = 'SignUpParent';
  const SignUpParent({super.key});

  @override
  Widget build(BuildContext context) {
    return const SignUpPage(
      userType: 'Parent',
    );
  }
}
