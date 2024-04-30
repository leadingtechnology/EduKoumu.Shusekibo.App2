import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kyoumutechou/feature/common/model/teacher_model.dart';
import 'package:kyoumutechou/shared/http/app_exception.dart';

part 'teacher_state.freezed.dart';

@freezed
class TeacherState with _$TeacherState {
  const factory TeacherState.loading() = _Loading;
  const factory TeacherState.loaded(List<TeacherModel> teachers) = _Loaded;
  const factory TeacherState.error(AppException error) = _Error;
}
