import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:garduationproject/firebase_options.dart';
import 'package:garduationproject/ui/screen/chat/ai_chat/ai_chat.dart';
import 'package:garduationproject/ui/screen/chat/chat_page.dart';
import 'package:garduationproject/ui/screen/child/planet/science_planet/biology_zone/cirulatory_system/circulatory_system_screen.dart';
import 'package:garduationproject/ui/screen/child/planet/science_planet/biology_zone/digestive_system/digestive_system_screen.dart';
import 'package:garduationproject/ui/screen/child/planet/science_planet/biology_zone/nervous_system/nervous_system_screen.dart';
import 'package:garduationproject/ui/screen/child/planet/science_planet/biology_zone/respiratory_system/respiratory_system_screen.dart';
import 'package:garduationproject/ui/screen/child/planet/science_planet/biology_zone/intro_biology/biology_intro.dart';
import 'package:garduationproject/ui/screen/child/planet/science_planet/biology_zone/body_system_screen.dart';
import 'package:garduationproject/ui/screen/child/planet/science_planet/biology_zone/intro_biology/intro_biology.dart';
import 'package:garduationproject/ui/screen/child/hello/intro_child.dart';
import 'package:garduationproject/ui/screen/child/planet/science_planet/planet_Zone/planet_detail.dart';
import 'package:garduationproject/ui/screen/child/planet/science_planet/planet_Zone/planet_zone.dart';
import 'package:garduationproject/ui/screen/child/traditional_stories/traditional_stories_intro/traditional_stories_intro.dart';
import 'package:garduationproject/ui/screen/child/traditional_stories/traditional_stories_page/traditional_stories_page.dart';
import 'package:garduationproject/ui/screen/child/traditional_stories/traditional_stories_page/video/youtube_video_player_screen.dart';
import 'package:garduationproject/ui/screen/doctor/profile/profile_doctor.dart';
import 'package:garduationproject/ui/screen/child/home/home_child.dart';
import 'package:garduationproject/ui/screen/child/planet/learn_palent.dart';
import 'package:garduationproject/ui/screen/child/planet/science_planet/science_planet.dart';
import 'package:garduationproject/ui/screen/home/hello/hello_page.dart';
import 'package:garduationproject/ui/screen/home/splash/child_splash.dart';
import 'package:garduationproject/ui/screen/parent/child_progress/child_progress.dart';
import 'package:garduationproject/ui/screen/parent/gato_timer/gato_timer.dart';
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
        GatoTimer.routeName: (_) => const GatoTimer(),
        HomeChild.routeName: (_) => const HomeChild(),
        ChildProgressScreen.routeName: (_) => const ChildProgressScreen(),
        LearnPlanet.routeName: (_) => const LearnPlanet(),
        SciencePlanet.routeName: (_) => const SciencePlanet(),
        PlanetZone.routeName: (_) => const PlanetZone(),
        PlanetDetail.routeName: (_) => const PlanetDetail(),
        ChildSplash.routeName: (_) => const ChildSplash(),
        IntroChild.routeName: (_) => const IntroChild(),
        IntroBiology.routeName: (_) => const IntroBiology(),
        BiologyIntro.routeName: (_) => const BiologyIntro(),
        TraditionalStoriesPage.routeName: (_) => const TraditionalStoriesPage(),
        TraditionalStoriesIntro.routeName: (_) =>
            const TraditionalStoriesIntro(),
        BodySystemScreen.routeName: (_) => const BodySystemScreen(),
        CirculatorySystemScreen.routeName: (_) =>
            const CirculatorySystemScreen(),
        RespiratorySystemScreen.routeName: (_) =>
            const RespiratorySystemScreen(),
        NervousSystemScreen.routeName: (_) => const NervousSystemScreen(),
        DigestiveSystemScreen.routeName: (_) => const DigestiveSystemScreen(),
        YoutubeVideoPlayerScreen.routeName: (_) =>
            const YoutubeVideoPlayerScreen(),
      },
    );
  }
}
