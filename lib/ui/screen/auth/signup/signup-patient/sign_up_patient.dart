// ignore_for_file: must_be_immutable, unused_import, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:garduationproject/model/child_model/child_model.dart';
import 'package:garduationproject/ui/screen/child/hello/intro_child.dart';
import 'package:garduationproject/ui/util/app_assets.dart';
import 'package:garduationproject/ui/util/dialog.dart';
import 'package:garduationproject/ui/widget/build_text_form_filed.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpPatient extends StatefulWidget {
  static const String routeName = 'signupPatient';
  const SignUpPatient({super.key});

  @override
  State<SignUpPatient> createState() => _SignUpPatientState();
}

class _SignUpPatientState extends State<SignUpPatient> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final firstNameController = TextEditingController();
  final ageController = TextEditingController();
  final emailController = TextEditingController();
  final descriptionController = TextEditingController();

  String? selectedGender;

  @override
  void initState() {
    super.initState();
    checkSavedLogin();
  }

  Future<void> checkSavedLogin() async {
    final prefs = await SharedPreferences.getInstance();
    final parentId = prefs.getString('parentId');
    final childName = prefs.getString('childName');

    if (parentId != null && childName != null) {
      final childDoc = await FirebaseFirestore.instance
          .collection('Parent')
          .doc(parentId)
          .collection('Children')
          .doc(childName)
          .get();

      if (childDoc.exists) {
        Navigator.pushReplacementNamed(context, IntroChild.routeName);
      } else {
        await prefs.remove('parentId');
        await prefs.remove('childName');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: const Color(0xffffffff),
        body: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Stack(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: InkWell(
                          onTap: () => Navigator.pop(context),
                          child: Image.asset(
                            AppAssets.backPatientIcon,
                            height: 30,
                            width: 30,
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      BuildTextFormFiled(
                        fontWeight: FontWeight.w700,
                        height: 52,
                        width: double.infinity,
                        fontsize: 16,
                        hintText: null,
                        text: 'First Name',
                        vlaidatorErorr: 'Enter your first name',
                        controller: firstNameController,
                        borderRadius: BorderRadius.circular(14),
                        borderSide: BorderSide.none,
                        blurRadius: 1,
                        offset: const Offset(0, 4),
                      ),
                      const SizedBox(height: 25),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(child: buildDropDown()),
                          const SizedBox(width: 50),
                          Expanded(
                            child: BuildTextFormFiled(
                              fontWeight: FontWeight.w700,
                              height: 50,
                              width: MediaQuery.of(context).size.width * 0.35,
                              fontsize: 16,
                              hintText: null,
                              text: 'Age',
                              vlaidatorErorr: 'Enter your age',
                              controller: ageController,
                              borderRadius: BorderRadius.circular(14),
                              borderSide: BorderSide.none,
                              blurRadius: 1,
                              offset: const Offset(0, 4),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: BuildTextFormFiled(
                          fontWeight: FontWeight.w700,
                          height: 50,
                          width: double.infinity,
                          fontsize: 16,
                          hintText: null,
                          text: 'Parent Email',
                          vlaidatorErorr: 'eneter your parent email',
                          controller: emailController,
                          borderRadius: BorderRadius.circular(14),
                          borderSide: BorderSide.none,
                          blurRadius: 1,
                          offset: const Offset(0, 4),
                        ),
                      ),
                      const SizedBox(height: 15),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: BuildTextFormFiled(
                          height: MediaQuery.of(context).size.height * 0.15,
                          width: MediaQuery.of(context).size.width * 0.85,
                          fontsize: 16,
                          hintText:
                              '1-3 favorite things like... trucks, zoo animals, books, to include throughout.',
                          text: 'Physical Description',
                          vlaidatorErorr: null,
                          maxline: 4,
                          controller: descriptionController,
                          borderRadius: BorderRadius.circular(18),
                          borderSide: BorderSide.none,
                          fontWeight: FontWeight.w700,
                          blurRadius: 0,
                          offset: const Offset(4, 4),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Center(
                        child: ElevatedButton(
                          onPressed: saveChildData,
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: const Color(0xffe08898),
                            padding: const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            'Done',
                            style: TextStyle(
                              fontSize: 17,
                              fontFamily: 'inter',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: Image.asset(AppAssets.groupCuteCat),
      ),
    );
  }

  Widget buildDropDown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(7.0),
          child: Text(
            'Gender',
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'inter',
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Material(
          elevation: 2,
          borderRadius: BorderRadius.circular(16),
          child: DropdownButtonFormField<String>(
            value: selectedGender,
            dropdownColor: Colors.grey.shade100,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(8),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(18),
              ),
              filled: true,
              fillColor: Colors.grey.shade100,
            ),
            isExpanded: true,
            items: const [
              DropdownMenuItem(
                value: 'male',
                child: Text('Male'),
              ),
              DropdownMenuItem(
                value: 'female',
                child: Text('Female'),
              ),
            ],
            onChanged: (String? value) {
              setState(() {
                selectedGender = value;
              });
            },
          ),
        ),
      ],
    );
  }

  Future<void> saveChildData() async {
    if (!formKey.currentState!.validate()) return;

    final parentEmail = emailController.text.trim();
    if (parentEmail.isEmpty) {
      showMessage(context, body: 'Parent email is required.');
      return;
    }

    try {
      final parentQuery = await FirebaseFirestore.instance
          .collection('Parent')
          .where('email', isEqualTo: parentEmail)
          .limit(1)
          .get();

      if (parentQuery.docs.isEmpty) {
        showMessage(context,
            body: 'Parent email not found. Please check the email address.');
        return;
      }

      final parentId = parentQuery.docs.first.id;

      final child = ChildModel(
        firstName: firstNameController.text.trim(),
        gender: selectedGender ?? '',
        age: int.tryParse(ageController.text.trim()) ?? 0,
        parentEmail: parentEmail,
        description: descriptionController.text.trim(),
      );

      await FirebaseFirestore.instance
          .collection('Parent')
          .doc(parentId)
          .collection('Children')
          .doc(child.firstName)
          .set(child.toJson());

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('parentId', parentId);
      await prefs.setString('childName', child.firstName);

      showMessage(context, body: 'Child added successfully');
      Navigator.pushReplacementNamed(context, IntroChild.routeName);
    } catch (e) {
      showMessage(context, body: 'Error: $e');
    }
  }
}
