import 'package:flutter/material.dart';

class DialogUtil {
  static Future<void> show({
    required BuildContext context,
    required Widget Function(
      BuildContext context,
    )
        builder,
  }) async {
    await showDialog<void>(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return PopScope(
          child: builder(context),
        );
      },
    );
  }
}
