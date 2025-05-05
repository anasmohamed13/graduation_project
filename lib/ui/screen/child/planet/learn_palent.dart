import 'package:flutter/material.dart';
import 'package:garduationproject/ui/screen/child/planet/science_planet/science_planet.dart';
import 'package:garduationproject/ui/util/app_assets.dart';

class LearnPlanet extends StatelessWidget {
  const LearnPlanet({super.key});
  static const String routeName = 'learn_palent';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 70),
          buildPlanet(
              onTap: () {
                Navigator.pushNamed(context, SciencePlanet.routeName);
              },
              imagePath: AppAssets.scienceCat,
              namePlanet: 'Science Planet'),
          const SizedBox(height: 90),
          buildPlanet(
              onTap: () {},
              imagePath: AppAssets.mathCat,
              namePlanet: 'Math Planet'),
          const SizedBox(height: 90),
          buildPlanet(
              onTap: () {},
              imagePath: AppAssets.gameCat,
              namePlanet: 'Fun Planet'),
        ],
      ),
    );
  }

  Row buildPlanet(
      {required String imagePath,
      required String namePlanet,
      required void Function()? onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        InkWell(
          onTap: onTap,
          child: Image.asset(
            imagePath,
            width: 150,
            height: 200,
            fit: BoxFit.contain,
          ),
        ),
        const SizedBox(width: 10),
        RotatedBox(
          quarterTurns: -3,
          child: Text(
            namePlanet,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}
