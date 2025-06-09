// ignore_for_file: body_might_complete_normally_nullable, use_build_context_synchronously, unused_local_variable, non_constant_identifier_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:garduationproject/model/doctor_model/doctor_model.dart';
import 'package:garduationproject/model/firebase/auth_service.dart';
import 'package:garduationproject/model/firebase/firebase_service.dart';
import 'package:garduationproject/model/parent_model/parent_model.dart';

import 'package:garduationproject/ui/screen/doctor/profile/profile_doctor.dart';
import 'package:garduationproject/ui/screen/parent/home/home_parent.dart';
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
  String MedicalSpecializatin = '';
  String doctorEmail = ''; // New field for parent

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final AuthService authService = AuthService();
  final FirebaseService databaseService = FirebaseService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBarSignUp(context),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 12),
                const Text(
                  'Start now, and share your\n medical expertise with the\n world!',
                  style: TextStyle(
                    fontFamily: 'inter',
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 26),
                TextFormFieldSign(
                  hintText: 'Full name',
                  vlaidatorErorr: '',
                  controller: null,
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(30),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                  onChanged: (text) {
                    fullName = text;
                  },
                ),
                const SizedBox(height: 26),
                TextFormFieldSign(
                  hintText: 'Email',
                  vlaidatorErorr: '',
                  controller: null,
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(30),
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        !value.contains('@')) {
                      return 'Enter a valid email';
                    }
                    return null;
                  },
                  onChanged: (text) {
                    email = text;
                  },
                ),
                const SizedBox(height: 26),
                TextFormFieldSign(
                  hintText: 'Phone number',
                  vlaidatorErorr: '',
                  controller: null,
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(30),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter your phone number';
                    }
                    return null;
                  },
                  onChanged: (text) {
                    phoneNumber = text;
                  },
                ),
                const SizedBox(height: 26),

                // Show this only for Parent users
                if (widget.userType == 'Parent') ...[
                  TextFormFieldSign(
                    hintText: 'Doctor Email',
                    vlaidatorErorr: '',
                    controller: null,
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(30),
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          !value.contains('@')) {
                        return 'Enter a valid doctor email';
                      }
                      return null;
                    },
                    onChanged: (text) {
                      doctorEmail = text;
                    },
                  ),
                  const SizedBox(height: 26),
                ],

                TextFormFieldSign(
                  hintText: 'Password',
                  vlaidatorErorr: '',
                  controller: null,
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(30),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Password is required';
                    }
                    if (!RegExp(r'^\d+$').hasMatch(value)) {
                      return 'Password must contain only numbers';
                    }
                    if (value.length < 4 || value.length > 6) {
                      return 'Password must be 4-6 digits';
                    }
                    return null;
                  },
                  onChanged: (text) {
                    password = text;
                  },
                ),
                const Align(
                  alignment: Alignment(-0.6, 0),
                  child: Text(
                    '• Must be 4-6 digits\n• Numbers only',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 12,
                      fontFamily: 'inter',
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ),
                const SizedBox(height: 26),
                TextFormFieldSign(
                  hintText: 'Confirm password',
                  vlaidatorErorr: '',
                  controller: null,
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(30),
                  validator: (value) {
                    if (value != password) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                  onChanged: (text) {
                    confirmPassword = text;
                  },
                ),
                const SizedBox(height: 60),
                buildElevatedButton(
                  createAccount,
                  'Sign Up',
                  const Color(0xffec5e4c),
                  60,
                  170,
                  20,
                  Colors.white,
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
      Navigator.pushReplacementNamed(context, HomeParent.routeName);
    }
  }

  Future<void> createAccount() async {
    if (!formKey.currentState!.validate()) return;

    try {
      showLoading(context);

      if (widget.userType == 'Parent') {
        bool doctorExists =
            await databaseService.checkDoctorExistsByEmail(doctorEmail);
        if (!doctorExists) {
          hideLoading(context);
          showMessage(
            context,
            title: 'Doctor not found',
            body:
                'No doctor found with this email. Please enter a valid doctor email.',
            posButtonTitle: 'OK',
          );
          return;
        }
      }

      User? user = await authService.signUp(email, password);
      if (user != null) {
        if (widget.userType == 'Doctor') {
          DoctorModel doctor = DoctorModel(
            fullName: fullName,
            email: email,
            phoneNumber: phoneNumber,
            userType: 'Doctor',
            medicalLicenseNumber: medicalLicenseNumber,
            medicalSpecializatin: MedicalSpecializatin,
          );
          await databaseService.saveDoctor(doctor);
        } else if (widget.userType == 'Parent') {
          ParentModel parent = ParentModel(
            fullName: fullName,
            email: email,
            phoneNumber: phoneNumber,
            userType: 'Parent',
            doctorEmail: doctorEmail,
          );
          await databaseService.saveParent(parent);
        }

        hideLoading(context);
        navigateToProfile();
      }
    } on FirebaseAuthException catch (e) {
      hideLoading(context);
      String message = '';
      if (e.code == 'weak-password') {
        message = "The password provided is too weak.";
      } else if (e.code == 'email-already-in-use') {
        message = "The account already exists for that email.";
      }
      if (context.mounted) {
        showMessage(
          context,
          title: 'Error!',
          body: 'Your error is: $message',
          posButtonTitle: 'Ok',
        );
      }
    } catch (e) {
      hideLoading(context);
      showMessage(
        context,
        title: 'Error!',
        body: 'Something went wrong. Please try again later.',
      );
    }
  }
}
