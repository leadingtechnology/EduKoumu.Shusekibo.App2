import 'package:kyoumutechou/feature/common/provider/filter_provider.dart';
import 'package:kyoumutechou/feature/dashboard/repository/home_absence_repository.dart';
import 'package:kyoumutechou/feature/dashboard/state/home_absence_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_absence_provider.g.dart';

@riverpod
class HomeAbsenceNotifier extends _$HomeAbsenceNotifier {
  late final _repository = ref.read(homeAbsenceRepositoryProvider);

  @override
  HomeAbsenceState build() {
    _fetch();
    return const HomeAbsenceState.loading();
  }

  Future<void> _fetch() async {
    final filter = ref.watch(filterProvider);
    final dantaiId = filter.dantaiId ?? 0;
    if (dantaiId == 0) {
      state = const HomeAbsenceState.loaded([]);
      return ;
    }

    final response = await _repository.fetch(dantaiId, DateTime.now());
    state = response;
  }
}
