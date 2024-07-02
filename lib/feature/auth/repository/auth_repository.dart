import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kyoumutechou/feature/auth/model/staff.dart';
import 'package:kyoumutechou/feature/auth/state/auth_state.dart';
import 'package:kyoumutechou/shared/http/api_provider.dart';
import 'package:kyoumutechou/shared/http/app_exception.dart';
import 'package:kyoumutechou/shared/util/string_util.dart';

abstract class AuthRepositoryProtocol {
  Future<AuthState> login(String email, String password);
  Future<AuthState> samlLogin(String token);
  Future<AuthState> changeDantai();
}

final authRepositoryProvider = Provider(AuthRepository.new);

class AuthRepository implements AuthRepositoryProtocol {
  AuthRepository(this._ref);

  late final ApiProvider _api = _ref.read(apiProvider);
  final Ref _ref;

  @override
  Future<AuthState> login(String email, String password) async {
    /*
    if (!Validator.isValidPassWord(password)) {
      return const AuthState.error(
          AppException.errorWithMessage('Minimum 8 characters required'),);
    }
    if (!Validator.isValidEmail(email)) {
      return const AuthState.error(
          AppException.errorWithMessage('Please enter a valid email address'),);
    }
    */

    var tenantId = '';
    if (dotenv.env['TENANT_ID'] != null) {
      tenantId = dotenv.env['TENANT_ID']!;
    }

    final params =
        'grant_type=password&username=$tenantId,$email&password=$password';

    final response = await _api.post('token', params);

    return response.when(
      success: (value) async {
        final staff = Staff.fromJson(value as Map<String, dynamic>);
        await Hive.box<String>('shusekibo').put('token', staff.access_token);
        await Hive.box<String>('shusekibo').put('user', staff.UserName);
        await Hive.box<String>('shusekibo').put('dantaiId', staff.DantaiId);
        await Hive.box<String>('shusekibo').put('loginId', staff.LoginId);
        await Hive.box<String>('shusekibo').put('kihonId', staff.KihonId);
        await Hive.box<String>('shusekibo').put('userId', staff.UserId);
        await Hive.box<String>('shusekibo').put('dantaiList', staff.DantaiList);

        // ユーザーの所属団体が複数の場合、ログイン画面に遷移、団体選択画面を表示する
        final userDantais =
            StringUtil.parseStringToKeyValueList(staff.DantaiList);
        if (userDantais.isNotEmpty && userDantais.length > 1) {
          return const AuthState.multipleDantai();
        }

        return const AuthState.loggedIn();
      },
      error: (error) {
        return AuthState.error(error);
      },
    );
  }

  @override
  Future<AuthState> samlLogin(String token) async {
    //
    final body = <String, dynamic>{
      'secret': token,
    };

    final response = await _api.post('saml', body);

    return response.when(
      success: (value) async {
        final staff = Staff.fromJson(value as Map<String, dynamic>);
        await Hive.box<String>('shusekibo').put('token', staff.access_token);
        await Hive.box<String>('shusekibo').put('user', staff.UserName);
        await Hive.box<String>('shusekibo').put('dantaiId', staff.DantaiId);
        await Hive.box<String>('shusekibo').put('loginId', staff.LoginId);
        await Hive.box<String>('shusekibo').put('kihonId', staff.KihonId);
        await Hive.box<String>('shusekibo').put('userId', staff.UserId);
        await Hive.box<String>('shusekibo').put('dantaiList', staff.DantaiList);

        // ユーザーの所属団体が複数の場合、ログイン画面に遷移、団体選択画面を表示する
        final userDantais =
            StringUtil.parseStringToKeyValueList(staff.DantaiList);
        if (userDantais.isNotEmpty && userDantais.length > 1) {
          return const AuthState.multipleDantai();
        }

        return const AuthState.loggedIn();
      },
      error: (error) {
        final errorString = error.toString();
        RegExp regExp = RegExp(r"message: (\d+)");
        Match? match = regExp.firstMatch(errorString);

        if (match != null) {
          String message = match.group(1)!;
          if (message == '404') {
            return const AuthState.errorPage();
          }
        }

        return AuthState.error(error);
      },
    );
  }

  @override
  Future<AuthState> changeDantai() async {
    final dantaiId = Hive.box<String>('shusekibo').get('dantaiId');

    final response = await _api.post('api/menu/changeDantai/$dantaiId','');

    return response.when(
      success: (value) async {
        final staff = Staff.fromJson(value as Map<String, dynamic>);
        await Hive.box<String>('shusekibo').put('token', staff.access_token);
        await Hive.box<String>('shusekibo').put('user', staff.UserName);
        await Hive.box<String>('shusekibo').put('dantaiId', staff.DantaiId);
        await Hive.box<String>('shusekibo').put('loginId', staff.LoginId);
        await Hive.box<String>('shusekibo').put('kihonId', staff.KihonId);
        await Hive.box<String>('shusekibo').put('userId', staff.UserId);
        await Hive.box<String>('shusekibo').put('dantaiList', '');

        return const AuthState.loggedIn();
      },
      error: (error) {
        return AuthState.error(error);
      },
    );
  }
}
