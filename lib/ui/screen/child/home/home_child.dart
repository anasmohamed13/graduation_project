// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:garduationproject/ui/screen/child/planet/learn_palent.dart';
import 'package:garduationproject/ui/screen/child/traditional_stories/traditional_stories_intro/traditional_stories_intro.dart';
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
  }

  void fetchChildName() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        print('No authenticated user found');
        return;
      }

      print('Current user (child): ${user.uid}');

      // Since children are stored under Parent/{parentEmail}/Children/{childName}
      // We need to search through all parents to find this child
      final parentQuery =
          await FirebaseFirestore.instance.collection('Parent').get();

      for (var parentDoc in parentQuery.docs) {
        print('Searching in parent: ${parentDoc.id}');

        final childrenQuery = await FirebaseFirestore.instance
            .collection('Parent')
            .doc(parentDoc.id)
            .collection('Children')
            .get();

        for (var childDoc in childrenQuery.docs) {
          print('Found child document: ${childDoc.id}');
          final childData = childDoc.data();
          print('Child data: $childData');

          // For now, we'll get the first child we find
          // You might want to add logic to match the specific child to the current user
          if (childData.containsKey('firstName')) {
            setState(() {
              childName = childData['firstName'];
            });
            print('Child name found: $childName');
            return;
          }
        }
      }

      print('No child found in any parent document');
    } catch (e) {
      print('Error fetching child name: $e');
    }
  }

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
                  buildWelcomeBack(),
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
                  buildChallengeCard(),
                  titleActivity(),
                  buildActivitySection(),
                  buildNavBar(),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget titleActivity() {
    return const Positioned(
      bottom: 335,
      left: 50,
      child: Text(
        'Activities Section',
        style: TextStyle(
          fontSize: 20,
          fontFamily: 'inter',
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
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
              width: 111,
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
        color: Colors.white12,
      ),
      child: Row(
        children: [
          const SizedBox(width: 5),
          icon,
          const SizedBox(width: 5),
          Text(
            text,
            style: const TextStyle(color: Colors.grey, fontSize: 15),
          ),
        ],
      ),
    );
  }

  Positioned buildWelcomeBack() {
    return Positioned(
      top: 100,
      left: 65,
      child: Padding(
        padding: const EdgeInsets.all(16),
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
              width: 150,
              height: 150,
            ),
          ],
        ),
      ),
    );
  }

  Positioned buildChallengeCard() {
    return Positioned(
      top: 0,
      left: 30,
      right: 20,
      child: Material(
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
                onTap: () {},
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
