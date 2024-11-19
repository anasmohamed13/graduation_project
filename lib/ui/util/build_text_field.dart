import 'package:flutter/material.dart';

buildTextFiled(Widget? suffixIcon, String hintText, BorderRadius borderRadius) {
  return TextField(
    decoration: InputDecoration(
      hintText: hintText,
      hintStyle: const TextStyle(color: Colors.grey),
      suffixIcon: suffixIcon,
      border: OutlineInputBorder(
        borderRadius: borderRadius,
      ),
    ),
  );
}
