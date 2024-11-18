import 'package:flutter/material.dart';
import 'package:garduationproject/ui/util/app_assets.dart';

AppBar buildAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: Colors.transparent,
    leading: Padding(
      padding: const EdgeInsets.all(0),
      child: InkWell(
        onTap: () => Navigator.pop(context),
        child: Image.asset(
          AppAssets.backPatientIcon,
          height: 30,
          width: 30,
        ),
      ),
    ),
  );
}
