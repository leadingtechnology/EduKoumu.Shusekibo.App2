import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kyoumutechou/feature/boxes.dart';
import 'package:kyoumutechou/feature/common/model/timed_model.dart';
import 'package:kyoumutechou/feature/common/provider/filter_provider.dart';
import 'package:kyoumutechou/feature/common/provider/shozokus_provider.dart';
import 'package:kyoumutechou/feature/common/repository/timeds_repository.dart';

final timedProvider = StateProvider<TimedModel>((ref) => const TimedModel());

final timedsProvider =
    StateNotifierProvider<TimedsNotifier, List<TimedModel>>((ref) {

  final shozoku = ref.watch(shozokuProvider);
  final targetDate = ref.watch(filterDateProvider);

  return TimedsNotifier(
    ref: ref, 
    shozokuId: shozoku.id??0, 
    targetDate: targetDate,
  );

});

class TimedsNotifier extends StateNotifier<List<TimedModel>> {
  TimedsNotifier({
    required this.shozokuId, 
    required this.targetDate, 
    required this.ref,
  }) : super([]) {
    _fetch();
  }

  final Ref ref;
  final int shozokuId;
  final DateTime targetDate;
  final box = Boxes.getTimedModelBox();
  late final TimedsRepository _rep = ref.watch(timedsRepositoryProvider);

  Future<void> _fetch() async {
    // 1.所属Idが空の場合、空のリストを返す
    if (shozokuId == 0) {
      state = [];
      return;
    }

    // 2.ローカルデータを取得する


    // 3.リモートデータを取得する
    final result = await _rep.fetch(shozokuId, targetDate);
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

        // ローカルデータを保存する
        for (final element in timedList) {
          box.put('$shozokuId-${element.jigenIdx}', element);
        }

        state = timedList;
      },
    );
  }
}
