import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kyoumutechou/feature/common/model/timed_model.dart';
import 'package:kyoumutechou/feature/common/repository/timeds_repository.dart';

final timedProvider = StateProvider<TimedModel>((ref) => const TimedModel());

final timedsProvider =
    StateNotifierProvider<TimedsNotifier, List<TimedModel>>((ref) {
  return TimedsNotifier(ref: ref);
});

class TimedsNotifier extends StateNotifier<List<TimedModel>> {
  TimedsNotifier({required this.ref}) : super([]) {
    _fetchTimeds();
  }

  final Ref ref;
  late final TimedsRepository _rep = ref.watch(timedsRepositoryProvider);

  Future<void> _fetchTimeds() async {
    final result = await _rep.fetch();
    result.when(
      error: (e) {
        print(e);
        state = [];
      },
      loading: () {
        print('loading');
        state = [];
      },
      loaded: (timedList) {
        if (timedList.isNotEmpty) {
          ref.read(timedProvider.notifier).state = timedList.first;
        }
        state = timedList;
      },
    );
  }
}
