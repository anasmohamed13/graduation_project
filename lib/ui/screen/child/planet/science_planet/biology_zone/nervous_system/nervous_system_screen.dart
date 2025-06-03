import 'package:flutter/material.dart';

class NervousSystemScreen extends StatelessWidget {
  static const String routeName = '/nervous-system-screen';
  const NervousSystemScreen ({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 118, 112, 201), 
      body: SafeArea(
        child: Row(
          children: [
            
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Image.asset(
                    'assets/image/nervgif.gif',
                    height: 300,
                    fit: BoxFit.contain, 
                  ),
                ),
              ),
            ),

            
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Transform.rotate(
                    angle: -90 * 3.1415927 / 180, 
                    child: Image.asset(
                      'assets/image/nervoustext.png',
                      height: 300,
                      width: 600, 
                      fit: BoxFit.contain, 
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
