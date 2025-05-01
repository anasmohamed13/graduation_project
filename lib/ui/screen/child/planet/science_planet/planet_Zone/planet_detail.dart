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
    final String name = args['name']!;
    final String image = args['image']!;
    final String description = args['description']!;
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              AppAssets.backgroundplanetdetail,
              fit: BoxFit.cover,
              filterQuality: FilterQuality.high,
            ),
          ),
          Column(
            children: [
              const SizedBox(
                height: 80,
              ),
              Align(
                alignment: Alignment.topCenter,
                child: SizedBox(
                  height: 200,
                  child: Image.asset(
                    image,
                    scale: 4,
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Container(
                    width: 200,
                    height: 500,
                    padding: const EdgeInsets.all(40),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: RotatedBox(
                      quarterTurns: 1, // Rotates 90 degrees clockwise
                      child: Text(
                        softWrap: true,
                        maxLines: 4,
                        description,
                        style: const TextStyle(
                          color: Colors.black,
                          fontFamily: 'inter',
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
