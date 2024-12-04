import 'package:flutter/material.dart';
import 'package:garduationproject/ui/util/build_app_bar.dart';

class HomeParent extends StatelessWidget {
  static const String routeName = 'parentHome';
  const HomeParent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
    );
  }
}
