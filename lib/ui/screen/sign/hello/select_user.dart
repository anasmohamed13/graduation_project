// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:garduationproject/ui/screen/sign/login/doctor/doctor_login.dart';
import 'package:garduationproject/ui/screen/sign/login/parent/parent_login.dart';
import 'package:garduationproject/ui/screen/sign/login/patient/patient_login.dart';
import 'package:garduationproject/ui/util/app_assets.dart';
import 'package:garduationproject/ui/widget/user_label.dart';

class SelectUser extends StatelessWidget {
  const SelectUser({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(AppAssets.user),
          const SizedBox(
            height: 14,
          ),
          Image.asset(
            AppAssets.mitaoCat,
            scale: 2,
          ),
          const SizedBox(
            height: 20,
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () =>
                        Navigator.pushNamed(context, PatientLogin.routName),
                    child: UserLabel(image: AppAssets.patient, title: 'child'),
                  ),
                  const SizedBox(width: 10),
                  InkWell(
                    onTap: () =>
                        Navigator.pushNamed(context, ParentLogin.routName),
                    child: UserLabel(image: AppAssets.parent, title: 'parent'),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () =>
                        Navigator.pushNamed(context, DoctorLogin.routName),
                    child: UserLabel(image: AppAssets.doctor, title: 'Doctor'),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
