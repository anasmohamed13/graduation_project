// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:garduationproject/model/doctor_model/doctor_model.dart';
import 'package:garduationproject/ui/util/app_assets.dart';
import 'package:garduationproject/ui/util/build_drop_down.dart';
import 'package:garduationproject/ui/util/build_elevated_button.dart';
import 'package:garduationproject/ui/widget/build_text_form_filed.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

class ProfileDoctor extends StatefulWidget {
  static const String routeName = 'profileDoctor';
  const ProfileDoctor({super.key});

  @override
  State<ProfileDoctor> createState() => _ProfileDoctorState();
}

class _ProfileDoctorState extends State<ProfileDoctor> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;
  final ImagePicker _picker = ImagePicker();
  File? selectedImage;
  bool isImageSelected = false;

  // Controllers
  final TextEditingController workingDaysController = TextEditingController();
  final TextEditingController bioController = TextEditingController();

  // Selected values
  int? selectedWorkingDays;
  String? selectedFromHour;
  String? selectedFromMinute;
  String? selectedToHour;
  String? selectedToMinute;

  @override
  void initState() {
    super.initState();
    loadSavedImage();
  }

  Future<void> loadSavedImage() async {
    final prefs = await SharedPreferences.getInstance();
    final imagePath = prefs.getString('doctor_profile_image');
    if (imagePath != null) {
      setState(() {
        selectedImage = File(imagePath);
        isImageSelected = true;
      });
    }
  }

// method to pick image and save the image path in sharedPreferences
  Future<void> pickImage() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        setState(() {
          selectedImage = File(image.path);
          isImageSelected = true;
        });

        // Save image path to SharedPreferences(comment to ganna)
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('doctor_profile_image', image.path);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error picking image: $e')),
      );
    }
  }

  Future<void> saveProfile() async {
    try {
      final user = auth.currentUser;
      if (user == null) return;

      // Get existing doctor data
      final userDoc = await firestore
          .collection(DoctorModel.collectionName)
          .doc(user.email)
          .get();
      if (!userDoc.exists) return;

      final existingData = userDoc.data() as Map<String, dynamic>;
      final doctorModel = DoctorModel.fromJson(existingData);

      // Create updated doctor model with new profile data
      final updatedDoctor = DoctorModel(
        fullName: doctorModel.fullName,
        email: doctorModel.email,
        phoneNumber: doctorModel.phoneNumber,
        userType: doctorModel.userType,
        medicalLicenseNumber: doctorModel.medicalLicenseNumber,
        medicalSpecializatin: doctorModel.medicalSpecializatin,
        workingDays: doctorModel.workingDays,
        workingDaysList: workingDaysController.text.split(','),
        workingHoursFrom: '$selectedFromHour:$selectedFromMinute',
        workingHoursTo: '$selectedToHour:$selectedToMinute',
        bio: bioController.text,
      );

      // Update the document
      await firestore
          .collection(DoctorModel.collectionName)
          .doc(user.email)
          .update(updatedDoctor.toJson());

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile saved successfully!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error saving profile: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Information',
          style: TextStyle(
            fontSize: 30,
            fontFamily: 'inter',
            fontWeight: FontWeight.w600,
            color: Color(0xffc13f2e),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: CircleAvatar(
                radius: 70,
                backgroundImage: isImageSelected && selectedImage != null
                    ? FileImage(selectedImage!)
                    : null,
                child: !isImageSelected
                    ? Image.asset(AppAssets.profileImageDoctor)
                    : null,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildElevatedButton(
                  () => pickImage(),
                  'Upload New',
                  const Color(0xffffc6be),
                  60,
                  160,
                  18,
                  Colors.black,
                ),
                const SizedBox(width: 30),
                buildElevatedButton(
                  () => saveProfile(),
                  'Save',
                  const Color(0xffffc6be),
                  60,
                  160,
                  20,
                  Colors.black,
                ),
              ],
            ),
            const SizedBox(height: 15),
            const Divider(thickness: 2, height: 3),
            const SizedBox(height: 8),
            const Row(
              children: [
                SizedBox(
                  width: 16,
                ),
                Text(
                  'Job Information',
                  style: TextStyle(
                    fontSize: 24,
                    fontFamily: 'inter',
                    fontWeight: FontWeight.w600,
                    color: Color(0xffc13f2e),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              children: [
                const SizedBox(
                  width: 5,
                ),
                buildDropDown(
                  text: 'Number of days you work',
                  icon: Image.asset(
                    AppAssets.dropDownIcon,
                    scale: 0.9,
                  ),
                  color: Colors.grey.shade100,
                  fontsize: 12,
                  height: 60,
                  width: 180,
                  onChanged: (value) {
                    setState(() {
                      selectedWorkingDays = int.tryParse(value.toString());
                    });
                  },
                ),
                /*
                will add here a medicalLicenseNumber 
                */
              ],
            ),
            Row(
              children: [
                const SizedBox(
                  width: 6,
                ),
                BuildTextFormFiled(
                  hintText: '',
                  text: 'Set your working days',
                  vlaidatorErorr: '',
                  controller: workingDaysController,
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(20),
                  height: 40,
                  width: 180,
                  fontsize: 14,
                  fontWeight: FontWeight.w800,
                  blurRadius: 0,
                  offset: const Offset(0, 0),
                  suffixIcon: IconButton(
                      onPressed: () {},
                      icon: Image.asset(AppAssets.calendarIcon)),
                ),
                /*
                will add here a medicalSpecializatin 
                */
              ],
            ),
            const SizedBox(height: 16),
            const Center(
              child: Text(
                'Your working hours',
                style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'inter',
                    fontWeight: FontWeight.w700),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'From',
                  style: TextStyle(
                      fontFamily: 'inter',
                      fontSize: 14,
                      fontWeight: FontWeight.w700),
                ),
                buildDropDown(
                    text: null,
                    color: Colors.grey.shade100,
                    icon: Image.asset(
                      AppAssets.dropDownIcon,
                      scale: 0.1,
                    ),
                    fontsize: 0,
                    height: 62,
                    width: 90,
                    onChanged: (value) {
                      setState(() {
                        selectedFromHour = value.toString();
                      });
                    }),
                buildDropDown(
                    text: null,
                    color: const Color(0xffffe8e5),
                    icon: Image.asset(
                      AppAssets.dropDownIcon,
                      scale: 0.1,
                    ),
                    fontsize: 0,
                    height: 62,
                    width: 90,
                    onChanged: (value) {
                      setState(() {
                        selectedFromMinute = value.toString();
                      });
                    }),
                const Text(
                  'To',
                  style: TextStyle(
                      fontFamily: 'inter',
                      fontSize: 14,
                      fontWeight: FontWeight.w700),
                ),
                buildDropDown(
                    text: null,
                    color: Colors.grey.shade100,
                    icon: Image.asset(
                      AppAssets.dropDownIcon,
                      scale: 0.1,
                    ),
                    fontsize: 0,
                    height: 60,
                    width: 90,
                    onChanged: (value) {
                      setState(() {
                        selectedToHour = value.toString();
                      });
                    }),
                buildDropDown(
                    text: null,
                    color: const Color(0xffddeafb),
                    icon: Image.asset(
                      AppAssets.dropDownIcon,
                      scale: 0.1,
                    ),
                    fontsize: 0,
                    height: 60,
                    width: 85,
                    onChanged: (value) {
                      setState(() {
                        selectedToMinute = value.toString();
                      });
                    }),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            const Text(
              'Add Your Bio in profile',
              style:
                  TextStyle(fontFamily: 'inter', fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 8,
            ),
            BuildTextFormFiled(
                maxline: 4,
                hintText: 'Write a CV about yourself, your specialty, etc.',
                text: null,
                vlaidatorErorr: null,
                controller: bioController,
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(16),
                height: 75,
                width: 350,
                fontsize: 0,
                fontWeight: null,
                blurRadius: 1,
                offset: const Offset(0, 0)),
            const SizedBox(height: 24),
            buildElevatedButton(() => saveProfile(), 'Confirm',
                const Color(0xffec5e4c), 60, 170, 20, Colors.white),
          ],
        ),
      ),
    );
  }
}
