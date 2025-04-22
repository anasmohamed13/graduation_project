import 'package:flutter/material.dart';
import 'package:garduationproject/ui/util/app_assets.dart';

class PlanetZone extends StatefulWidget {
  static const String routeName = 'planet_zone';
  const PlanetZone({super.key});

  @override
  State<PlanetZone> createState() => _PlanetZoneState();
}

class _PlanetZoneState extends State<PlanetZone> {
  final ScrollController scrollController = ScrollController();

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  final List<Map<String, String>> planets = const [
    {"name": "Mercury", "image": AppAssets.mercuryPlanet},
    {"name": "Venus", "image": AppAssets.venusPlanet},
    {"name": "Earth", "image": AppAssets.earthPlanet},
    {"name": "Mars", "image": AppAssets.marsPlanet},
    {"name": "Jupiter", "image": AppAssets.jupiterPlanet},
    {"name": "Saturn", "image": AppAssets.saturnPlanet},
    {"name": "Uranus", "image": AppAssets.uranusPlanet},
    {"name": "Neptune", "image": AppAssets.neptunePlanet},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: ListView.builder(
        controller: scrollController,
        padding: const EdgeInsets.symmetric(vertical: 20),
        itemCount: planets.length + 1,
        itemBuilder: (context, index) {
          return Column(
            children: [
              if (index < planets.length)
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        planets[index]['name']!,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 16),
                      RotatedBox(
                        quarterTurns: 1, // rotate 90° clockwise
                        child: Image.asset(
                          planets[index]['image']!,
                          height: 80,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ],
                  ),
                )
              else
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      SizedBox(height: 20),
                      Text(
                        "This is our Solar System\nLet's discover it!",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      SizedBox(height: 40),
                    ],
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
