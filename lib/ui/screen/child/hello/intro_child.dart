import 'package:flutter/material.dart';

class IntroChild extends StatelessWidget {
    static const String routeName = '/intro-child'; 
  const IntroChild({super.key});

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
            // ignore: deprecated_member_use
            color: Colors.black.withOpacity(0.2),
          ),

          
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(flex: 2), 

              // Title Text
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
          ),
        ],
      ),
    );
  }
}
