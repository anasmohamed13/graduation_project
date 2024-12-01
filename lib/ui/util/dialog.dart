import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// display dialog when loading
Future<void> showLoading(BuildContext context) async {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return const CupertinoAlertDialog(
          content: Row(
            children: [
              Text("Loading..."),
              Spacer(),
              CircularProgressIndicator(),
            ],
          ),
        );
      });
}

void hideLoading(BuildContext context) {
  Navigator.pop(context);
}

//explain posButton& negButton
//posButton uses to display the words like 'ok , yes , ets..'
//negbutton used to display the word like 'no'
Future<void> showMessage(BuildContext context,
    {String? title,
    String? body,
    String? posButtonTitle,
    String? negButtonTitle,
    Function? onPosButtonClick,
    Function? onNegButtonClick}) async {
  showDialog(
      context: context,
      builder: (_) {
        return CupertinoAlertDialog(
          title: title != null ? Text(title) : null,
          content: body != null ? Text(body) : null,
          actions: [
            if (posButtonTitle != null)
              TextButton(
                  onPressed: () {
                    onPosButtonClick?.call();
                    Navigator.pop(context);
                  },
                  child: Text(posButtonTitle)),
            if (negButtonTitle != null)
              TextButton(
                  onPressed: () {
                    onNegButtonClick?.call();
                    Navigator.pop(context);
                  },
                  child: Text(negButtonTitle)),
          ],
        );
      });
}
