import 'package:flutter/material.dart';

buildElevatedButton(void Function()? onPressed, String text, Color color,
    double width, double height, double size, Color textColor) {
  return ElevatedButton(
    onPressed: onPressed,
    style: ElevatedButton.styleFrom(
        backgroundColor: color, fixedSize: Size(height, width)),
    child: Text(
      text,
      style: TextStyle(
          fontFamily: 'inter',
          fontSize: size,
          color: textColor,
          fontWeight: FontWeight.w600),
    ),
  );
}
