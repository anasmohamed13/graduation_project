import 'package:flutter/material.dart';
import 'package:garduationproject/ui/screen/sign/hello/hello_page.dart';
import 'package:garduationproject/ui/screen/sign/login/doctor/doctor_login.dart';
import 'package:garduationproject/ui/screen/sign/login/parent/parent_login.dart';
import 'package:garduationproject/ui/screen/sign/login/patient/patient_login.dart';
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
        ParentLogin.routName: (context) => const ParentLogin(),
        DoctorLogin.routName: (context) => const DoctorLogin(),
        PatientLogin.routName: (context) => const PatientLogin(),
      },
    );
  }
}
