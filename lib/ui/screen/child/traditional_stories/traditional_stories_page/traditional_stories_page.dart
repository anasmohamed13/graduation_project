import 'package:flutter/material.dart';
import 'package:garduationproject/ui/util/app_assets.dart';
import 'package:url_launcher/url_launcher.dart';

class TraditionalStoriesPage extends StatelessWidget {
  static const String routeName = 'traditional_stories_page';

  const TraditionalStoriesPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final String category =
        ModalRoute.of(context)?.settings.arguments as String? ?? '5-8';

    final String title = category == '5-8'
        ? 'Stories for Kids Ages 5-8'
        : category == '8-10'
            ? 'Stories for Kids Ages 8-10'
            : 'Stories for Kids Ages 10+';
    final List<StoryData> stories = category == '5-8'
        ? [
            StoryData(
              imagePath: AppAssets.storyOfYesOrNO,
              storyUrl: 'https://youtu.be/FtPhTkvpLyI',
            ),
            StoryData(
              imagePath: AppAssets.jerryBox,
              storyUrl: 'https://www.freechildrenstories.com/jerrys-box',
            ),
            StoryData(
              imagePath: AppAssets.cricket,
              storyUrl:
                  'https://www.freechildrenstories.com/why-the-cricket-chirps',
            ),
            StoryData(
              imagePath: AppAssets.quokka,
              storyUrl:
                  'https://www.freechildrenstories.com/dont-hug-the-quokka',
            ),
            StoryData(
              imagePath: AppAssets.doHipposPlay,
              storyUrl:
                  'https://www.freechildrenstories.com/when-do-hippos-play',
            ),
            StoryData(
              imagePath: AppAssets.nobleGnarble,
              storyUrl:
                  'https://www.freechildrenstories.com/the-journey-of-the-noble-gnarble',
            ),
          ]
        : category == '8-10'
            ? [
                StoryData(
                  imagePath: 'assets/images/story7.png',
                  storyUrl:
                      'https://www.freechildrenstories.com/the-last-dinosaur',
                ),
                StoryData(
                  imagePath: 'assets/images/story8.png',
                  storyUrl:
                      'https://www.freechildrenstories.com/the-missing-snowman',
                ),
                StoryData(
                  imagePath: 'assets/images/story9.png',
                  storyUrl:
                      'https://www.freechildrenstories.com/the-secret-of-the-old-clock',
                ),
              ]
            : [
                StoryData(
                  imagePath: AppAssets.solarSnooks,
                  storyUrl: 'https://www.freechildrenstories.com/solar-snooks',
                ),
                StoryData(
                  imagePath: AppAssets.gemma,
                  storyUrl: 'https://www.freechildrenstories.com/gemma',
                ),
                StoryData(
                  imagePath: AppAssets.guardianOfLore,
                  storyUrl:
                      'https://www.freechildrenstories.com/guardians-of-lore',
                ),
              ];

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Stack(
              children: [
                Image.asset(
                  AppAssets.moutain,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  left: 30,
                  top: 30,
                  child: CircleAvatar(
                    backgroundColor: const Color.fromRGBO(241, 241, 241, 1),
                    radius: 25,
                    child: Center(
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.black),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Stack(
                children: [
                  Container(color: Colors.white),
                  Positioned(
                    top: 2,
                    left: 72,
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontSize: 22,
                        fontFamily: 'inter',
                        fontWeight: FontWeight.w900,
                        color: Color.fromRGBO(188, 0, 14, 1),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 50, left: 40, right: 38),
                    child: GridView.builder(
                      itemCount: stories.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 65,
                        mainAxisSpacing: 25,
                        childAspectRatio: 0.75,
                      ),
                      itemBuilder: (context, index) {
                        return BookCoverWidget(storyData: stories[index]);
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
  final StoryData storyData;

  Future<void> launchStoryUrl() async {
    try {
      final Uri url = Uri.parse(storyData.storyUrl);
      if (!await launchUrl(url, mode: LaunchMode.inAppWebView)) {
        throw 'Could not launch ${storyData.storyUrl}';
      }
    } catch (e) {
      debugPrint('Error launching URL: $e');
      // You could show a snackbar or dialog here to inform the user
    }
  }

  const BookCoverWidget({
    super.key,
    required this.storyData,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: launchStoryUrl,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(7, 9),
              blurRadius: 6,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.asset(
            storyData.imagePath,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

class StoryData {
  final String imagePath;
  final String storyUrl;
  //final String title;

  StoryData({
    required this.imagePath,
    required this.storyUrl,
    // required this.title,
  });
}
