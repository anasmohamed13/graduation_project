import 'package:flutter/material.dart';

class ChildSplash extends StatelessWidget {
  static const String routeName = 'childsplash';
  const ChildSplash({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
         
          Positioned.fill(
            child: Image.asset(
              'assets/image/splashbackground.gif',
              fit: BoxFit.cover,
            ),
          ),

          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'assets/image/sleepycat.png',
                  width: 150,
                  height: 150,
                ),
                const SizedBox(height: 20),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Text(
                    "GATO heard the clock say: Time to rest! I will close my eyes a little and come back to you tomorrow",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      height: 1.5,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
