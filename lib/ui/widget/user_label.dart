// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class UserLabel extends StatelessWidget {
  late String image;
  String title;
  UserLabel({super.key, required this.image, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xff87a9af),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        children: [
          Stack(
            children: [
              Container(
                padding: const EdgeInsets.only(right: 100),
                child: Image.asset(
                  image,
                  scale: 17,
                ),
              ),
            ],
          ),
          const SizedBox(width: 16),
          Center(
            child: Container(
              padding: const EdgeInsets.only(left: 75, top: 20),
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
