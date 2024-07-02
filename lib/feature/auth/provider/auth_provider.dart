import 'package:hive_flutter/hive_flutter.dart';
import 'package:kyoumutechou/feature/attendance/model/attendance_meibo_model.dart';
import 'package:kyoumutechou/feature/attendance/model/attendance_timed_meibo_model.dart';
import 'package:kyoumutechou/feature/auth/repository/auth_repository.dart';
import 'package:kyoumutechou/feature/auth/state/auth_state.dart';
import 'package:kyoumutechou/feature/awareness/model/awareness_kizuki_model.dart';
import 'package:kyoumutechou/feature/awareness/model/awareness_meibo_model.dart';
import 'package:kyoumutechou/feature/common/model/dantai_model.dart';
import 'package:kyoumutechou/feature/common/model/gakunen_model.dart';
import 'package:kyoumutechou/feature/common/model/shozoku_model.dart';
import 'package:kyoumutechou/feature/common/model/tannin_model.dart';
import 'package:kyoumutechou/feature/common/model/timed_model.dart';
import 'package:kyoumutechou/feature/common/model/tokobi_model.dart';
import 'package:kyoumutechou/feature/common/provider/dantais_provider.dart';
import 'package:kyoumutechou/feature/common/provider/filter_provider.dart';
import 'package:kyoumutechou/feature/common/provider/gakunens_provider.dart';
import 'package:kyoumutechou/feature/common/provider/shozokus_provider.dart';
import 'package:kyoumutechou/feature/common/provider/tannin_provider.dart';
import 'package:kyoumutechou/feature/common/provider/timeds_provider.dart';
import 'package:kyoumutechou/feature/common/provider/tokobis_provider.dart';
import 'package:kyoumutechou/feature/health/model/health_meibo_model.dart';
import 'package:kyoumutechou/feature/home/provider/home_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_provider.g.dart';

@riverpod
class AuthNotifier extends _$AuthNotifier {
  @override
  AuthState build() {
    return const AuthState.initial();
  }

  late final AuthRepository _loginRepository = ref.read(authRepositoryProvider);

  Future<AuthState> login(String email, String password) async {
    final response = await _loginRepository.login(email, password);
    if (response is AuthStateLoggedIn) {
      state = response;
    }
    return response;
  }

  Future<void> samlLogin(String secret) async {
    final response = await _loginRepository.samlLogin(secret);
    state = response;

    if (response is AuthStateErrorPage) {
      await logout(isError: true);
    }
  }  

  Future<AuthState> changeDantai() async {
    final response = await _loginRepository.changeDantai();
    if (response is AuthStateLoggedIn) {
      state = response;
    }
    return state;
  }  

  Future<AuthState> setStateToLoading() async {
    return const AuthState.loading();
  }    

  Future<void> logout({bool? isError=false}) async {
    
    // クリアトークン
    await Hive.box<String>('shusekibo').clear();

    // common
    await Hive.box<DantaiModel>('Dantai').clear();
    await Hive.box<GakunenModel>('Gakunen').clear();
    await Hive.box<ShozokuModel>('Shozoku').clear();
    await Hive.box<TokobiModel>('Tokobi').clear();
    await Hive.box<TanninModel>('Tannin').clear();
    await Hive.box<TimedModel>('Timed').clear();

    await Hive.box<HealthMeiboModel>('HealthMeibo').clear();

    // attendance
    await Hive.box<AttendanceMeiboModel>('AttendanceMeibo').clear();
    await Hive.box<AttendanceTimedMeiboModel>('AttendanceTimedMeibo').clear();

    // awareness
    await Hive.box<AwarenessMeiboModel>('AwarenessMeibo').clear();
    await Hive.box<AwarenessKizukiModel>('AwarenessKizuki').clear();

    // クリア団体
    ref..invalidate(dantaisProvider)
    ..invalidate(gakunenProvider)
    ..invalidate(shozokuProvider)
    ..invalidate(timedProvider)
    ..invalidate(filterProvider)
    ..invalidate(menuProvider)
    ..invalidate(tanninProvider)
    ..invalidate(isTokobiProvider)
  	..invalidate(isLockedProvider)
    ..invalidate(isDialogVisibleProvider)
    ;

    // ログアウト
    if (isError != null && isError == true) {
      Hive.box<String>('shusekibo').put('ErrorPage','1');
    }
    state = const AuthState.loggedOut();
  }
}
