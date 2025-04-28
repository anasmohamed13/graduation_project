import 'package:flutter/material.dart';
import 'package:garduationproject/ui/screen/child/biology_intro.dart';
import 'package:flutter/services.dart';

class IntroBiology extends StatefulWidget {
  static const String routeName = '/intro-biology';
  const IntroBiology({super.key});

  @override
  IntroBiologyState createState() => IntroBiologyState();
}

class IntroBiologyState extends State<IntroBiology> {
  @override
  void initState() {
    super.initState();
     SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);

    Future.delayed(const Duration(seconds: 15), () {
      if (mounted) {
        
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const BiologyIntro()),
        );
      }
    });
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
                    'Hello my friends!\n'
                    'Do you know that our body is\n'
                    'like a big team in which each\n'
                    'one has his own job? Not\n'
                    'only do we have senses like\n'
                    'the eyes and nose that we\n'
                    'see and smell, but we also\n'
                    'have organs inside',
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
                  flex: 2,
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
