import 'package:flutter/material.dart';
import 'package:garduationproject/ui/util/app_assets.dart';
import 'package:garduationproject/ui/util/build_drop_down.dart';
import 'package:garduationproject/ui/util/build_elevated_button.dart';
import 'package:garduationproject/ui/widget/build_text_form_filed.dart';

class ProfileDoctor extends StatelessWidget {
  static const String routeName = 'profileDoctor';
  const ProfileDoctor({super.key});

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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: CircleAvatar(
              radius: 70,
              child: Image.asset(AppAssets.profileImageDoctor),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildElevatedButton(() {}, 'Upload New', const Color(0xffffc6be),
                  60, 160, 18, Colors.black),
              const SizedBox(width: 30),
              buildElevatedButton(() {}, 'Save ', const Color(0xffffc6be), 60,
                  160, 20, Colors.black),
            ],
          ),
          const SizedBox(height: 15),
          const Divider(
            thickness: 2,
            height: 3,
          ),
          const SizedBox(height: 8),
          const Padding(
            padding: EdgeInsets.all(8),
            child: Text(
              'Job Information',
              style: TextStyle(
                fontSize: 24,
                fontFamily: 'inter',
                fontWeight: FontWeight.w600,
                color: Color(0xffc13f2e),
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: buildDropDown(
                  text: 'Number of days you work',
                  icon: Image.asset(
                    AppAssets.dropDownIcon,
                    scale: 0.9,
                  ),
                  color: Colors.grey.shade100,
                  fontsize: 14,
                  height: 65,
                  width: 300,
                ),
              ),
              Expanded(
                child: buildDropDown(
                  text: 'Session duration',
                  color: Colors.grey.shade100,
                  icon: Image.asset(
                    AppAssets.dropDownIcon,
                    scale: 0.5,
                  ),
                  fontsize: 14,
                  height: 65,
                  width: 170,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: BuildTextFormFiled(
                    hintText: '',
                    text: 'Set your working days',
                    vlaidatorErorr: '',
                    controller: null,
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(20),
                    height: 50,
                    width: 200,
                    fontsize: 14,
                    fontWeight: FontWeight.w800,
                    blurRadius: 0,
                    offset: const Offset(0, 0),
                    suffixIcon: IconButton(
                        onPressed: () {},
                        icon: Image.asset(AppAssets.calendarIcon)),
                  ),
                ),
              ),
              const SizedBox(
                width: 30,
              ),
              Expanded(
                child: BuildTextFormFiled(
                  hintText: '',
                  text: 'Set your session price',
                  vlaidatorErorr: '',
                  controller: null,
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(20),
                  height: 50,
                  width: 165,
                  fontsize: 15,
                  fontWeight: FontWeight.w800,
                  blurRadius: 0,
                  offset: const Offset(0, 0),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 12,
          ),
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
                    fontSize: 15,
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
                  height: 65,
                  width: 80),
              buildDropDown(
                  text: null,
                  color: const Color(0xffffe8e5),
                  icon: Image.asset(
                    AppAssets.dropDownIcon,
                    scale: 0.1,
                  ),
                  fontsize: 0,
                  height: 65,
                  width: 80),
              const Text(
                'To',
                style: TextStyle(
                    fontFamily: 'inter',
                    fontSize: 15,
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
                  height: 65,
                  width: 80),
              buildDropDown(
                  text: null,
                  color: const Color(0xffddeafb),
                  icon: Image.asset(
                    AppAssets.dropDownIcon,
                    scale: 0.1,
                  ),
                  fontsize: 0,
                  height: 65,
                  width: 80),
            ],
          ),
          const Padding(
            padding: EdgeInsets.only(left: 10),
            child: Text(
              'Add Your Bio in profile',
              style:
                  TextStyle(fontFamily: 'inter', fontWeight: FontWeight.bold),
            ),
          ),
          Center(
            child: BuildTextFormFiled(
                maxline: 4,
                hintText: 'Write a CV about yourself, your specialty, etc.',
                text: null,
                vlaidatorErorr: null,
                controller: null,
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(16),
                height: 75,
                width: 350,
                fontsize: 0,
                fontWeight: null,
                blurRadius: 1,
                offset: const Offset(0, 0)),
          ),
          const SizedBox(
            height: 10,
          ),
          Center(
            child: buildElevatedButton(() {}, 'Confirm',
                const Color(0xffec5e4c), 60, 170, 20, Colors.white),
          ),
        ],
      ),
    );
  }
}
