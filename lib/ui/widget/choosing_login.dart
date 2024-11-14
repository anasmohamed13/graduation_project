import 'package:flutter/material.dart';
import 'package:garduationproject/ui/util/app_assets.dart';

class ChoosingLogin extends StatelessWidget {
  const ChoosingLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        CircleAvatar(
          backgroundColor: Colors.white,
          backgroundImage: AssetImage(AppAssets.phone),
        ),
        CircleAvatar(
          backgroundColor: Colors.white,
          backgroundImage: AssetImage(AppAssets.appleID),
        ),
        CircleAvatar(
          backgroundColor: Colors.white,
          backgroundImage: AssetImage(AppAssets.gmail),
        ),
        CircleAvatar(
          radius: 30,
          backgroundColor: Colors.white,
          backgroundImage: AssetImage(AppAssets.facebook),
        ),
      ],
    );
  }
}
