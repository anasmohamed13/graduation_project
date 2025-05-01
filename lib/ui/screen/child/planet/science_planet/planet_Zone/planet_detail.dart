// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:garduationproject/ui/util/app_assets.dart';

class PlanetDetail extends StatelessWidget {
  static const String routeName = 'planet_detail';
  const PlanetDetail({super.key});

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              AppAssets.backgroundplanetdetail,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
