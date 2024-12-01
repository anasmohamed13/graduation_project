// ignore_for_file: must_be_immutable, avoid_unnecessary_containers, sized_box_for_whitespace

import 'package:flutter/material.dart';

class TextFormFieldSign extends StatelessWidget {
  late String? hintText;

  late String? vlaidatorErorr;

  late TextEditingController? controller;
  BorderSide borderSide;
  BorderRadius borderRadius;
  String? Function(String?)? validator;
  void Function(String)? onChanged;
  TextFormFieldSign(
      {super.key,
      required this.hintText,
      required this.vlaidatorErorr,
      required this.controller,
      required this.borderSide,
      required this.borderRadius,
      this.validator,
      this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width * 0.75,
      child: TextFormField(
          onChanged: onChanged,
          controller: controller,
          decoration: InputDecoration(
              hintText: hintText,
              hintStyle: const TextStyle(fontSize: 18, color: Colors.grey),
              border: OutlineInputBorder(
                borderSide: borderSide,
                borderRadius: borderRadius,
              ),
              filled: true,
              fillColor: const Color(0xfff6f6f6)),
          validator: validator),
    );
  }
}
