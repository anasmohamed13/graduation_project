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
      "description":
          "Mercury is the smallest planet and closest to the Sun. It has no atmosphere to trap heat. Its surface is rocky and full of craters. Daytime temperatures are extremely high. Nights are freezing cold."
    },
    {
      "name": "Venus",
      "image": AppAssets.venusPlanet,
      "description":
          "Venus is covered by thick clouds of sulfuric acid. It's the hottest planet due to its greenhouse effect. The surface has mountains and volcanoes. A day lasts longer than a year. Winds blow at hurricane speeds."
    },
    {
      "name": "Earth",
      "image": AppAssets.earthPlanet,
      "description":
          "Earth is the only known planet with life. It has water, oxygen, and a magnetic field. Continents float on tectonic plates. Weather supports diverse ecosystems. The Moon stabilizes Earth’s rotation."
    },
    {
      "name": "Mars",
      "image": AppAssets.marsPlanet,
      "description":
          "Mars is known as the Red Planet. Its surface is dusty and rocky. It has the tallest volcano, Olympus Mons. There are signs of ancient water. Temperatures are very cold year-round."
    },
    {
      "name": "Jupiter",
      "image": AppAssets.jupiterPlanet,
      "description":
          "Jupiter is the largest planet in our system. It's a gas giant with no solid surface. Its Great Red Spot is a giant storm. Jupiter has over 90 moons. Strong magnetic fields surround the planet."
    },
    {
      "name": "Saturn",
      "image": AppAssets.saturnPlanet,
      "description":
          "Saturn is famous for its stunning rings. It's mostly made of hydrogen and helium. The rings are made of ice and rock. It has dozens of moons. Titan, its moon, has a thick atmosphere."
    },
    {
      "name": "Uranus",
      "image": AppAssets.uranusPlanet,
      "description":
          "Uranus spins on its side, unlike other planets. It's an icy giant with faint rings. The atmosphere contains methane. Temperatures are extremely low. Its bluish color comes from methane gas."
    },
    {
      "name": "Neptune",
      "image": AppAssets.neptunePlanet,
      "description":
          "Neptune is the farthest known planet. It has strong storms and fast winds. Its deep blue color is due to methane. It's an ice giant with a rocky core. Triton is its largest moon."
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
