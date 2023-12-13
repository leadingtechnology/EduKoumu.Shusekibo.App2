import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kyoumutechou/feature/boxes.dart';
import 'package:kyoumutechou/feature/common/model/tannin_model.dart';
import 'package:kyoumutechou/feature/common/provider/dantais_provider.dart';
import 'package:kyoumutechou/feature/common/provider/filter_provider.dart';
import 'package:kyoumutechou/feature/common/repository/tannin_repository.dart';
import 'package:kyoumutechou/feature/common/state/api_state.dart';
import 'package:kyoumutechou/shared/util/date_util.dart';


final tanninListProvider =
    StateNotifierProvider<TanninNotifier, ApiState>((ref) {
  final targetDate = ref.watch(targetDateProvider);
      
  return TanninNotifier(
    ref,
    DateUtil.getStringDate(targetDate) ,
  );
});

final tanninProvider = StateProvider<TanninModel>((ref) => const TanninModel());

class TanninNotifier extends StateNotifier<ApiState> {
  TanninNotifier(
    this.ref,
    this.strDate,
  ) : super(const ApiState.loading()) {
    _fetch();
  }

  final Ref ref;
  final String strDate;

  final box = Boxes.getTannin();
  late final TanninRepository _repository = ref.read(tanninRepositoryProvider);

  Future<void> _fetch() async {
    final dantaiId = ref.read(dantaiProvider).id ?? 0;

    if (dantaiId == 0) {
      return;
    }

    final response = await _repository.fetch(dantaiId, strDate);

    // 担任情報の取得
    final keys = box.keys.toList().where(
          (element) => element.toString().startsWith('$dantaiId-$strDate'),
        );
    if (keys.isNotEmpty) {
      final tannin = box.get(keys.first)!;
      if(tannin.shozokuId != 0) {
        ref.read(tanninProvider.notifier).state = tannin;
      }
    }

    if (mounted) {
      state = response;
    }
  }
}

// final tanninProvider = FutureProvider<TanninModel>((ref) async {
  
//   final dantai = ref.watch(dantaiProvider);
//   final filter = ref.watch(filterProvider);

//   if (dantai.id == 0) {
//     return const TanninModel();
//   }

//   final box = Boxes.getTannin();
//   final strDate = DateUtil.getStringDate(filter.targetDate??DateTime.now());
  
//   // 10)団体Id,　対象日付の担任データが存在する場合、正常終了とする
//   if (box.isNotEmpty) {
//     final keys = box.keys.toList().where(
//       (element) => element.toString().startsWith('${dantai.id}-$strDate-'),
//     );
    
//     // keysの値が存在した場合、boxから取得する
//     if (keys.isNotEmpty) {
//       final tannin = box.get(keys.first)!;
//       return tannin;
//     }
//   }

//   return const TanninModel();
// });
