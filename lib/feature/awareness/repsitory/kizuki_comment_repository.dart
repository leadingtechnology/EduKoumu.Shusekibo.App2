import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kyoumutechou/feature/common/state/api_state.dart';
import 'package:kyoumutechou/shared/http/api_provider.dart';
import 'package:kyoumutechou/shared/http/api_response.dart';
import 'package:kyoumutechou/shared/http/app_exception.dart';

abstract class KizukiCommentRepositoryProtocol {
  
  Future<ApiState> post(String json);
  Future<ApiState> patch(int id, String timestamp);
  Future<ApiState> delete(int id, String timestamp);
}

final kizukiCommentRepositoryProvider = Provider(KizukiCommentRepository.new);

class KizukiCommentRepository implements KizukiCommentRepositoryProtocol {
  KizukiCommentRepository(this.ref);

  late final ApiProvider _api = ref.read(apiProvider);
  final Ref ref;

  @override
  Future<ApiState> post(String json) async{

    final response = await _api.post2('api/kizuki/comment/register', json);

    if (response is APISuccess) {
      final value = response.value;
      try {
        // 1) change response to list
        //final comment = kizukiCommentFromJson(value as String);

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

  @override
  Future<ApiState> patch(int id, String json) async {
    final response = await _api.patch('api/kizukicomments/$id', json);

    if (response is APISuccess) {
      try {
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

  @override
  Future<ApiState> delete(int id, String timestamp) async {
    final encodedTimestamp = Uri.encodeComponent(timestamp);

    final response = await _api.delete(
      'api/kizukicomments/$id?timestamp=$encodedTimestamp',
      '',
    );

    if (response is APISuccess) {
      try {
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
