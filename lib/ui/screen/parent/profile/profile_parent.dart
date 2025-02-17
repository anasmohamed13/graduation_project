// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:garduationproject/model/services/firebase_service.dart';
import 'package:garduationproject/model/user_model/user_model.dart';
import 'package:garduationproject/ui/screen/home/hello/hello_page.dart';

import 'package:garduationproject/ui/util/app_assets.dart';
import 'package:garduationproject/ui/util/build_elevated_button.dart';
import 'package:garduationproject/ui/widget/build_text_form_filed.dart';

class ProfileParent extends StatefulWidget {
  static const String routeName = 'profileParent';
  const ProfileParent({super.key});

  @override
  State<ProfileParent> createState() => _ProfileParentState();
}

class _ProfileParentState extends State<ProfileParent> {
  final FirebaseService firebaseService = FirebaseService();
  UserModel? userData;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    final data = await firebaseService.fetchUserData();
    try {
      if (mounted) {
        setState(() {
          userData = data;
          nameController.text = userData?.fullName ?? '';
          phoneController.text = userData?.phoneNumber ?? '';
          emailController.text = userData?.email ?? '';
        });
      }
    } catch (e) {
      debugPrint('Error fetching user data: \$e');
    }
  }
//-------------- to Ganna its not complete and have a Bug---------------//
  // Future<void> saveUserData() async {
  //   try {
  //     await firebaseService.updateUserField("fullName", nameController.text);
  //     await firebaseService.updateUserField(
  //         "phoneNumber", phoneController.text);
  //     await firebaseService.updateUserField("email", emailController.text);

  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(content: Text('Profile updated successfully!')),
  //     );
  //   } catch (e) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Failed to update profile: $e')),
  //     );
  //   }
  // }

  Future<void> signOut() async {
    await firebaseService.signOut();
    Navigator.of(context).pushReplacementNamed(HelloPage.routeName);
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color(0xffe1eeff),
      appBar: buildAppBarrParentProfile(),
      body: Column(
        children: [
          buildCircleAvatar(
              borderRadius: BorderRadius.circular(75),
              radius: 75,
              elevation: 10),
          const SizedBox(
            height: 18,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildElevatedButton(() {}, 'Upload New', const Color(0xff8ebff6),
                  height * 0.065, width * 0.4, 16, Colors.white),
              const SizedBox(
                width: 24,
              ),
              buildElevatedButton(() {
                signOut();
              }, 'Save', const Color(0xff8ebff6), height * 0.065, width * 0.4,
                  16, Colors.white),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: const Color(0xfff3f8ff),
                  ),
                  height: MediaQuery.of(context).size.height * 0.58,
                  child: buildPersonalInformation(),
                ),
                Container(
                  height: 100,
                  color: Colors.transparent,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  buildPersonalInformation() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        const SizedBox(
          height: 12,
        ),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              'Personal Inofrmation',
              style: TextStyle(
                  fontFamily: 'inter',
                  fontSize: 20,
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        BuildTextFormFiled(
          prefixIcon: Image.asset(AppAssets.userEdit),
          fillColor: Colors.white,
          hintText: "Full Name",
          text: "Full Name",
          vlaidatorErorr: null,
          controller: nameController,
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(10),
          height: height * 0.060,
          width: width * 0.78,
          fontsize: 16,
          fontWeight: FontWeight.w600,
          blurRadius: 0,
          offset: const Offset(0, 0),
        ),
        const SizedBox(
          height: 20,
        ),
        BuildTextFormFiled(
            prefixIcon: Image.asset(AppAssets.userEdit),
            fillColor: Colors.white,
            hintText: "Email Address",
            text: "Email address",
            vlaidatorErorr: null,
            controller: emailController,
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(10),
            height: MediaQuery.of(context).size.height * 0.060,
            width: MediaQuery.of(context).size.width * 0.78,
            fontsize: 16,
            fontWeight: FontWeight.w600,
            blurRadius: 0,
            offset: const Offset(0, 0)),
        const SizedBox(
          height: 20,
        ),
        BuildTextFormFiled(
            prefixIcon: Image.asset(AppAssets.userEdit),
            fillColor: Colors.white,
            hintText: "Phone Number",
            text: " phone number",
            vlaidatorErorr: null,
            controller: phoneController,
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(10),
            height: MediaQuery.of(context).size.height * 0.060,
            width: MediaQuery.of(context).size.width * 0.78,
            fontsize: 16,
            fontWeight: FontWeight.w600,
            blurRadius: 0,
            offset: const Offset(0, 0)),
        const SizedBox(
          height: 45,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildElevatedButton(() {}, 'Save', const Color(0xff8ebff6),
                height * 0.065, width * 0.4, 16, Colors.white),
            const SizedBox(
              width: 24,
            ),
            buildElevatedButton(() {
              signOut();
            }, 'Log Out', const Color(0xff8ebff6), height * 0.065, width * 0.4,
                16, Colors.white),
          ],
        ),
      ],
    );
  }

  AppBar buildAppBarrParentProfile() {
    return AppBar(
      leadingWidth: 100,
      backgroundColor: Colors.transparent,
      leading: Padding(
        padding: const EdgeInsets.all(6.0),
        child: CircleAvatar(
          backgroundColor: const Color(0xffeef5ff),
          radius: 20,
          child: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.arrow_back_ios_new_sharp),
            color: const Color(0xff8aa1b5),
          ),
        ),
      ),
      centerTitle: true,
      title: const Text(
        'My Profile',
        style: TextStyle(
            fontFamily: 'inter', fontSize: 28, fontWeight: FontWeight.w600),
      ),
    );
  }
}

Material buildCircleAvatar(
    {required BorderRadiusGeometry? borderRadius,
    required double? radius,
    required double? elevation}) {
  return Material(
    shadowColor: const Color(0xffe1eeff),
    color: const Color(0xffe1eeff),
    borderRadius: borderRadius,
    elevation: elevation ?? 10,
    child: CircleAvatar(
      backgroundColor: Colors.transparent,
      radius: radius,
      child: Image.asset(AppAssets.girlMoji),
    ),
  );
}
