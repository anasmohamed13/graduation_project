import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:garduationproject/firebase_options.dart';
import 'package:garduationproject/ui/provider/gender_provider.dart';
import 'package:garduationproject/ui/screen/docotr/profile/profile_doctor.dart';
import 'package:garduationproject/ui/screen/parent/profile/profile_parent.dart';
import 'package:garduationproject/ui/screen/sign/hello/hello_page.dart';
import 'package:garduationproject/ui/screen/sign/auth/login/doctor/doctor_login.dart';
import 'package:garduationproject/ui/screen/sign/auth/login/parent/parent_login.dart';
import 'package:garduationproject/ui/screen/sign/auth/login/patient/patient_login.dart';
import 'package:garduationproject/ui/screen/sign/auth/signup/signup-doctor/sign_up_doctor.dart';
import 'package:garduationproject/ui/screen/sign/auth/signup/signup-parent/sign_up_parent.dart';
import 'package:garduationproject/ui/screen/sign/auth/signup/signup-patient/sign_up_patient.dart';
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
      initialRoute: Splash.routeName,
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
        ProfileParent.routeName: (context) => const ProfileParent(),
      },
    );
  }
}
