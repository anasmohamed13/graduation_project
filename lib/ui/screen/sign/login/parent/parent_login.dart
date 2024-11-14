import 'package:flutter/material.dart';
import 'package:garduationproject/ui/screen/sign/login/login_page.dart';

class ParentLogin extends StatelessWidget {
  static const String routName = 'ParentLogin';
  const ParentLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return const LoginPage(
      user: 'parent',
      color: Color(0xff5c7ad4),
    );
  }
}
