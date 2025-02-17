// ignore_for_file: avoid_unnecessary_containers, must_be_immutable

import 'package:flutter/material.dart';
import 'package:garduationproject/ui/screen/home/hello/select_user.dart';

import 'package:garduationproject/ui/util/app_assets.dart';

class HelloPage extends StatefulWidget {
  static const String routeName = 'helloPage';
  static int currentPage = 0;
  const HelloPage({
    super.key,
  });

  @override
  State<HelloPage> createState() => _HelloPageState();
}

class _HelloPageState extends State<HelloPage> {
  final PageController controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: controller,
            onPageChanged: (int page) {
              setState(() {
                HelloPage.currentPage = page;
              });
            },
            children: [
              buildHelloPage(),
              const SelectUser(),
            ],
          ),
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                2,
                (index) {
                  return AnimatedContainer(
                    duration: const Duration(microseconds: 300),
                    width: 10,
                    height: 10,
                    margin: const EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: HelloPage.currentPage == index
                          ? Colors.black
                          : Colors.grey,
                      boxShadow: [
                        if (HelloPage.currentPage == index)
                          const BoxShadow(
                            color: Colors.black,
                            // blurRadius: 1,
                            spreadRadius: 1,
                          ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildHelloPage() {
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
          Image.asset(AppAssets.cuteKittyCat),
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
