import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kyoumutechou/feature/common/provider/dantais_provider.dart';
import 'package:kyoumutechou/feature/dashboard/repository/home_health_repository.dart';
import 'package:kyoumutechou/feature/dashboard/state/home_health_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_health_provider.g.dart';

final homeTargetDateProvider = StateProvider<DateTime>((ref) => DateTime.now());

@riverpod
class HomeHealthNotifier extends _$HomeHealthNotifier {
  late final HomeHealthRepository _repository =
      ref.read(homeHealthRepositoryProvider);

  @override
  HomeHealthState build() {
    _fetch();
    return const HomeHealthState.loading();
  }

  Future<void> _fetch() async {
    final dantaiId = ref.watch(dantaiProvider).id??0;
    if (dantaiId == 0) {
      return;
    }
    //final targetDate = ref.watch(homeTargetDateProvider);
    final targetDate = DateTime.now();

    final response = await _repository.fetch(dantaiId, targetDate);
    state = response;
  }
}
