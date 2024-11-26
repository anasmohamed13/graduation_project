import 'package:flutter/material.dart';
import 'package:garduationproject/ui/provider/gender_provider.dart';
import 'package:garduationproject/ui/screen/docotr/profile/profile_doctor.dart';
import 'package:garduationproject/ui/screen/sign/hello/hello_page.dart';
import 'package:garduationproject/ui/screen/sign/login/doctor/doctor_login.dart';
import 'package:garduationproject/ui/screen/sign/login/parent/parent_login.dart';
import 'package:garduationproject/ui/screen/sign/login/patient/patient_login.dart';
import 'package:garduationproject/ui/screen/sign/signup/signup-doctor/sign_up_doctor.dart';
import 'package:garduationproject/ui/screen/sign/signup/signup-parent/sign_up_parent.dart';
import 'package:garduationproject/ui/screen/sign/signup/signup-patient/sign_up_patient.dart';
import 'package:garduationproject/ui/screen/splash/splash.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => GenderProvider(),
      child: const GatoApp(),
    ),
  );
}

class GatoApp extends StatelessWidget {
  const GatoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: ProfileDoctor.routeName,
      routes: {
        Splash.routeName: (context) => const Splash(),
        HelloPage.routeName: (context) => const HelloPage(),
        ParentLogin.routName: (context) => const ParentLogin(),
        DoctorLogin.routName: (context) => const DoctorLogin(),
        PatientLogin.routName: (context) => const PatientLogin(),
        SignUpPatient.routeName: (context) => const SignUpPatient(),
        SignUpParent.routeName: (context) => const SignUpParent(),
        SignUpDoctor.routeName: (context) => const SignUpDoctor(),
        ProfileDoctor.routeName: (context) => const ProfileDoctor(),
      },
    );
  }
}
