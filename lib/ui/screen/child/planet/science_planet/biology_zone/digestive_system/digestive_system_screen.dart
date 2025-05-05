import 'package:flutter/material.dart';

class DigestiveSystemScreen extends StatelessWidget {
  static const String routeName = '/digestive-system-screen';
  const DigestiveSystemScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 236, 171, 145),
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
                    'assets/image/digestgif.gif',
                    height: 300,
                     width: 700,
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
                      'assets/image/digestext.png',
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
