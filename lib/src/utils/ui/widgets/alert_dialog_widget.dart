import 'package:flutter/material.dart';

Future<bool> showDialogWidget({
  required BuildContext context,
  required String title,
  required String content,
}) {
  return showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: Text('Si'),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text('No'),
        )
      ],
    ),
  ).then((value) => value ?? false);
}
