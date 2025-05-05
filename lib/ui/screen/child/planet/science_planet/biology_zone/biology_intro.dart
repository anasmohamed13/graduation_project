import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'body_system_screen.dart';

class BiologyIntro extends StatelessWidget {
  static const String routeName = '/biology-intro-screen';
  const BiologyIntro({super.key});

  @override
  Widget build(BuildContext context) {
    return const BiologyIntroScreen();
  }
}

class BiologyIntroScreen extends StatefulWidget {
  const BiologyIntroScreen({super.key});

  @override
  State<BiologyIntroScreen> createState() => BiologyIntroScreenState();
}

class BiologyIntroScreenState extends State<BiologyIntroScreen> {
  @override
  void initState() {
    super.initState();

    // Landscape orientation
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);

    // After the frame is built, navigate to the BodySystemsScreen
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.pushNamed(context, BodySystemScreen.routeName);
    });
  }

  @override
  void dispose() {
    // Reset orientation when disposing
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/image/pinkscreen.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                const Expanded(
                  flex: 2,
                  child: Text(
                    'our body that works all the time in\n'
                    'order to feel alive and be healthy!\n'
                    'Like the heart that works as a\n'
                    'blood pump, the lungs that allow\n'
                    'us to breathe, and the stomach\n'
                    'that digests the food we eat.\n'
                    'Are we ready to discover each\n'
                    'organ and its benefits together?\n'
                    'Let’s start the magical journey\n'
                    'inside the human body!',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  flex: 1,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: RotationTransition(
                      turns: const AlwaysStoppedAnimation(0.75),
                      child: Image.asset(
                        'assets/image/introbiology.png',
                        width: 300,
                        height: 300,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
