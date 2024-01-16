import 'dart:async';

import 'package:flutter/material.dart';

class ToastHelper {
  static void showToast(BuildContext context, String text) {
    const style = TextStyle(color: Colors.white, fontSize: 16);

    final Widget widget = Center(
      child: Material(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black54,//.withOpacity(0.5),
            borderRadius: BorderRadius.circular(10),
          ),
          
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Text(text, style: style,),
        ),
      ),
    );
    final entry = OverlayEntry(
      builder: (_) => widget,
    );

    Overlay.of(context).insert(entry);

    Timer(const Duration(seconds: 1), entry.remove);
  }
}
