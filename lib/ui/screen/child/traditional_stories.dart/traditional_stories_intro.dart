import 'package:flutter/material.dart';

class TraditionalStoriesIntro extends StatelessWidget {
   static const String routeName = '/traditional-stories-intro';

  const TraditionalStoriesIntro({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          
          Positioned.fill(
            child: Image.asset(
              'assets/image/traditionalintro.jpg',
              fit: BoxFit.cover,
            ),
          ),

         
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    // ignore: deprecated_member_use
                    color: Colors.white.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.black, width: 2),
                  ),
                  child: const Text(
                    'HELLO MY FRIEND, THIS SECTION IS FOR TRADITIONAL STORIES\n'
                    'LETS HAVE SOME FUN TOGETHER BUT FIRST PLEASE SELECT YOUR AGE RANGE',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),

                const SizedBox(height: 40),
                Center(
                  child: Image.asset(
                    'assets/image/tradcat.png',
                    height: 150,
                    fit: BoxFit.contain,
                  ),
                ),

                const Spacer(),
                Center(
                  child: Column(
                     children: [
                      _buildTextButton(
                        text: 'Stories for Kids Ages 5-8',
                        textColor: Colors.pink,
                        onPressed: () => Navigator.pushNamed(context, '/stories-5-8'), //change the path(Anas)
                      ),
                      const SizedBox(height: 20),
                      _buildTextButton(
                        text: 'Stories for Kids Ages 8-10',
                        textColor: Colors.purple,
                        onPressed: () => Navigator.pushNamed(context, '/stories-8-10'),  //change the path(Anas)
                      ),
                      const SizedBox(height: 20),
                      _buildTextButton(
                        text: 'Stories for Kids Ages 10+',
                        textColor: Colors.blue,
                        onPressed: () => Navigator.pushNamed(context, '/stories-10-plus'),  //change the path(Anas)
                      ),
                    ],
                  ),
                ),

                const Spacer(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextButton({
    required String text,
    required Color textColor,
    required VoidCallback onPressed,
  }) {
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: Colors.transparent,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: textColor,
          shadows: [
            Shadow(
              blurRadius: 4.0,
              // ignore: deprecated_member_use
              color: Colors.black.withOpacity(0.3),
              offset: const Offset(1.0, 1.0),
            ),
          ],
        ),
      ),
    );
  }
}