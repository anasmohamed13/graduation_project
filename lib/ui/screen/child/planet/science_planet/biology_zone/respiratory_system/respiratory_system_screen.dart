import 'package:flutter/material.dart';

class RespiratorySystemScreen extends StatelessWidget {
  static const String routeName = '/respiratory-system-screen';
  const RespiratorySystemScreen ({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFB7E3DC), 
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
                    'assets/image/respgif.gif',
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
                      'assets/image/resptext.png',
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
