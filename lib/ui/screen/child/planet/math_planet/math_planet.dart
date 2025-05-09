import 'package:flutter/material.dart';
import 'package:garduationproject/ui/util/app_assets.dart';
import 'package:garduationproject/ui/screen/child/planet/math_planet/game/count_with_alien/count_with_alien_intro.dart';

class MathPlanet extends StatelessWidget {
  static const String routeName = 'math_planet';
  const MathPlanet({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                AppAssets.mathBackground,
                fit: BoxFit.cover,
              ),
            ),

            Positioned(
              left: 25,
              top: 20,
              child: CircleAvatar(
                backgroundColor: Colors.white.withOpacity(0.7),
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.black),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ),

            Positioned(
              top: -7,
              left: 0,
              right: 0,
              child: Center(
                child: Image.asset(
                  AppAssets.number123,
                  height: 150,
                ),
              ),
            ),
            // Welcome message
            const Positioned(
              top: 135,
              left: 35,
              right: 35,
              child: Center(
                child: Text(
                  "Welcome to the Math Galaxy\nwhere numbers shine, planets count, and every problem is an adventure!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),

            Positioned(
              top: 225,
              left: 0,
              right: 0,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        gameTile(
                            AppAssets.cosmicCompare, 'Cosmic Compare', () {}),
                        const SizedBox(height: 24),
                        gameTile(AppAssets.alienMathMission,
                            'Alien Math Mission', () {}),
                      ],
                    ),
                    const SizedBox(width: 24),
                    Column(
                      children: [
                        gameTile(
                            AppAssets.shapPlanet, 'Shape Planet Rescue', () {}),
                        const SizedBox(height: 24),
                        gameTile(AppAssets.countWithAliens, 'Count with Aliens',
                            () {
                          Navigator.pushNamed(
                              context, CountWithAlienIntro.routeName);
                        }),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            Positioned(
              bottom: 120,
              left: 0,
              right: 0,
              child: Center(
                child: Image.asset(
                  AppAssets.whiteKittenCat,
                  height: 100,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget gameTile(String imagePath, String label, void Function()? onTap) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: Container(
            width: 150,
            height: 145,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          label,
          style: const TextStyle(
              fontWeight: FontWeight.bold, fontSize: 13, color: Colors.white),
        ),
      ],
    );
  }
}
