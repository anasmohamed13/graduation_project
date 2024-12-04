// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:garduationproject/ui/screen/hello/hello_page.dart';

import 'package:garduationproject/ui/util/app_assets.dart';

class Splash extends StatefulWidget {
  static const String routeName = 'splash';
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, HelloPage.routeName);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              AppAssets.splash,
            ),
          ),
        ),
      ),
    );

    //   Scaffold(
    //     body: Center(child: Image.asset(AppAssets.splash)),
    //   );
    // }
  }
}
