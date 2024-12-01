// ignore_for_file: sized_box_for_whitespace, library_private_types_in_public_api, use_build_context_synchronously, unused_local_variable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:garduationproject/ui/screen/docotr/profile/profile_doctor.dart';
import 'package:garduationproject/ui/screen/parent/profile/profile_parent.dart';
import 'package:garduationproject/ui/screen/sign/auth/signup/signup-doctor/sign_up_doctor.dart';
import 'package:garduationproject/ui/screen/sign/auth/signup/signup-parent/sign_up_parent.dart';
import 'package:garduationproject/ui/util/app_assets.dart';
import 'package:garduationproject/ui/util/build_elevated_button.dart';
import 'package:garduationproject/ui/util/build_text_form_field_login.dart';
import 'package:garduationproject/ui/util/dialog.dart';
import 'package:garduationproject/ui/widget/choosing_login.dart';

class LoginPage extends StatefulWidget {
  final String user;
  final Color color;

  const LoginPage({super.key, required this.user, required this.color});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isLogin = true;
  void toggleLoginSignUp(bool isLoginSelected) {
    setState(() {
      isLogin = isLoginSelected;
    });
  }

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    Color buttonColor = widget.user == 'Doctor'
        ? const Color(0xff37908a)
        : const Color(0xff5c7ad4);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Padding(
          padding: const EdgeInsets.all(0),
          child: InkWell(
            onTap: () => Navigator.pop(context),
            child: Image.asset(
              AppAssets.backIcon,
              height: 30,
              width: 30,
            ),
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundColor: const Color(0xff5977d3),
                  radius: 25,
                  child: Image.asset(
                    color: Colors.white,
                    widget.user == 'Doctor'
                        ? AppAssets.doctorIcon
                        : AppAssets.userTickIcon,
                    width: 16,
                    height: 16,
                  ),
                ),
                const Text(
                  'Login or \nSign Up as a',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  widget.user,
                  style: TextStyle(
                    color: widget.color,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                const Text(
                  'Together to provide a safe and loving environment\nfor growth and support.\nSign in as part of your child\'s support team',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                buildTextFormFiledLogin(
                  controller: emailController,
                  borderRadius: BorderRadius.circular(10),
                  hintText: 'eneter your email please',
                  suffixIcon: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Image.asset(
                      AppAssets.cancelIcon,
                      width: 18,
                      height: 18,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an email';
                    } else if (!RegExp(r"^[a-zA-Z0-9]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(value)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                  onChanged: (text) {
                    email = text;
                  },
                ),
                const SizedBox(height: 10),
                buildTextFormFiledLogin(
                  controller: passwordController,
                  borderRadius: BorderRadius.circular(10),
                  hintText: 'eneter password please ',
                  suffixIcon: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Container(
                      width: 70,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Image.asset(
                            AppAssets.eyelIcon,
                            width: 22,
                            height: 22,
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Image.asset(
                            AppAssets.cancelIcon,
                            width: 22,
                            height: 22,
                          ),
                        ],
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a password';
                    } else if (value.length < 6) {
                      return 'Password should be at least 6 characters';
                    }
                    return null;
                  },
                  onChanged: (text) {
                    password = text;
                  },
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Checkbox(
                          hoverColor: const Color(0xffa7a6a6),
                          value: false,
                          onChanged: (value) {},
                        ),
                        const Text(
                          'Save login info',
                          style: TextStyle(
                            color: Color(0xffa7a6a6),
                          ),
                        ),
                      ],
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        'Forget Password?',
                        style: TextStyle(
                          color: Color(0xffa7a6a6),
                        ),
                      ),
                    ),
                  ],
                ),
                TextButton(
                  onPressed: () {
                    if (widget.user == 'Doctor') {
                      Navigator.pushNamed(context, SignUpDoctor.routeName);
                    } else {
                      Navigator.pushNamed(context, SignUpParent.routeName);
                    }
                  },
                  child: const Text(
                    'haven`t account?',
                    style: TextStyle(
                      color: Color(0xffa7a6a6),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      color: const Color(0xffa7a6a6),
                      height: 1,
                      width: 120,
                    ),
                    const Text(
                      'or',
                      style: TextStyle(
                        color: Color(0xffa7a6a6),
                      ),
                    ),
                    Container(
                      color: const Color(0xffa7a6a6),
                      height: 1,
                      width: 120,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const ChoosingLogin(),
                const SizedBox(height: 20),
                buildElevatedButton(
                  () {
                    signIn();
                  },
                  'login',
                  buttonColor,
                  40,
                  350,
                  17,
                  Colors.white,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void navigateToProfile() {
    if (widget.user == 'Doctor') {
      Navigator.pushReplacementNamed(context, ProfileDoctor.routeName);
    } else if (widget.user == 'Parent') {
      Navigator.pushReplacementNamed(context, ProfileParent.routeName);
    }
  }

  Future<void> signIn() async {
    // to check validate aboute email or password before firebase auth--->(read this Gana)
    if (!formKey.currentState!.validate()) return;

    try {
      showLoading(context);
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      // comment to explain this part of code ----> (to Gana)
      // to check the user in app & he not close app we use mounted
      if (context.mounted) {
        hideLoading(context);
        navigateToProfile();
      }
    } on FirebaseAuthException catch (e) {
      hideLoading(context);

      String message = '';
      if (e.code == 'user-not-found') {
        message = "No user found for that email.";
      } else if (e.code == 'wrong-password') {
        message = 'wrong pass';
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
