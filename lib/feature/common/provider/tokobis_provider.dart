import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kyoumutechou/feature/boxes.dart';
import 'package:kyoumutechou/feature/common/model/tokobi_model.dart';
import 'package:kyoumutechou/feature/common/provider/filter_provider.dart';
import 'package:kyoumutechou/feature/common/repository/tokobis_repository.dart';
import 'package:kyoumutechou/feature/common/state/api_state.dart';
import 'package:kyoumutechou/shared/util/date_util.dart';

final isTokobiProvider = StateProvider<bool>((ref) => false);
final tokobiProvider = StateProvider<TokobiModel>((ref) => const TokobiModel());

final tokobisProvider =
    StateNotifierProvider<TokobiNotifier, ApiState>((ref) {
  final filter = ref.watch(filterProvider);

  return TokobiNotifier(
    ref: ref,
    shozokuId: filter.classId ?? 0,
    targetDate: filter.targetDate??DateTime.now(),
    isKoryu: filter.kouryuGakkyu??false,
  );
});

class TokobiNotifier extends StateNotifier<ApiState> {
  TokobiNotifier({
    required this.ref,
    required this.shozokuId,
    required this.targetDate,
    required this.isKoryu,
  }) : super(const ApiState.loading()) {
    _fetch(ref);
  }

  final Ref ref;
  final int shozokuId;
  final DateTime targetDate;
  final bool isKoryu;

  final box = Boxes.getTokobis();
  late final _rep = ref.watch(tokobisRepositoryProvider);

  Future<void> _fetch(Ref ref) async {
    // 所属IDが空の場合、空のリストを返す
    if (shozokuId == 0) {
      state = const ApiState.loaded();
      return;
    }
    final response = await _rep.fetch(shozokuId, targetDate, isKoryu);

    // 初期値を設定する
    await setTokobiValue(shozokuId, targetDate);

    if (mounted) {
      state = response;
    }
  }

  Future<void> setTokobiValue(
    int shozokuId, 
    DateTime targetDate,
  ) async{
    
    final strDate = DateUtil.getStringDate(targetDate);
    final key = box.keys.toList().where(
          (element) => element.toString().startsWith('$shozokuId-$strDate'),
        ).toList().firstOrNull;
    
    var isEditable = false ;
    if(key != null){
      final tokobi = box.get(key);
      if(tokobi != null){
        isEditable = tokobi.isEditable ?? false;

        ref.read(tokobiProvider.notifier).state = tokobi;
      }
    }

    ref.read(isTokobiProvider.notifier).state = isEditable;

  }
}
