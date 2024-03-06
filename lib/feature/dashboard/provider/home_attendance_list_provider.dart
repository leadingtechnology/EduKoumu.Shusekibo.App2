import 'package:kyoumutechou/feature/common/provider/dantais_provider.dart';
import 'package:kyoumutechou/feature/common/provider/tokobis_provider.dart';
import 'package:kyoumutechou/feature/dashboard/model/home_attendance_model.dart';
import 'package:kyoumutechou/feature/dashboard/repository/home_attendance_repository.dart';
import 'package:kyoumutechou/feature/dashboard/state/home_attendance_list_state.dart';
import 'package:kyoumutechou/feature/dashboard/state/home_attendance_state.dart';
import 'package:kyoumutechou/shared/http/api_response.dart';
import 'package:kyoumutechou/shared/http/app_exception.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_attendance_list_provider.g.dart';

@riverpod
class HomeAttendanceListNotifier extends _$HomeAttendanceListNotifier {
  late final _rep = ref.read(homeAttendanceRepositoryProvider);


  @override
  HomeAttendanceListState build() {
    _fetch();
    return const HomeAttendanceListState.loading();
  }

  Future<void> _fetch() async {
    final dantaiId = ref.read(dantaiProvider).id ?? 0;
    if (dantaiId == 0) {
      return;
    }

    // 登校日の取得
    final tokobis = ref.read(lastTokobisProvider);
    if (tokobis.isEmpty) {
            final value = [
        <HomeAttendanceModel>[],
        <HomeAttendanceModel>[],
        <HomeAttendanceModel>[],
      ];
      state = HomeAttendanceListState.loaded(value);
      return;
    }

    // 非同期処理で最大３日間の生徒情報を取得する。
    final responses = await Future.wait(
      List.generate(tokobis.length, (index) {
        try {
          return _rep.fetch(dantaiId, tokobis[index]);
        } catch (e) {
          return Future.value(
            APIError<String>(
              AppException.errorWithMessage(e.toString()),
            ),
          );
        }
      }),
    );

    // エラー、ローディングの場合、エラーを表示する。
    var isError = false;
    var isLoading = false;
    var errorMessage = '';
    final maps = <String, List<HomeAttendanceModel>>{};
    for (int i = 0; i < responses.length; i++) {
      final response = responses[i];
      if (response is HomeAttendanceState) {
        response.when(
          error: (e) {
            isError = true;
            errorMessage = '$errorMessage {e};';
          },
          loading: () {
            isLoading = true;
          },
          loaded: (map) {
            maps.addAll(map);
          },
        );
      }
    }

    final attendanceLists = <List<HomeAttendanceModel>>[[], [], []];
    if (maps.isNotEmpty) {
      final sortedKeys = maps.keys.toList()
      ..sort((a, b) => b.compareTo(a));
      
      for (var i = 0; i < sortedKeys.length; i++) {
        final key = sortedKeys[i];
        final index = i % 3;
        attendanceLists[index].addAll(maps[key]!);
      }
    }

    state = HomeAttendanceListState.loaded(attendanceLists);
  }
}
