// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:garduationproject/ui/screen/child/planet/science_planet/biology_zone/cirulatory_system/circulatory_system_screen.dart';
import 'package:garduationproject/ui/screen/child/planet/science_planet/biology_zone/digestive_system/digestive_system_screen.dart';
import 'package:garduationproject/ui/screen/child/planet/science_planet/biology_zone/nervous_system/nervous_system_screen.dart';
import 'package:garduationproject/ui/screen/child/planet/science_planet/biology_zone/respiratory_system/respiratory_system_screen.dart';
import 'package:garduationproject/ui/screen/child/planet/science_planet/science_planet.dart';

class BodySystemScreen extends StatefulWidget {
  static const String routeName = '/body-system-screen';

  const BodySystemScreen({super.key});

  @override
  State<BodySystemScreen> createState() => BodySystemScreenState();
}

class BodySystemScreenState extends State<BodySystemScreen> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (!didPop) {
          Navigator.pushReplacementNamed(context, SciencePlanet.routeName);
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    buildSystemButton("Circulatory system", Colors.red, () {
                      Navigator.pushNamed(
                          context, CirculatorySystemScreen.routeName);
                    }),
                    const SizedBox(height: 16),
                    buildSystemButton("respiratory system", Colors.purple, () {
                      Navigator.pushNamed(
                          context, RespiratorySystemScreen.routeName);
                    }),
                    const SizedBox(height: 16),
                    buildSystemButton("Nervous system", Colors.orange, () {
                      Navigator.pushNamed(
                          context, NervousSystemScreen.routeName);
                    }),
                    const SizedBox(height: 16),
                    buildSystemButton("Digestive system", Colors.lightBlue, () {
                      Navigator.pushNamed(
                          context, DigestiveSystemScreen.routeName);
                    }),
                    const SizedBox(height: 16),
                  ],
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12.0),
                        child: Text(
                          "Now my friends, we will begin the journey of exploration inside our wonderful body! Our body has many systems, just like a football team, each system has an important role for us to be healthy and live a happy life.",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 24),
                      Expanded(
                          child: Center(
                        child: Transform.rotate(
                          angle: -1.5708,
                          child: SizedBox(
                            width: 500,
                            height: 290,
                            child: Image.asset(
                              'assets/image/systems.png',
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ))
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildSystemButton(String text, Color color, [VoidCallback? onTap]) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 180,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.4),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
