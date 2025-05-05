import 'package:flutter/material.dart';
import 'package:garduationproject/ui/util/app_assets.dart';

class TraditionalStoriesPage extends StatelessWidget {
  static const String routeName = 'traditional_stories_page';
  // final String category;
  const TraditionalStoriesPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    /* final backgroundAsset =
        category == '5-8' ? AppAssets.morningMoutain : AppAssets.nightgMoutain;

    final title = category == '5-8'
        ? 'Stories for Kids Ages 5-8'
        : 'Stories for Kids Ages 10+';
        */
/*
    final stories = category == '5-8'
        ? [
            {
              'title': 'The Story of Yes and No',
              'image': 'assets/images/story1.png'
            },
            {'title': 'Jerry\'s Box', 'image': 'assets/images/story2.png'},
            {
              'title': 'WHY THE CRICKET CHIRPS?',
              'image': 'assets/images/story3.png'
            },
            {
              'title': 'Don\'t Hug Quokka!',
              'image': 'assets/images/story4.png'
            },
            {
              'title': 'WHEN DO HIPPOS PLAY',
              'image': 'assets/images/story5.png'
            },
            {
              'title': 'The Journey of Princess Gomala',
              'image': 'assets/images/story6.png'
            },
          ]
        : [
            {'title': 'SOLAR SHOCKS', 'image': 'assets/images/story7.png'},
            {'title': 'Gemma', 'image': 'assets/images/story8.png'},
            {
              'title': 'The Guardians of Love',
              'image': 'assets/images/story9.png'
            },
          ];
          */

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Stack(
              children: [
                Image.asset(
                  AppAssets.moutain, // backgroundAsset
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Row(
                  children: [
                    CircleAvatar(
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.red),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
              ],
            ),
            Expanded(
              child: Stack(
                children: [
                  Container(color: Colors.white),
                  const Positioned(
                    top: 2,
                    left: 72,
                    child: Text(
                      'Stories for Kids Ages 5-8', //title
                      style: TextStyle(
                        fontSize: 22,
                        fontFamily: 'inter',
                        fontWeight: FontWeight.w900,
                        color: Color.fromRGBO(188, 0, 14, 1),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(40),
                    child: GridView.builder(
                      itemCount: 6, //stories.length
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 45,
                        mainAxisSpacing: 12,
                        childAspectRatio: 0.75,
                      ),
                      itemBuilder: (context, index) {
                        // final story = stories[index];
                        return const BookCoverWidget(
                            /*imagePath: 'assets/images/story1.png'*/); //story['image']);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BookCoverWidget extends StatelessWidget {
  // final String imagePath;

  const BookCoverWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            offset: Offset(2, 4),
            blurRadius: 6,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        /*child: Image.asset(
          imagePath,
          fit: BoxFit.cover,
        ),*/
      ),
    );
  }
}
