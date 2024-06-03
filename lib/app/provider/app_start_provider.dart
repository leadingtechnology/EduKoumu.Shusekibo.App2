import 'package:hive_flutter/hive_flutter.dart';
import 'package:kyoumutechou/app/state/app_start_state.dart';
import 'package:kyoumutechou/feature/auth/provider/auth_provider.dart';
import 'package:kyoumutechou/feature/auth/provider/saml_service_provider.dart';
import 'package:kyoumutechou/feature/auth/repository/auth_repository.dart';
import 'package:kyoumutechou/feature/auth/state/auth_state.dart';
import 'package:kyoumutechou/feature/boxes.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_start_provider.g.dart';

@riverpod
class AppStartNotifier extends _$AppStartNotifier {

  late final AuthRepository rep = ref.read(authRepositoryProvider);

  @override
  FutureOr<AppStartState> build() async {
    ref.onDispose(() {});

    final saml = Boxes.getBox().get('saml').toString();
    if (saml.isNotEmpty && saml == 'azure') {
      await ref.read(samlServiceProvider).azureLogin();
      await Boxes.getBox().put('saml', '');
    }     

    final authState = ref.watch(authNotifierProvider);

    final secret = Boxes.getBox().get('secret').toString();
    if (secret.isNotEmpty) {
      await rep.samlLogin(secret);
    }

    if (authState is AuthStateLoggedIn) {
      return const AppStartState.authenticated();
    }

    if (authState is AuthStateLoggedOut) {
      return const AppStartState.unauthenticated();
    }

    final token = Hive.box<String>('shusekibo').get('token');
    if (token != null && token.isEmpty == false) {
      return const AppStartState.authenticated();
    } else {
      return const AppStartState.unauthenticated();
    }
  }
}
