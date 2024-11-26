// ignore_for_file: dead_code, must_be_immutable

import 'package:flutter/material.dart';

class BuildTextFormFiled extends StatelessWidget {
  late String? hintText;
  late String? text;
  late String? vlaidatorErorr;
  late int? maxline;
  late TextEditingController? controller;
  BorderSide? borderSide;
  BorderRadius? borderRadius;
  double? height;
  double? width;
  double? fontsize;
  FontWeight? fontWeight;
  double? blurRadius;
  Offset? offset;
  Widget? suffixIcon;
  Widget? prefixIcon;
  Color? fillColor;
  BuildTextFormFiled({
    super.key,
    required this.hintText,
    required this.text,
    required this.vlaidatorErorr,
    this.maxline,
    required this.controller,
    required this.borderSide,
    required this.borderRadius,
    required this.height,
    required this.width,
    required this.fontsize,
    required this.fontWeight,
    required this.blurRadius,
    required this.offset,
    this.suffixIcon,
    this.prefixIcon,
    this.fillColor,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(6.0),
          child: Text(
            text ?? '',
            style: TextStyle(
                fontSize: fontsize,
                fontWeight: fontWeight,
                fontFamily: 'inter'),
            textAlign: TextAlign.center,
          ),
        ),
        Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            borderRadius: borderRadius ?? BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: blurRadius ?? 1,
                offset: offset ?? const Offset(0, 4),
              ),
            ],
          ),
          child: TextFormField(
            controller: controller,
            maxLines: maxline,
            decoration: InputDecoration(
                prefixIcon: prefixIcon,
                suffixIcon: suffixIcon,
                hintText: hintText,
                hintStyle: const TextStyle(fontSize: 18, color: Colors.grey),
                border: OutlineInputBorder(
                  borderSide: borderSide ?? BorderSide.none,
                  borderRadius: borderRadius ?? BorderRadius.circular(18),
                ),
                filled: true,
                fillColor: fillColor ?? Colors.grey.shade100),
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
