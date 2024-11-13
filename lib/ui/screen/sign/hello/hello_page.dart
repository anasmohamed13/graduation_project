// ignore_for_file: avoid_unnecessary_containers, must_be_immutable

import 'package:flutter/material.dart';
import 'package:garduationproject/ui/screen/sign/hello/select_user.dart';
import 'package:garduationproject/ui/util/app_assets.dart';

class HelloPage extends StatefulWidget {
  static const String routeName = 'helloPage';

  const HelloPage({
    super.key,
  });

  @override
  State<HelloPage> createState() => _HelloPageState();
}

class _HelloPageState extends State<HelloPage> {
  final PageController controller = PageController();
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: controller,
              onPageChanged: (int page) {
                setState(() {
                  currentPage = page;
                });
              },
              children: [
                buildHelloPage(),
                const SelectUser(),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              2,
              (index) {
                return Container(
                  width: 10.0,
                  height: 10.0,
                  margin: const EdgeInsets.symmetric(horizontal: 5.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: currentPage == index ? Colors.black : Colors.grey,
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  buildHelloPage() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 120,
          ),
          Image.asset(AppAssets.gato),
          const SizedBox(
            height: 10,
          ),
          Image.asset(AppAssets.cuteCat),
          const SizedBox(
            height: 40,
          ),
          Container(
            height: 80,
            width: 145,
            decoration: const BoxDecoration(
              color: Color(0xff7ba6b3),
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            child: InkWell(
              onTap: () => controller.nextPage(
                  duration: const Duration(seconds: 1),
                  curve: Curves.easeInOut),
              child: const Center(
                child: Text(
                  'Let`s Start',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 50,
          ),
        ],
      ),
    );
  }
}
