// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:garduationproject/ui/util/app_assets.dart';
import 'package:garduationproject/ui/util/build_app_bar.dart';
import 'package:garduationproject/ui/widget/build_text_form_filed.dart';

class SignUpPatient extends StatelessWidget {
  static const String routeName = 'signupPatient';
  SignUpPatient({super.key});
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
      appBar: buildAppBar(context),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BuildTextFormFiled(
                    hintText: null,
                    text: 'First Name',
                    vlaidatorErorr: 'Enter your first name',
                    controller: firstNameController,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: BuildTextFormFiled(
                          hintText: null,
                          text: 'Gender',
                          vlaidatorErorr: 'please enter your gender',
                          controller: genderController,
                        ),
                      ),
                      const SizedBox(width: 50),
                      Expanded(
                        child: BuildTextFormFiled(
                          hintText: null,
                          text: 'Age',
                          vlaidatorErorr: 'eneter your age',
                          controller: ageController,
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
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  BuildTextFormFiled(
                    hintText:
                        '1-3 favorite things like... trucks, zoo animals, books, to include throughout.',
                    text: 'physical description',
                    vlaidatorErorr: null,
                    maxline: 4,
                    controller: descriptionController,
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
}
