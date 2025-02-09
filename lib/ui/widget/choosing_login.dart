// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:garduationproject/model/services/firebase_service.dart';
import 'package:garduationproject/ui/util/app_assets.dart';

class ChoosingLogin extends StatelessWidget {
  ChoosingLogin({super.key});
  final FirebaseService firebaseService = FirebaseService();
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        InkWell(
          onTap: () {},
          child: CircleAvatar(
            backgroundColor: Colors.white,
            child: Image.asset(AppAssets.phone),
          ),
        ),
        InkWell(
          onTap: () {
            firebaseService.signInWithGoogle();
          },
          child: CircleAvatar(
            backgroundColor: Colors.white,
            child: Image.asset(AppAssets.gmail),
          ),
        ),
      ],
    );
  }
}
