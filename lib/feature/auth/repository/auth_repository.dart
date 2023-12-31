
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kyoumutechou/feature/auth/model/staff.dart';
import 'package:kyoumutechou/feature/auth/state/auth_state.dart';
import 'package:kyoumutechou/shared/http/api_provider.dart';

abstract class AuthRepositoryProtocol {
  Future<AuthState> login(String email, String password);
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

    return response.when(success: (value) async {

      final staff = Staff.fromJson(value as Map<String, dynamic>);
      await Hive.box<String>('shusekibo').put('token', staff.access_token);
      await Hive.box<String>('shusekibo').put('user', staff.UserName);
      await Hive.box<String>('shusekibo').put('dantaiId', staff.DantaiId);
      await Hive.box<String>('shusekibo').put('loginId', staff.LoginId);
      await Hive.box<String>('shusekibo').put('kihonId', staff.KihonId);

      return const AuthState.loggedIn();
    }, error: (error) {
      return AuthState.error(error);
    },);
  }
}
