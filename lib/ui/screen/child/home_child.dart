import 'package:flutter/material.dart';
import 'package:garduationproject/ui/util/app_assets.dart';

class HomeChild extends StatelessWidget {
  const HomeChild({super.key});
  static const String routeName = 'home_child';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Stack(children: [
                Container(
                  height: 300,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(AppAssets.appleID),
                    ),
                  ),
                ),
                buildLevelBar(),
              ]),
              Container(
                height: 567.38,
                decoration: const BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(50),
                    topLeft: Radius.circular(50),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Positioned buildLevelBar() {
    return Positioned(
      top: 30,
      left: 5,
      child: Container(
        height: 65,
        width: 400,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(60),
          color: Colors.red,
        ),
      ),
    );
  }
}
