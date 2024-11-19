// ignore_for_file: dead_code, must_be_immutable

import 'package:flutter/material.dart';

class BuildTextFormFiledpatient extends StatelessWidget {
  late String? hintText;
  late String? text;
  late String? vlaidatorErorr;
  late int? maxline;
  late TextEditingController? controller;
  BorderSide borderSide;
  BorderRadius borderRadius;

  BuildTextFormFiledpatient(
      {super.key,
      required this.hintText,
      required this.text,
      required this.vlaidatorErorr,
      this.maxline,
      required this.controller,
      required this.borderSide,
      required this.borderRadius});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text ?? '',
          style: const TextStyle(
              fontSize: 22, fontWeight: FontWeight.bold, fontFamily: 'inter'),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 1),
        Material(
          elevation: 2.5,
          borderRadius: BorderRadius.circular(16),
          child: TextFormField(
            controller: controller,
            maxLines: maxline,
            decoration: InputDecoration(
                hintText: hintText,
                hintStyle: const TextStyle(fontSize: 18, color: Colors.grey),
                border: OutlineInputBorder(
                  borderSide: borderSide,
                  borderRadius: borderRadius,
                ),
                filled: true,
                fillColor: Colors.grey.shade100),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return vlaidatorErorr;
              }
              return null;
            },
          ),
        ),
      ],
    );
  }
}
