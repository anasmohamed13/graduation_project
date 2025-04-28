import 'package:flutter/material.dart';
import 'package:garduationproject/ui/screen/child/planet/science_planet/planet_Zone/planet_detail.dart';
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
    {
      "name": "Mercury",
      "image": AppAssets.mercuryPlanet,
      "description": "Mercury is the closest planet to the Sun."
    },
    {
      "name": "Venus",
      "image": AppAssets.venusPlanet,
      "description": "Venus is the hottest planet in our solar system."
    },
    {
      "name": "Earth",
      "image": AppAssets.earthPlanet,
      "description": "Earth is the only planet known to support life."
    },
    {
      "name": "Mars",
      "image": AppAssets.marsPlanet,
      "description": "Mars is known as the Red Planet."
    },
    {
      "name": "Jupiter",
      "image": AppAssets.jupiterPlanet,
      "description": "Jupiter is the largest planet in our solar system."
    },
    {
      "name": "Saturn",
      "image": AppAssets.saturnPlanet,
      "description": "Saturn is famous for its beautiful rings."
    },
    {
      "name": "Uranus",
      "image": AppAssets.uranusPlanet,
      "description": "Uranus rotates on its side!"
    },
    {
      "name": "Neptune",
      "image": AppAssets.neptunePlanet,
      "description": "Neptune has supersonic strong winds."
    },
  ];
  void navigateToPlanetDetail(Map<String, String> planet) {
    Navigator.pushNamed(
      context,
      PlanetDetail.routeName,
      arguments: {
        'name': planet['name']!,
        'image': planet['image']!,
        'description': planet['description']!,
      },
    );
  }

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
                GestureDetector(
                  onTap: () => navigateToPlanetDetail(planets[index]),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
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
                          quarterTurns: 1,
                          child: Image.asset(
                            planets[index]['image']!,
                            height: 80,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ],
                    ),
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
