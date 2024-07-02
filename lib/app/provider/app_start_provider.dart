import 'package:hive_flutter/hive_flutter.dart';
import 'package:kyoumutechou/app/state/app_start_state.dart';
import 'package:kyoumutechou/feature/auth/provider/auth_provider.dart';
import 'package:kyoumutechou/feature/auth/state/auth_state.dart';
import 'package:kyoumutechou/feature/boxes.dart';
import 'package:kyoumutechou/shared/util/string_util.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_start_provider.g.dart';

@riverpod
class AppStartNotifier extends _$AppStartNotifier {
  //late final AuthRepository rep = ref.read(authRepositoryProvider);

  @override
  FutureOr<AppStartState> build() async {
    ref.onDispose(() {});

    //4-1-2)通常ログイン処理
    final authState = ref.watch(authNotifierProvider);

    //4-4)SAMLログアウトの場合、ログアウトページへ遷移
    final saml = Boxes.getBox().get('saml').toString();
    if (saml.isNotEmpty && saml == 'saml') {
      return const AppStartState.loading ();
    }
    if (saml.isNotEmpty && saml == 'logout') {
      return const AppStartState.logout();
    }

    // 5)ログイン処理
    final dantaiString = Hive.box<String>('shusekibo').get('dantaiList') ?? '';
    final dantaiList = StringUtil.parseStringToKeyValueList(dantaiString);
    if (dantaiList.isNotEmpty && dantaiList.length > 1) {
      return const AppStartState.multipleDantai();
    }

    // 6)ログアウト処理
    final secret = Boxes.getBox().get('secret').toString();
    if (authState is AuthStateLoggedOut &&
        secret.isNotEmpty &&
        secret != 'null') {
      return const AppStartState.logout();
    }

    // 7)エラー画面の処理
    final errorPage = Hive.box<String>('shusekibo').get('ErrorPage') ?? '';
    if (errorPage == '1') {
      await Hive.box<String>('shusekibo').put('ErrorPage', '0');
      return const AppStartState.appErrorPage();
    }

    final token = Hive.box<String>('shusekibo').get('token');

    if (token != null && token.isEmpty == false) {
      return const AppStartState.authenticated();
    } else {
      return const AppStartState.unauthenticated();
    }
  }
}
