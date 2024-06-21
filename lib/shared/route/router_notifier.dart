import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final routerNotifierProvider = ChangeNotifierProvider<RouterNotifier>((ref) {
  return RouterNotifier(ref);
});

class RouterNotifier extends ChangeNotifier {
  RouterNotifier(this.ref);
  
  final Ref ref;

  String? redirect(BuildContext context, GoRouterState state) {
    final isLoggingIn = state.pathParameters[0] == '/login';

    if (isLoggingIn) {
      return '/';
    }

    return null;
  }

  void refresh() {
    notifyListeners();
  }
}
