import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kyoumutechou/feature/boxes.dart';
import 'package:kyoumutechou/feature/common/model/filter_model.dart';
import 'package:kyoumutechou/feature/common/model/tanto_kyoin_model.dart';
import 'package:kyoumutechou/feature/common/provider/filter_provider.dart';
import 'package:kyoumutechou/feature/common/provider/kamokus_provider.dart';
import 'package:kyoumutechou/feature/common/provider/teachers_provider.dart';
import 'package:kyoumutechou/feature/common/repository/tanto_kyoin_repository.dart';
import 'package:kyoumutechou/feature/common/state/api_state.dart';
import 'package:kyoumutechou/shared/util/date_util.dart';

final tantoKyoinUpdateProvider = StateProvider<int>((ref) => 0);

final tantoKyoinProvider = StateProvider<TantoKyoinModel>(
  (ref) => const TantoKyoinModel(),
);

final tantoKyoinsProvider =
    StateNotifierProvider<TantoKyoinsNotifier, ApiState>((ref) {
  final filter = ref.watch(filterProvider);

  return TantoKyoinsNotifier(
    ref: ref,
    filter: filter,
  );
});

class TantoKyoinsNotifier extends StateNotifier<ApiState> {
  TantoKyoinsNotifier({
    required this.filter,
    required this.ref,
  }) : super(const ApiState.loading()) {
    _fetch();
  }

  final Ref ref;
  final FilterModel filter;

  late final _rep = ref.read(tantoKyoinsRepositoryProvider);

  Future<void> _fetch() async {
    // 最新情報の取得
    await _rep.fetch(
      filter.classId ?? 0,
      filter.targetDate ?? DateTime.now(),
    );

    state = const ApiState.loaded();
  }

  // 初期値を設定する
  Future<void> setTantoKyoinValue(
    int shozokuId,
    DateTime targetDate,
  ) async {

    final strDate = DateUtil.getStringDate(targetDate);

    // 最新情報の取得
    final response = await _rep.fetch(
      shozokuId,
      targetDate,
    );

    final box = Boxes.getTantoKyoins();
    var tantoKyoin = const TantoKyoinModel();

    // 初期値の設定
    final keys = box.keys
        .toList()
        .where(
          (element) => element.toString().startsWith('$shozokuId-$strDate-'),
        )
        .toList();

    if (keys.isNotEmpty) {
      try {
        final tantoKyoinList = keys.map(box.get).toList();
        tantoKyoinList.sort((a, b) => a!.jigenIdx!.compareTo(b!.jigenIdx!));

        final firstValue = tantoKyoinList.first;
        tantoKyoin = firstValue ?? const TantoKyoinModel();
      } catch (e) {
        tantoKyoin = const TantoKyoinModel();
      }
    }

    if (tantoKyoin.jigenIdx  != null && tantoKyoin.jigenIdx! > 0 ){
      final kamoku = ref.read(kamokuProvider);
      final teachers = ref.read(teacherListProvider);


    }




    return;
  }
}
