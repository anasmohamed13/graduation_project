// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:garduationproject/ui/screen/auth/signup/signup-patient/sign_up_patient.dart';
import 'package:garduationproject/ui/util/app_assets.dart';

class PatientLogin extends StatefulWidget {
  static const String routName = 'patient';
  const PatientLogin({super.key});

  @override
  State<PatientLogin> createState() => _PatientLoginState();
}

class _PatientLoginState extends State<PatientLogin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBarPatient(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(AppAssets.cuteCat),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Hello My Friend\n Let’s Do Some\n Tasks..',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const Spacer(
              flex: 8,
            ),
            ElevatedButton(
              style: const ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(
                  Color(0xffe08898),
                ),
              ),
              onPressed: () {
                Navigator.pushNamed(context, SignUpPatient.routeName);
              },
              child: Container(
                height: MediaQuery.of(context).size.height * 0.06,
                width: MediaQuery.of(context).size.width * .7,
                child: const Center(
                  child: Text(
                    'Go',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontFamily: 'inter',
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
            ),
            const Spacer(
              flex: 2,
            ),
          ],
        ),
      ),
    );
  }

  AppBar buildAppBarPatient() {
    return AppBar(
      backgroundColor: Colors.transparent,
      leading: Padding(
        padding: const EdgeInsets.all(0),
        child: InkWell(
          onTap: () => Navigator.pop(context),
          child: Image.asset(
            AppAssets.backPatientIcon,
            height: 30,
            width: 30,
          ),
        ),
      ),
    );
  }
}
