// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';
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
                  UserLabel(image: AppAssets.patient, title: 'chiled'),
                  const SizedBox(width: 10),
                  UserLabel(image: AppAssets.patient, title: 'chiled'),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  UserLabel(image: AppAssets.patient, title: 'chiled'),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
