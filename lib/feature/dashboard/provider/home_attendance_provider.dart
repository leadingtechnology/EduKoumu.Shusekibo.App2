import 'package:kyoumutechou/feature/common/provider/dantais_provider.dart';
import 'package:kyoumutechou/feature/dashboard/provider/home_health_provider.dart';
import 'package:kyoumutechou/feature/dashboard/repository/home_attendance_repository.dart';
import 'package:kyoumutechou/feature/dashboard/state/home_attendance_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_attendance_provider.g.dart';

@riverpod
class HomeAttendanceNotifier extends _$HomeAttendanceNotifier {
  late final HomeAttendanceRepository _repository =
      ref.read(homeAttendanceRepositoryProvider);

  @override
  HomeAttendanceState build() {
    _fetch();
    return const HomeAttendanceState.loading();
  }

  Future<void> _fetch() async {
    final dantaiId = ref.watch(dantaiProvider).id ?? 0;
    if (dantaiId == 0) {
      return;
    }
    final targetDate = ref.watch(homeTargetDateProvider);

    final response = await _repository.fetch(dantaiId, targetDate);
    state = response;
  }
}
