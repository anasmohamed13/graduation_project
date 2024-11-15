import 'package:flutter/material.dart';
import 'package:garduationproject/ui/util/app_assets.dart';

class ChoosingLogin extends StatelessWidget {
  const ChoosingLogin({super.key});

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
          onTap: () {},
          child: CircleAvatar(
            backgroundColor: Colors.white,
            child: Image.asset(AppAssets.appleID),
          ),
        ),
        InkWell(
          onTap: () {},
          child: CircleAvatar(
            backgroundColor: Colors.white,
            child: Image.asset(AppAssets.gmail),
          ),
        ),
        InkWell(
          onTap: () {},
          child: CircleAvatar(
            radius: 30,
            backgroundColor: Colors.white,
            child: Image.asset(AppAssets.facebook),
          ),
        ),
      ],
    );
  }
}
