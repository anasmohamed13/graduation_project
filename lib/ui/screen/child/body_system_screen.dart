import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BodySystemsScreen extends StatefulWidget {
  static const String routeName = '/body-system-screen';

  const BodySystemsScreen({super.key});

  @override
  State<BodySystemScreen> createState() => _BodySystemScreenState();
}

class _BodySystemsScreenState extends State<BodySystemsScreen> {
  @override
  void initState() {
    super.initState();
    
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  @override
  void dispose() {
    
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, 
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildSystemButton("Circulatory", Colors.red),
                  const SizedBox(height: 16),
                  _buildSystemButton("respiratory system", Colors.purple),
                  const SizedBox(height: 16),
                  _buildSystemButton("Musculoskeletal system", Colors.orange),
                  const SizedBox(height: 16),
                  _buildSystemButton("Digestive system", Colors.lightBlue),
                  const SizedBox(height: 16),
                  
                  
                ],
              ),

              const SizedBox(width: 16),

              
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.0),
                      child: Text(
                        "Now my friends, we will begin the journey of exploration inside our wonderful body! Our body has many systems, just like a football team, each system has an important role for us to be healthy and live a happy life.",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 24),

                    
                    Expanded(
                      child: Center(
                         child: Transform.rotate(
                          angle: -1.5708,
                           child: SizedBox(
                           width: 500, 
                             height: 290,
                        child: Image.asset(
                          'assets/image/systems.png', 
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    )
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSystemButton(String text, Color color) {
    return GestureDetector(
      onTap: () {
        
      },
      child: Container(
        width: 180,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              // ignore: deprecated_member_use
              color: color.withOpacity(0.4),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
