import 'package:hive_flutter/hive_flutter.dart';
import 'package:kyoumutechou/app/state/app_start_state.dart';
import 'package:kyoumutechou/feature/auth/provider/auth_provider.dart';
import 'package:kyoumutechou/feature/auth/state/auth_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_start_provider.g.dart';

@riverpod
class AppStartNotifier extends _$AppStartNotifier {

  @override
  FutureOr<AppStartState> build() async {
    ref.onDispose(() {});

    final authState = ref.watch(authNotifierProvider);

    if (authState is AuthStateLoggedIn) {
      return const AppStartState.authenticated();
    }

    if (authState is AuthStateLoggedOut) {
      return const AppStartState.unauthenticated();
    }

    final token = Hive.box<String>('shusekibo').get('token');
    if (token != null || token != '') {
      return const AppStartState.authenticated();
    } else {
      return const AppStartState.unauthenticated();
    }
  }
}
