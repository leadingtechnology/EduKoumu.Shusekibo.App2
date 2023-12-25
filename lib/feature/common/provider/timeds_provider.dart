import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kyoumutechou/feature/boxes.dart';
import 'package:kyoumutechou/feature/common/model/shozoku_model.dart';
import 'package:kyoumutechou/feature/common/model/timed_model.dart';
import 'package:kyoumutechou/feature/common/provider/filter_provider.dart';
import 'package:kyoumutechou/feature/common/provider/shozokus_provider.dart';
import 'package:kyoumutechou/feature/common/repository/timeds_repository.dart';
import 'package:kyoumutechou/feature/common/state/api_state.dart';
import 'package:kyoumutechou/shared/util/date_util.dart';

final timedProvider = StateProvider<TimedModel>(
  (ref) => const TimedModel(),
);

final timedsProvider = StateNotifierProvider<TimedsNotifier, ApiState>((ref) {
  final targetDate = ref.watch(targetDateProvider);
  final shozoku = ref.watch(shozokuProvider);

  return TimedsNotifier(
    ref: ref, 
    shozoku: shozoku,
    strDate: DateUtil.getStringDate(targetDate) ,
  );

});

class TimedsNotifier extends StateNotifier<ApiState> {
  TimedsNotifier({
    required this.strDate, 
    required this.shozoku,
    required this.ref,
  }) : super(const ApiState.loading()) {
    _fetch();
  }

  final Ref ref;
  final ShozokuModel shozoku;
  final String strDate;

  late final _rep = ref.read(timedsRepositoryProvider);

  Future<void> _fetch() async {
    // 所属Idの取得
    final shozokuId = ref.read(shozokuProvider).id;
    
    // 最新情報の取得
    final response = ref.read(timedsRepositoryProvider).fetch(
          shozoku.id ?? 0,
          strDate,
        );
    
    state = const ApiState.loaded();
  }

  // 初期値を設定する
  TimedModel setTimedValue() {
    // 最新情報の取得条件
    final targetDate = ref.read(targetDateProvider);
    final strDate = DateUtil.getStringDate(targetDate);
    final shozoku = ref.read(shozokuProvider);

    // 最新情報の取得
    final response = ref.read(timedsRepositoryProvider).fetch(
          shozoku.id ?? 0,
          strDate,
        );

    final box = Boxes.getTimeds();
    var timed = const TimedModel();

    // 初期値の設定
    final keys = box.keys
        .toList()
        .where(
          (element) => element.toString().startsWith('${shozoku.id}-$strDate-'),
        )
        .toList();

    if (keys.isNotEmpty) {
      try {
        final timedList = keys.map(box.get).toList();
        timedList.sort((a, b) => a?.jigenIdx ?? 0.compareTo(b?.jigenIdx ?? 0));

        final firstValue = timedList.last;
        timed = firstValue ?? const TimedModel();
      } catch (e) {
        timed = const TimedModel();
      }
    }

    return timed;
  }

}
