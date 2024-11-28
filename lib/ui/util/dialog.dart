import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract class DialogUtils {
  static showLoading(BuildContext context) => showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return const CupertinoAlertDialog(
          content: Row(
            children: [
              Text("Loading... "),
              Spacer(),
              CircularProgressIndicator(),
            ],
          ),
        );
      });

  static hideLoading(BuildContext context) => Navigator.pop(context);

  static showError(BuildContext context, String message) => showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Error"),
          content: Text(message),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("OK"))
          ],
        );
      });
}
