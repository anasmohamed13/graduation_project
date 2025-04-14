import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:garduationproject/firebase_options.dart';
import 'package:garduationproject/ui/screen/chat/ai_chat/ai_chat.dart';
import 'package:garduationproject/ui/screen/chat/chat_page.dart';
import 'package:garduationproject/ui/screen/child/home_child.dart';
import 'package:garduationproject/ui/screen/docotr/profile/profile_doctor.dart';
import 'package:garduationproject/ui/screen/home/hello/hello_page.dart';
import 'package:garduationproject/ui/screen/parent/child_progress/child_progress.dart';
import 'package:garduationproject/ui/screen/parent/home/home_parent.dart';
import 'package:garduationproject/ui/screen/parent/profile/profile_parent.dart';
import 'package:garduationproject/ui/screen/auth/login/doctor/doctor_login.dart';
import 'package:garduationproject/ui/screen/auth/login/parent/parent_login.dart';
import 'package:garduationproject/ui/screen/auth/login/patient/patient_login.dart';
import 'package:garduationproject/ui/screen/auth/signup/signup-doctor/sign_up_doctor.dart';
import 'package:garduationproject/ui/screen/auth/signup/signup-parent/sign_up_parent.dart';
import 'package:garduationproject/ui/screen/auth/signup/signup-patient/sign_up_patient.dart';
import 'package:garduationproject/ui/screen/home/splash/splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const GatoApp(),
  );
}

class GatoApp extends StatelessWidget {
  const GatoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: HomeChild.routeName,
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
        ChatPage.routeName: (_) => const ChatPage(),
        HomeParent.routeName: (_) => const HomeParent(),
        AiChat.routeName: (_) => const AiChat(),
        HomeChild.routeName: (_) => const HomeChild(),
        // ChildProgressScreen.routeName: (_) => const ChildProgressScreen(),
      },
    );
  }
}
