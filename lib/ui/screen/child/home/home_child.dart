// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:garduationproject/ui/screen/child/planet/learn_palent.dart';
import 'package:garduationproject/ui/screen/child/social_stories/social_stories.dart';
import 'package:garduationproject/ui/screen/child/traditional_stories/traditional_stories_intro/traditional_stories_intro.dart';
import 'package:garduationproject/ui/screen/parent/gato_timer/gato_timer_service.dart';
import 'package:garduationproject/ui/util/app_assets.dart';

class HomeChild extends StatefulWidget {
  const HomeChild({super.key});
  static const String routeName = 'home_child';

  @override
  State<HomeChild> createState() => _HomeChildState();
}

class _HomeChildState extends State<HomeChild> {
  String? childName;

  @override
  void initState() {
    super.initState();
    fetchChildName();
    GatoTimerService().startTimer(context);
  }

  void fetchChildName() async {
    try {
      final parentQuery =
          await FirebaseFirestore.instance.collection('Parent').limit(1).get();

      if (parentQuery.docs.isNotEmpty) {
        final parentDoc = parentQuery.docs.first;

        final childrenQuery = await FirebaseFirestore.instance
            .collection('Parent')
            .doc(parentDoc.id)
            .collection('Children')
            .limit(1)
            .get();

        if (childrenQuery.docs.isNotEmpty) {
          final childData = childrenQuery.docs.first.data();
          setState(() {
            childName = childData['firstName'] ?? 'Child';
          });
        }
      }
    } catch (e) {
      print('Error: $e');
      setState(() {
        childName = 'Child';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          Stack(
            children: [
              Container(
                height: height * 0.4,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(AppAssets.homeChildBackground),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                top: height * 0.4,
                left: 0,
                right: 0,
                child: Container(
                  height: height * 0.9,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(50),
                      topLeft: Radius.circular(50),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Stack(
            children: [
              buildWelcomeBack(),
              buildLevelBar(),
              Positioned(
                  top: height * 0.4,
                  left: 30,
                  right: 20,
                  child: buildChallengeCard()),
              Positioned(top: height * 0.62, left: 20, child: titleActivity()),
              buildActivitySection(),
              buildNavBar(),
            ],
          ),
        ],
      ),
    );
  }

  Widget titleActivity() {
    return const Text(
      'Activities Section',
      style: TextStyle(
        fontSize: 20,
        fontFamily: 'inter',
        fontWeight: FontWeight.bold,
        color: Colors.black,
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
            const SizedBox(width: 15),
            buildIndicator(
              icon: Image.asset(AppAssets.levelIcon),
              width: 115,
              height: 50,
              text: 'Level 1',
            ),
            const SizedBox(width: 15),
            buildIndicator(
              icon: Image.asset(AppAssets.coinsIcon),
              width: 95,
              height: 50,
              text: '200',
            ),
            const SizedBox(width: 15),
            buildIndicator(
              icon: SvgPicture.asset(AppAssets.blueCalendarIcon),
              width: 125,
              height: 50,
              text: 'MyCalender',
            ),
          ],
        ),
      ),
    );
  }

  Widget buildIndicator({
    required Widget icon,
    required double width,
    required double height,
    required String text,
  }) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(60),
        color: Colors.white70,
      ),
      child: Row(
        children: [
          const SizedBox(width: 5),
          icon,
          const SizedBox(width: 5),
          Text(
            text,
            style: const TextStyle(color: Colors.black, fontSize: 15),
          ),
        ],
      ),
    );
  }

  Positioned buildWelcomeBack() {
    return Positioned(
      top: 165,
      left: 75,
      child: Column(
        children: [
          Text(
            'Welcome back, ${childName ?? '..'}',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          Image.asset(
            AppAssets.happyCat,
            width: 135,
            height: 135,
          ),
        ],
      ),
    );
  }

  Widget buildChallengeCard() {
    return Material(
      elevation: 6,
      borderRadius: BorderRadius.circular(30),
      child: Container(
        height: 180,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.white,
        ),
        child: Column(
          children: [
            const SizedBox(height: 10),
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
            const SizedBox(height: 5),
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
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                buildRowDailyChallenge(
                  image: AppAssets.cutecat,
                  numText: '10',
                  wordText: 'Activities',
                  wordTextColor: Colors.blue,
                ),
                const SizedBox(width: 75),
                buildRowDailyChallenge(
                  image: AppAssets.cutecat,
                  numText: '40 mins',
                  wordText: 'Learning Times',
                  wordTextColor: Colors.red,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Row buildRowDailyChallenge({
    required String image,
    required String numText,
    required String wordText,
    required Color wordTextColor,
  }) {
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
                fontSize: 13,
                color: wordTextColor,
                fontFamily: 'inter',
              ),
            ),
          ],
        ),
      ],
    );
  }

  Positioned buildActivitySection() {
    return Positioned(
      bottom: 175,
      left: 15,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              buildActivity(
                image: AppAssets.catreadingbook,
                text: 'Social Stories',
                onTap: () {
                  Navigator.pushNamed(context, SocialStoriesScreen.routeName);
                },
              ),
              const SizedBox(width: 25),
              buildActivity(
                image: AppAssets.catlaptop,
                text: 'Traditional Stories',
                onTap: () {
                  Navigator.pushNamed(
                      context, TraditionalStoriesIntro.routeName);
                },
              ),
              const SizedBox(width: 25),
              buildActivity(
                image: AppAssets.learncat,
                text: 'Learn Time',
                onTap: () {
                  Navigator.pushNamed(context, LearnPlanet.routeName);
                },
              ),
            ],
          ),
          const SizedBox(height: 25),
        ],
      ),
    );
  }

  Widget buildActivity({
    required String image,
    required String text,
    required void Function()? onTap,
  }) {
    return Column(
      children: [
        InkWell(onTap: onTap, child: Image.asset(image)),
        Text(
          text,
          style: const TextStyle(
            fontSize: 14,
            fontFamily: 'inter',
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  Positioned buildNavBar() {
    return Positioned(
      bottom: 20,
      right: 80,
      left: 80,
      child: Material(
        elevation: 7,
        borderRadius: BorderRadius.circular(40),
        child: Container(
          height: 50,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(40),
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // Add buttons here later
            ],
          ),
        ),
      ),
    );
  }
}
