import 'package:flutter/material.dart';
import 'package:garduationproject/ui/screen/child/home/home_child.dart';

class IntroChild extends StatefulWidget {
  static const String routeName = '/intro-child';
  const IntroChild({super.key});

  @override
  State<IntroChild> createState() => _IntroChildState();
}

class _IntroChildState extends State<IntroChild> {
  bool _showContent = true;

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 8), () {
      if (mounted) {
        setState(() {
          _showContent = false;
        });
        // Navigate after fade out animation completes
        Future.delayed(const Duration(milliseconds: 500), () {
          if (mounted) {
            Navigator.pushReplacementNamed(context, HomeChild.routeName);
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/image/backgroundintro.jpg',
            fit: BoxFit.cover,
          ),
          Container(
            color: Colors.black.withOpacity(0.2),
          ),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
            child: _showContent
                ? Column(
                    key: const ValueKey('content'),
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Spacer(flex: 2),
                      const Text(
                        "HI I'M GATO",
                        style: TextStyle(
                          fontSize: 28,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "Ready to go on a fun adventure?",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                      const Spacer(),
                      Image.asset(
                        'assets/image/introchild.webp',
                        width: 150,
                      ),
                      const Spacer(flex: 2),
                    ],
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}
