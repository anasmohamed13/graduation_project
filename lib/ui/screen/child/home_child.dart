import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
              Stack(
                children: [
                  Container(
                    height: 300,
                    decoration: const BoxDecoration(
                      color: Colors.green,
                    ),
                  ),
                  buildLevelBar(),
                  buildWelcomeBack()
                ],
              ),
              Stack(
                children: [
                  Container(
                    height: 567.38,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(50),
                        topLeft: Radius.circular(50),
                      ),
                    ),
                  ),
                  buildChallengeCard()
                ],
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
        height: 70,
        width: 411,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(60),
          color: Colors.white54,
        ),
        child: Row(
          children: [
            const SizedBox(
              width: 15,
            ),
            buildIndicator(
                icon: Image.asset(AppAssets.levelIcon),
                width: 115,
                height: 50,
                text: 'Level 1'),
            const SizedBox(
              width: 15,
            ),
            buildIndicator(
                icon: Image.asset(AppAssets.coinsIcon),
                width: 95,
                height: 50,
                text: '200'),
            const SizedBox(
              width: 15,
            ),
            buildIndicator(
                icon: SvgPicture.asset(AppAssets.blueCalendarIcon),
                width: 111,
                height: 50,
                text: 'MyCalender'),
          ],
        ),
      ),
    );
  }

  buildIndicator(
      {required Widget icon,
      required double width,
      required double height,
      required String text}) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(60),
        color: Colors.white12,
      ),
      child: Row(children: [
        const SizedBox(
          width: 5,
        ),
        icon,
        const SizedBox(
          width: 5,
        ),
        Text(
          text,
          style: const TextStyle(color: Colors.grey, fontSize: 15),
        ),
      ]),
    );
  }

  buildWelcomeBack() {
    return Positioned(
      top: 100,
      left: 65,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text(
              'Welcome back, Sarah',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Image.asset(
              AppAssets.happyCat,
              width: 150,
              height: 150,
            ),
          ],
        ),
      ),
    );
  }

  buildChallengeCard() {
    return Positioned(
      top: 0,
      left: 30,
      right: 20,
      child: Material(
        elevation: 6,
        borderRadius: BorderRadius.circular(30),
        child: Container(
          height: 180,
          width: 10,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30), color: Colors.white),
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  const SizedBox(width: 8),
                  buildRowDailyChallenge(
                    wordText: 'Daily Challenge',
                    image: AppAssets.bookmarker,
                    numText: '10 of 20',
                    wordTextColor: Colors.grey,
                  ),
                  const SizedBox(width: 145),
                  const Icon(Icons.more_horiz_outlined, color: Colors.grey),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              const Divider(
                thickness: 1,
                color: Colors.grey,
                indent: 50,
                endIndent: 50,
              ),
              const Row(
                children: [
                  SizedBox(width: 14),
                  Text(
                    'So for today',
                    style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'inter',
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  buildRowDailyChallenge(
                      image: AppAssets.cutecat,
                      numText: '10',
                      wordText: 'Activities',
                      wordTextColor: Colors.blue),
                  const SizedBox(
                    width: 75,
                  ),
                  buildRowDailyChallenge(
                    image: AppAssets.cutecat,
                    numText: '40 mins',
                    wordText: 'Learning Times',
                    wordTextColor: Colors.red,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Row buildRowDailyChallenge(
      {required String image,
      required String numText,
      required String wordText,
      required Color wordTextColor}) {
    return Row(
      children: [
        Image.asset(image),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              numText,
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              wordText,
              style: TextStyle(
                  fontSize: 13, color: wordTextColor, fontFamily: 'inter'),
            ),
          ],
        ),
      ],
    );
  }
}
