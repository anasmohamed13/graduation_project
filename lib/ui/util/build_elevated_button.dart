import 'package:flutter/material.dart';

buildElevatedButton(String text) {
  return ElevatedButton(
    onPressed: () {},
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.blue,
      minimumSize: const Size.fromHeight(50),
    ),
    child: Text(text),
  );
}
