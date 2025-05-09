import 'package:flutter/material.dart';
import 'package:garduationproject/ui/util/app_assets.dart';

class CountWithAlienIntro extends StatelessWidget {
  static const String routeName = 'count-with-alien-intro';
  const CountWithAlienIntro({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              AppAssets.backgroundCountWithAlienIntro,
              fit: BoxFit.cover,
            ),
          ),
          // Red planet with cat
          Positioned(
            top: 150,
            left: MediaQuery.of(context).size.width / 2 - 80,
            child: Image.asset(
              AppAssets.planet, // Your red planet image
              width: 160,
            ),
          ),
          Positioned(
            top: 70,
            left: 170,
            child: Image.asset(
              AppAssets.happyWhiteKittenCat, // Your cat image
              width: 120,
            ),
          ),
          // Centered text
          const Positioned(
            top: 350,
            left: 50,
            right: 50,
            child: Text(
              "Ready to count with your alien friends? Let's explore the galaxy one number at a time!",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontFamily: 'Inter',
                fontSize: 18,
                shadows: [
                  Shadow(
                    blurRadius: 4,
                    color: Colors.black,
                    offset: Offset(1, 1),
                  ),
                ],
              ),
            ),
          ),
          // Astronaut
          Positioned(
            bottom: 60,
            left: 20,
            child: Image.asset(
              AppAssets.humanAndAlien,
              width: MediaQuery.of(context).size.width * 0.9,
            ),
          ),
          // Alien
        ],
      ),
    );
  }
}
