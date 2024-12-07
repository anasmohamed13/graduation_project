import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:garduationproject/firebase_options.dart';
import 'package:garduationproject/ui/provider/gender_provider.dart';
import 'package:garduationproject/ui/screen/docotr/profile/profile_doctor.dart';
import 'package:garduationproject/ui/screen/hello/hello_page.dart';
import 'package:garduationproject/ui/screen/parent/home/home_parent.dart';
import 'package:garduationproject/ui/screen/parent/profile/profile_parent.dart';

import 'package:garduationproject/ui/screen/auth/login/doctor/doctor_login.dart';
import 'package:garduationproject/ui/screen/auth/login/parent/parent_login.dart';
import 'package:garduationproject/ui/screen/auth/login/patient/patient_login.dart';
import 'package:garduationproject/ui/screen/auth/signup/signup-doctor/sign_up_doctor.dart';
import 'package:garduationproject/ui/screen/auth/signup/signup-parent/sign_up_parent.dart';
import 'package:garduationproject/ui/screen/auth/signup/signup-patient/sign_up_patient.dart';
import 'package:garduationproject/ui/screen/splash/splash.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
      initialRoute: HomeParent.routeName,
      routes: {
        Splash.routeName: (_) => const Splash(),
        HelloPage.routeName: (_) => const HelloPage(),
        ParentLogin.routName: (_) => const ParentLogin(),
        DoctorLogin.routName: (_) => const DoctorLogin(),
        PatientLogin.routName: (_) => const PatientLogin(),
        SignUpPatient.routeName: (_) => const SignUpPatient(),
        SignUpParent.routeName: (_) => const SignUpParent(),
        SignUpDoctor.routeName: (_) => const SignUpDoctor(),
        ProfileDoctor.routeName: (_) => const ProfileDoctor(),
        ProfileParent.routeName: (_) => const ProfileParent(),
        HomeParent.routeName: (_) => const HomeParent(),
      },
    );
  }
}
