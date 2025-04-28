import 'package:flutter/material.dart';

void main() => runApp(const BiologyIntro());

class BiologyIntro extends StatelessWidget {
  static const String routeName = '/biology-intro';
  const BiologyIntro({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'biology intro',
      debugShowCheckedModeBanner: false,
      home: BiologyIntroScreen(),
    );
  }
}

class BiologyIntroScreen extends StatelessWidget {
  const BiologyIntroScreen({super.key});

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
            child: Row( // Use a Row instead of a Column
              children: [
                const Expanded( 
                  flex: 2,
                  child: Text(
                      'our body that work all the time in\n'
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
