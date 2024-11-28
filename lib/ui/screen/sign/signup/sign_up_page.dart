// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:garduationproject/ui/screen/docotr/profile/profile_doctor.dart';
import 'package:garduationproject/ui/screen/parent/profile/profile_parent.dart';
import 'package:garduationproject/ui/util/build_elevated_button.dart';
import 'package:garduationproject/ui/widget/text_form_field_sign.dart';

class SignUpPage extends StatefulWidget {
  final String userType;
  const SignUpPage({super.key, required this.userType});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: const Text(
          "Sign Up",
          style: TextStyle(
            color: Color(0xffd37575),
            fontSize: 30,
            fontFamily: 'inter',
            fontWeight: FontWeight.bold,
          ),
        ),
        leadingWidth: 100,
        leading: CircleAvatar(
          radius: 3,
          backgroundColor: const Color(0xffe4e4e4),
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back),
            iconSize: 20,
          ),
        ),
      ),
      body: Center(
        child: Stack(
          children: [
            Column(
              children: [
                const SizedBox(
                  height: 12,
                ),
                const Text(
                  'Start now, and share your\n medical expertise with the\n world!',
                  style: TextStyle(
                    fontFamily: 'inter',
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormFieldSign(
                    hintText: 'Full name',
                    vlaidatorErorr: '',
                    controller: null,
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(30)),
                const SizedBox(
                  height: 20,
                ),
                TextFormFieldSign(
                    hintText: 'Email',
                    vlaidatorErorr: '',
                    controller: null,
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(30)),
                const SizedBox(
                  height: 20,
                ),
                TextFormFieldSign(
                    hintText: 'Phone number',
                    vlaidatorErorr: '',
                    controller: null,
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(30)),
                const SizedBox(
                  height: 16,
                ),
                if (widget.userType == 'Doctor') ...[
                  TextFormFieldSign(
                      hintText: 'Medical Specializatin',
                      vlaidatorErorr: '',
                      controller: null,
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(30)),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormFieldSign(
                      hintText: 'Medical License Number',
                      vlaidatorErorr: '',
                      controller: null,
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(30)),
                ],
                const SizedBox(
                  height: 16,
                ),
                TextFormFieldSign(
                    hintText: 'Password',
                    vlaidatorErorr: '',
                    controller: null,
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(30)),
                const Align(
                  alignment: Alignment(-0.3, 2),
                  child: Text(
                    '• Minimum 8 characters\n• Contains numbers, letters and symbols',
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 12,
                        fontFamily: 'inter',
                        fontWeight: FontWeight.w500),
                    textAlign: TextAlign.start,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormFieldSign(
                    hintText: 'Confirm password',
                    vlaidatorErorr: '',
                    controller: null,
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(30)),
                const SizedBox(
                  height: 10,
                ),
                const Spacer(
                  flex: 7,
                ),
                buildElevatedButton(navigateToProfile, 'Sign Up',
                    const Color(0xffec5e4c), 60, 170, 20, Colors.white),
                const Spacer(
                  flex: 3,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void navigateToProfile() {
    if (widget.userType == 'Doctor') {
      Navigator.pushNamed(context, ProfileDoctor.routeName);
    } else if (widget.userType == 'Parent') {
      Navigator.pushNamed(context, ProfileParent.routeName);
    }
  }
}
