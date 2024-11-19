// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:garduationproject/ui/provider/gender_provider.dart';
import 'package:garduationproject/ui/util/app_assets.dart';
import 'package:garduationproject/ui/widget/build_text_form_filed.dart';
import 'package:provider/provider.dart';

class SignUpPatient extends StatefulWidget {
  static const String routeName = 'signupPatient';
  const SignUpPatient({super.key});

  @override
  State<SignUpPatient> createState() => _SignUpPatientState();
}

class _SignUpPatientState extends State<SignUpPatient> {
  late GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final firstNameController = TextEditingController();

  final genderController = TextEditingController();

  final ageController = TextEditingController();

  final emailController = TextEditingController();

  final descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      body: Form(
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
                    padding: const EdgeInsets.all(10),
                    child: InkWell(
                      onTap: () => Navigator.pop(context),
                      child: Image.asset(
                        AppAssets.backPatientIcon,
                        height: 30,
                        width: 30,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  BuildTextFormFiled(
                    hintText: null,
                    text: 'First Name',
                    vlaidatorErorr: 'Enter your first name',
                    controller: firstNameController,
                    borderRadius: BorderRadius.circular(18),
                    borderSide: BorderSide.none,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(child: buildGenderDropDown()),
                      const SizedBox(width: 50),
                      Expanded(
                        child: BuildTextFormFiled(
                          hintText: null,
                          text: 'Age',
                          vlaidatorErorr: 'eneter your age',
                          controller: ageController,
                          borderRadius: BorderRadius.circular(18),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  BuildTextFormFiled(
                    hintText: null,
                    text: 'Parent Email',
                    vlaidatorErorr: 'eneter your parent email',
                    controller: emailController,
                    borderRadius: BorderRadius.circular(18),
                    borderSide: BorderSide.none,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  BuildTextFormFiled(
                    hintText:
                        '1-3 favorite things like... trucks, zoo animals, books, to include throughout.',
                    text: 'physical description',
                    vlaidatorErorr: null,
                    maxline: 4,
                    controller: descriptionController,
                    borderRadius: BorderRadius.circular(18),
                    borderSide: BorderSide.none,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {},
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
      bottomNavigationBar: Image.asset(AppAssets.groupCuteCat),
    );
  }

  Widget buildGenderDropDown() => Consumer<GenderProvider>(
        builder: (context, genderprvider, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'gender',
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'inter',
                    fontSize: 22,
                    fontWeight: FontWeight.w700),
              ),
              Material(
                elevation: 2,
                borderRadius: BorderRadius.circular(16),
                child: DropdownButtonFormField(
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
                  value: genderprvider.localGender,
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
                  onChanged: genderprvider.setGender,
                ),
              ),
            ],
          );
        },
      );
}
