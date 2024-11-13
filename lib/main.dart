import 'package:flutter/material.dart';
import 'package:garduationproject/ui/screen/sign/hello/hello_page.dart';
import 'package:garduationproject/ui/screen/splash/splash.dart';

void main() {
  runApp(const GatoApp());
}

class GatoApp extends StatelessWidget {
  const GatoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: Splash.routeName,
      routes: {
        Splash.routeName: (context) => const Splash(),
        HelloPage.routeName: (context) => const HelloPage(),
      },
    );
  }
}
