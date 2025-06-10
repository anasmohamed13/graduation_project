// ignore_for_file: use_build_context_synchronously

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:garduationproject/model/doctor_model/doctor_model.dart';
import 'package:garduationproject/model/firebase/firebase_service.dart';

import 'package:garduationproject/ui/util/app_assets.dart';
import 'package:garduationproject/ui/util/build_elevated_button.dart';
import 'package:garduationproject/ui/widget/build_text_form_filed.dart';
import 'package:image_picker/image_picker.dart';

import 'dart:io';
import 'dart:convert';

class ProfileDoctor extends StatefulWidget {
  static const String routeName = 'profileDoctor';
  const ProfileDoctor({super.key});

  @override
  State<ProfileDoctor> createState() => _ProfileDoctorState();
}

class _ProfileDoctorState extends State<ProfileDoctor> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;
  final ImagePicker picker = ImagePicker();
  File? selectedImage;
  bool isImageSelected = false;
  Uint8List? imageBytes;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController specializationController =
      TextEditingController();
  final FirebaseService firebaseService = FirebaseService();

  @override
  void initState() {
    super.initState();
    loadSavedImage();
    fetchDoctorData();
  }

  Future<void> fetchUserData() async {
    final data = await firebaseService.fetchUserData();
    try {
      if (mounted) {
        setState(() {
          final doctor = DoctorModel.fromJson(data);
          nameController.text = doctor.fullName;
          phoneController.text = doctor.phoneNumber;
          emailController.text = doctor.email;
          specializationController.text = doctor.medicalSpecializatin ?? '';
        });
      }
    } catch (e) {
      debugPrint('Error fetching user data: \$e');
    }
  }

  Future<void> loadSavedImage() async {
    final user = auth.currentUser;
    if (user == null) return;

    final doc = await firestore.collection('Doctor').doc(user.email).get();
    if (doc.exists &&
        doc.data() != null &&
        doc.data()!['profileimage'] != null) {
      final base64Image = doc.data()!['profileimage'];
      try {
        final bytes = base64Decode(base64Image);
        setState(() {
          selectedImage = null;
          isImageSelected = true;
        });
        imageBytes = bytes;
      } catch (e) {
        setState(() {
          isImageSelected = false;
        });
      }
    }
  }

  Future<void> fetchDoctorData() async {
    final user = auth.currentUser;
    if (user == null) return;

    final doc = await firestore.collection('Doctor').doc(user.email).get();
    if (doc.exists && doc.data() != null) {
      final data = doc.data()!;
      nameController.text = data['fullName'] ?? '';
      emailController.text = data['email'] ?? '';
      phoneController.text = data['phoneNumber'] ?? '';
      specializationController.text = data['medicalSpecializatin'] ?? '';
    }
  }

  Future<void> pickImage() async {
    try {
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        setState(() {
          selectedImage = File(image.path);
          isImageSelected = true;
        });

        final bytes = await selectedImage!.readAsBytes();
        final base64Image = base64Encode(bytes);

        final user = auth.currentUser;
        if (user != null) {
          await firestore
              .collection('Doctor')
              .doc(user.email)
              .update({'profileimage': base64Image});
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error picking/uploading image: $e')),
      );
    }
  }

  Future<void> saveProfile() async {
    try {
      final user = auth.currentUser;
      if (user == null) return;

      await firestore.collection('Doctor').doc(user.email).update({
        'fullName': nameController.text.trim(),
        'email': emailController.text.trim(),
        'phoneNumber': phoneController.text.trim(),
        'medicalSpecializatin': specializationController.text.trim(),
      });

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
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
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
                backgroundImage: isImageSelected && imageBytes != null
                    ? MemoryImage(imageBytes!)
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
                  'Profile Information',
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
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Column(
                children: [
                  BuildTextFormFiled(
                    prefixIcon: Image.asset(AppAssets.userEdit),
                    fillColor: Colors.white,
                    hintText: "full Name",
                    text: "Full Name",
                    vlaidatorErorr: null,
                    controller: nameController,
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(22),
                    height: height * 0.060,
                    width: width * 0.80,
                    fontsize: 16,
                    fontWeight: FontWeight.w600,
                    blurRadius: 0,
                    offset: const Offset(0, 2),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  BuildTextFormFiled(
                      prefixIcon: Image.asset(AppAssets.userEdit),
                      fillColor: Colors.white,
                      hintText: "Email Address",
                      text: "Email address",
                      vlaidatorErorr: null,
                      controller: emailController,
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(22),
                      height: MediaQuery.of(context).size.height * 0.060,
                      width: MediaQuery.of(context).size.width * 0.80,
                      fontsize: 16,
                      fontWeight: FontWeight.w600,
                      blurRadius: 0,
                      offset: const Offset(0, 2)),
                  const SizedBox(
                    height: 10,
                  ),
                  BuildTextFormFiled(
                      prefixIcon: Image.asset(AppAssets.userEdit),
                      fillColor: Colors.white,
                      hintText: "Phone Number",
                      text: " phone number",
                      vlaidatorErorr: null,
                      controller: phoneController,
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(22),
                      height: MediaQuery.of(context).size.height * 0.060,
                      width: MediaQuery.of(context).size.width * 0.80,
                      fontsize: 16,
                      fontWeight: FontWeight.w600,
                      blurRadius: 0,
                      offset: const Offset(0, 2)),
                  const SizedBox(
                    height: 10,
                  ),
                  BuildTextFormFiled(
                      prefixIcon: Image.asset(AppAssets.userEdit),
                      fillColor: Colors.white,
                      hintText: "Medical Specializatin",
                      text: "Medical Specializatin",
                      vlaidatorErorr: null,
                      controller: specializationController,
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(22),
                      height: MediaQuery.of(context).size.height * 0.060,
                      width: MediaQuery.of(context).size.width * 0.80,
                      fontsize: 16,
                      fontWeight: FontWeight.w600,
                      blurRadius: 0,
                      offset: const Offset(0, 2)),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            buildElevatedButton(() => saveProfile(), 'Confirm',
                const Color(0xffec5e4c), 60, 170, 20, Colors.white),
          ],
        ),
      ),
    );
  }
}
