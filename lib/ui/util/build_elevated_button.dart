import 'package:flutter/material.dart';

buildElevatedButton(String text, Color color, double width, double height) {
  return ElevatedButton(
    onPressed: () {},
    style: ElevatedButton.styleFrom(
        backgroundColor: color, fixedSize: Size(height, width)),
    child: Text(
      text,
      style: const TextStyle(
          fontFamily: 'inter',
          fontSize: 21,
          color: Colors.white,
          fontWeight: FontWeight.w600),
    ),
  );
}
