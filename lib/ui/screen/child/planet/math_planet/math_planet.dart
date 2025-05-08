import 'package:flutter/material.dart';
import 'package:garduationproject/ui/util/app_assets.dart';

class MathPlanet extends StatelessWidget {
  static const String routeName = 'math_planet';
  const MathPlanet({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            // Background image
            // Positioned.fill(
            //   child: Image.asset(
            //     'assets/images/galaxy_bg.jpg', // Replace with your image path
            //     fit: BoxFit.cover,
            //   ),
            // ),

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
                  AppAssets.number123, // Replace with your actual image path
                  height: 150, // Adjust as needed
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
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
            // Games grid
            Positioned(
              top: 225,
              left: 0,
              right: 0,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // First column
                    Column(
                      children: [
                        gameTile(AppAssets.cosmicCompare, 'Cosmic Compare'),
                        const SizedBox(height: 24),
                        gameTile(
                            AppAssets.alienMathMission, 'Alien Math Mission'),
                      ],
                    ),
                    const SizedBox(width: 24),
                    // Second column
                    Column(
                      children: [
                        gameTile(AppAssets.shapPlanet, 'Shape Planet Rescue'),
                        const SizedBox(height: 24),
                        gameTile(
                            AppAssets.countWithAliens, 'Count with Aliens'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            // Cat image at the bottom
            Positioned(
              bottom: 16,
              left: 0,
              right: 0,
              child: Center(
                child: Image.asset(
                  AppAssets.whiteKittenCat, // Replace with your cat image path
                  height: 100,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget gameTile(String imagePath, String label) {
    return Column(
      children: [
        Container(
          width: 180,
          height: 150,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Image.asset(
              imagePath,
              fit: BoxFit.cover, // Ensures the image covers the container
            ),
          ),
        ),
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
        ),
      ],
    );
  }
}
