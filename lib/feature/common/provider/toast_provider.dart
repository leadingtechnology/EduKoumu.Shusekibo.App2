import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kyoumutechou/helpers/theme/app_theme.dart';

// トースト表示機能を提供するProvider
final toastProvider = Provider<Function>((ref) {
  return (String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: theme.primaryColor,
      textColor: theme.hoverColor,
      fontSize: 16,
    );
  };
});
