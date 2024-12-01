// ignore_for_file: body_might_complete_normally_nullable, use_build_context_synchronously, unused_local_variable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:garduationproject/ui/screen/docotr/profile/profile_doctor.dart';
import 'package:garduationproject/ui/screen/parent/profile/profile_parent.dart';
import 'package:garduationproject/ui/util/build_elevated_button.dart';
import 'package:garduationproject/ui/util/dialog.dart';
import 'package:garduationproject/ui/widget/text_form_field_sign.dart';

class SignUpPage extends StatefulWidget {
  final String userType;
  const SignUpPage({super.key, required this.userType});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String fullName = '';
  String email = '';
  String phoneNumber = '';
  String password = '';
  String confirmPassword = '';
  String medicalLicenseNumber = '';
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBarSignUp(context),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Center(
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
                      borderRadius: BorderRadius.circular(30),
                      validator: (p0) {},
                      onChanged: (text) {
                        fullName = text;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormFieldSign(
                      hintText: 'Email',
                      vlaidatorErorr: '',
                      controller: null,
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(30),
                      validator: (value) {},
                      onChanged: (text) {
                        email = text;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormFieldSign(
                      hintText: 'Phone number',
                      vlaidatorErorr: '',
                      controller: null,
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(30),
                      validator: (p0) {},
                      onChanged: (text) {
                        phoneNumber = text;
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    if (widget.userType == 'Doctor') ...[
                      TextFormFieldSign(
                        hintText: 'Medical Specializatin',
                        vlaidatorErorr: '',
                        controller: null,
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(30),
                        validator: (p0) {},
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      TextFormFieldSign(
                        hintText: 'Medical License Number',
                        vlaidatorErorr: '',
                        controller: null,
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(30),
                        validator: (p0) {},
                        onChanged: (text) {
                          medicalLicenseNumber = text;
                        },
                      ),
                    ],
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormFieldSign(
                      hintText: 'Password',
                      vlaidatorErorr: '',
                      controller: null,
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(30),
                      validator: (p0) {},
                      onChanged: (text) {
                        password = text;
                      },
                    ),
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
                      borderRadius: BorderRadius.circular(30),
                      validator: (vlaue) {},
                      onChanged: (text) {
                        confirmPassword = text;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Spacer(
                      flex: 7,
                    ),
                    buildElevatedButton(createAccout, 'Sign Up',
                        const Color(0xffec5e4c), 60, 170, 20, Colors.white),
                    const Spacer(
                      flex: 3,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  AppBar buildAppBarSignUp(BuildContext context) {
    return AppBar(
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
    );
  }

  void navigateToProfile() {
    if (widget.userType == 'Doctor') {
      Navigator.pushReplacementNamed(context, ProfileDoctor.routeName);
    } else if (widget.userType == 'Parent') {
      Navigator.pushReplacementNamed(context, ProfileParent.routeName);
    }
  }

  Future<void> createAccout() async {
    try {
      showLoading(context);
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      // comment to explain this part of code ---->(to Gana)
      // to check the user in app & he not close app we use mounted
      if (context.mounted) {
        hideLoading(context);
      }
      navigateToProfile();
    } on FirebaseAuthException catch (e) {
      hideLoading(context);
      String message = '';
      if (e.code == 'weak-password') {
        message = "The password provided is too weak.";
      } else if (e.code == 'email-already-in-use') {
        message = "The account already exists for that email.";
      }
      if (context.mounted) {
        showMessage(context,
            title: 'Error!',
            body: 'youe error is =$message',
            posButtonTitle: 'Ok');
      }
    } catch (e) {
      hideLoading(context);
      showMessage(context,
          title: 'Error!', body: 'some thing is wrong try later..');
    }
  }
}
