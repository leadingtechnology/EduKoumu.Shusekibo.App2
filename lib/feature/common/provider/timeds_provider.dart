import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kyoumutechou/feature/boxes.dart';
import 'package:kyoumutechou/feature/common/model/timed_model.dart';
import 'package:kyoumutechou/feature/common/provider/filter_provider.dart';
import 'package:kyoumutechou/feature/common/provider/shozokus_provider.dart';
import 'package:kyoumutechou/feature/common/repository/timeds_repository.dart';
import 'package:kyoumutechou/feature/common/state/api_state.dart';
import 'package:kyoumutechou/shared/util/date_util.dart';

final timedProvider = StateProvider<TimedModel>(
  (ref) => const TimedModel(),
);

final timedsProvider =
    StateNotifierProvider<TimedsNotifier, ApiState>((ref) {
  final shozoku = ref.watch(shozokuProvider);
  final targetDate = ref.watch(targetDateProvider);

  return TimedsNotifier(
    ref: ref, 
    shozokuId: shozoku.id??0, 
    strDate: DateUtil.getStringDate(targetDate) ,
  );

});

class TimedsNotifier extends StateNotifier<ApiState> {
  TimedsNotifier({
    required this.shozokuId, 
    required this.strDate, 
    required this.ref,
  }) : super(const ApiState.loading()) {
    _fetch();
  }

  final Ref ref;
  final int shozokuId;
  final String strDate;

  late final TimedsRepository _rep = ref.watch(timedsRepositoryProvider);

  Future<void> _fetch() async {
    // 所属Idが空の場合、空のリストを返す
    if (shozokuId == 0) {
      state = const ApiState.loaded();
      return;
    }
    
    // データを取得する
    final response = await _rep.fetch(shozokuId, strDate);

    setTimedValue(ref, shozokuId: shozokuId, strDate: strDate);
    
    if (mounted) {
      state = response;
    }
  }
}

void setTimedValue(
  Ref ref, {int? shozokuId, String? strDate,
}) {
  final box = Boxes.getTimeds();
  var timed = const TimedModel();

  if (shozokuId == 0) {
    ref.read(timedProvider.notifier).state = timed;
    return ;
  }

  // 初期値の設定
  final keys = box.keys
      .toList()
      .where(
        (element) => element.toString().startsWith('$shozokuId-$strDate-'),
      )
      .toList();
  
  if (keys.isNotEmpty) {
    try {
      keys.sort((a, b) => a.toString().compareTo(b.toString()));

      final firstKey = keys.first;
      final firstValue = box.get(firstKey);

      timed = firstValue ?? const TimedModel();

    } catch (e) {
      timed = const TimedModel();
    }
  }

  ref.read(timedProvider.notifier).state = timed;
}
