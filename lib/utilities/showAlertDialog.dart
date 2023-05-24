import 'package:flutter/material.dart';

Future<void> showAlertDialog(
    BuildContext context, String title, String description) {
  return showDialog<void>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(title),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('OK'),
          ),
        ],
        content: Text(description),
      );
    },
  );
}
