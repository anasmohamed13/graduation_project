import 'package:flutter/material.dart';

buildTextFormFiledLogin(
    {Widget? suffixIcon,
    String? hintText,
    BorderRadius? borderRadius,
    TextEditingController? controller,
    String? Function(String?)? validator}) {
  return TextFormField(
    controller: controller,
    validator: validator,
    decoration: InputDecoration(
      hintText: hintText,
      hintStyle: const TextStyle(color: Colors.grey),
      suffixIcon: suffixIcon,
      border: OutlineInputBorder(
        borderRadius: borderRadius ?? BorderRadius.circular(10),
      ),
    ),
  );
}
