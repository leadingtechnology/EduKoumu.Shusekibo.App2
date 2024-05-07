import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kyoumutechou/feature/boxes.dart';
import 'package:kyoumutechou/feature/common/model/teacher_model.dart';
import 'package:kyoumutechou/feature/common/state/api_state.dart';
import 'package:kyoumutechou/shared/http/api_provider.dart';
import 'package:kyoumutechou/shared/http/api_response.dart';
import 'package:kyoumutechou/shared/http/app_exception.dart';

// ignore: one_member_abstracts
abstract class TeachersRepositoryProtocol {
  Future<ApiState> fetch(String organizationKbn);
}

final teachersRepositoryProvider = Provider(TeachersRepository.new);

class TeachersRepository implements TeachersRepositoryProtocol {
  TeachersRepository(this._ref);

  late final ApiProvider _api = _ref.read(apiProvider);
  final Ref _ref;

  @override
  Future<ApiState> fetch(String dantaiId) async {
    // パラメーターのチェック。空白の場合、終了する。
    if (dantaiId.isEmpty) {
      return const ApiState.loaded();
    }

    final box = Boxes.getTeachers();
    await box.clear();

    final url = 'api/dantai/$dantaiId/teachers';
    final response = await _api.get(url);

    response.when(
      success: (success) {},
      error: (error) {
        return ApiState.error(error);
      },
    );

    if (response is APISuccess) {
      final value = response.value;
      try {
        // 1) get the list
        final teachers = teacherListFromJson(value as List<dynamic>);

        // 2) save to local
        final teacherMap = teachers.asMap();
        await box.putAll(teacherMap);

        return const ApiState.loaded();
      } catch (e) {
        return ApiState.error(AppException.errorWithMessage(e.toString()));
      }
    } else if (response is APIError) {
      return ApiState.error(response.exception);
    } else {
      return const ApiState.loading();
    }
  }
}
