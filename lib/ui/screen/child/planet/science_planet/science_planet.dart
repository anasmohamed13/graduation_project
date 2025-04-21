import 'package:flutter/material.dart';
import 'package:garduationproject/ui/util/app_assets.dart';

class SciencePlanet extends StatelessWidget {
  const SciencePlanet({super.key});
  static const String routeName = 'science_planet';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 165),
          buildZone(
              onTap: () {},
              imagePath: AppAssets.planetZone,
              namePlanet: 'Planet Zone'),
          const SizedBox(height: 90),
          buildZone(
              onTap: () {},
              imagePath: AppAssets.biologyZone,
              namePlanet: 'Biology zone'),
        ],
      ),
    );
  }

  Row buildZone(
      {required String imagePath,
      required String namePlanet,
      required void Function()? onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
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
        const SizedBox(width: 10),
        InkWell(
          onTap: onTap,
          child: Image.asset(
            imagePath,
            width: 185,
            height: 200,
            fit: BoxFit.contain,
          ),
        ),
      ],
    );
  }
}
