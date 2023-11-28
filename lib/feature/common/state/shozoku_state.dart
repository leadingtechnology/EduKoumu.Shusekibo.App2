import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kyoumutechou/feature/common/model/shozoku_model.dart';
import 'package:kyoumutechou/shared/http/app_exception.dart';

part 'shozoku_state.freezed.dart';

@freezed
class ShozokusState with _$ShozokusState {
  const factory ShozokusState.loading() = _Loading;
  const factory ShozokusState.loaded(List<ShozokuModel> shozokus) =
      _Loaded;
  const factory ShozokusState.error(AppException error) = _Error;
}
