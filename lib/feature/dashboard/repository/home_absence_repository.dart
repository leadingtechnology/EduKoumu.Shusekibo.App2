import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kyoumutechou/feature/dashboard/model/home_absence_model.dart';
import 'package:kyoumutechou/feature/dashboard/state/home_absence_state.dart';
import 'package:kyoumutechou/shared/http/api_provider.dart';
import 'package:kyoumutechou/shared/http/api_response.dart';
import 'package:kyoumutechou/shared/http/app_exception.dart';
import 'package:kyoumutechou/shared/util/date_util.dart';

// ignore: one_member_abstracts
abstract class HomeAbsenceRepositoryProtocol {
  Future<HomeAbsenceState> fetch(int dantaiId, DateTime targetDate);
}

final homeAbsenceRepositoryProvider = Provider(HomeAbsenceRepository.new);

class HomeAbsenceRepository implements HomeAbsenceRepositoryProtocol {
  HomeAbsenceRepository(this._ref);

  late final ApiProvider _api = _ref.read(apiProvider);
  final Ref _ref;

  @override
  Future<HomeAbsenceState> fetch(int dantaiId, DateTime targetDate) async {
    final today = DateUtil.getStringDate(targetDate);

    final url = 'api/kenkou/Taisyousya?dantaiId=$dantaiId&date=$today';
    final response = await _api.get(url);

    response.when(
      success: (success) {},
      error: (error) {
        return HomeAbsenceState.error(error);
      },
    );

    if (response is APISuccess) {
      final value = response.value;
      try {
        final list = homeAbsenceListFromJson(value as List<dynamic>)

        ..sort((a, b) {
          // 学年
          final gakunenComparison = compareNullable(a.gakunen, b.gakunen);
          if (gakunenComparison != 0) return gakunenComparison;

          // クラス
          final classNameComparison = compareNullable(a.className, b.className);
          if (classNameComparison != 0) return classNameComparison;

          // 出席番号
          final studentNumberComparison =
              compareNullable(a.studentNumber, b.studentNumber);
          if (studentNumberComparison != 0) return studentNumberComparison;

          // シーケンス番号
          return compareNullable(a.studentSeq, b.studentSeq);
        });


        return HomeAbsenceState.loaded(list);
      } catch (e) {
        return HomeAbsenceState.error(
          AppException.errorWithMessage(e.toString()),
        );
      }
    } else if (response is APIError) {
      return HomeAbsenceState.error(response.exception);
    } else {
      return const HomeAbsenceState.loading();
    }
  }

  int compareNullable(String? a, String? b) {
    // 全部Nullの場合は同じとみなす
    if (a == null && b == null) return 0;
    // aがnullの場合、bがnullでないのでbが大きい
    if (a == null) return 1;
    // bがnullの場合、aがnullでないのでaが大きい
    if (b == null) return -1;
    // どちらもnullでないので比較する
    return a.compareTo(b);
  }
}
