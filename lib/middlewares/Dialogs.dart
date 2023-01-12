import 'package:flutter/material.dart';

class Dialogs{

  showSpinnerDialog(context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircularProgressIndicator(),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2,
                ),
                const Text("Loading"),
              ],
            ),
          ),
        );
      },
    );
  }


  showWarningDialog(status, context) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text("Alert"),
          content: Text(status),
          actions: <Widget>[
            TextButton(
              onPressed: () { Navigator.of(ctx).pop(); },
              child: Container(
                padding: const EdgeInsets.all(14),
                child: const Text("Okay"),
              ),
            ),
          ],
        )
    );
  }
}