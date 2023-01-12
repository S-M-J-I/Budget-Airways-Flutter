import 'package:flutter/material.dart';

class Dialogs{
  showWarningDialog(status, context) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text("Error"),
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