import 'package:flutter/material.dart';

class SnakbarUtils {
  static showMessage({
    required BuildContext context,
    required String message,
  }) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }
}
