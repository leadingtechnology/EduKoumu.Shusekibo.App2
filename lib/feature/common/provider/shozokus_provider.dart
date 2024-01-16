import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kyoumutechou/feature/boxes.dart';
import 'package:kyoumutechou/feature/common/model/gakunen_model.dart';
import 'package:kyoumutechou/feature/common/model/shozoku_model.dart';
import 'package:kyoumutechou/feature/common/provider/dantais_provider.dart';
import 'package:kyoumutechou/feature/common/provider/gakunens_provider.dart';
import 'package:kyoumutechou/feature/common/state/api_state.dart';

final shozokuProvider = StateProvider<ShozokuModel>(
  (ref) => const ShozokuModel(),
);

final shozokusProvider =
    StateNotifierProvider<ShozokuNotifier, ApiState>((ref) {
  //final gakunen = ref.watch(gakunenProvider);

  //return ShozokuNotifier(ref: ref, gakunenCode: gakunen.code??'',);
  return ShozokuNotifier(
    ref: ref,
    gakunenCode: '',
  );
});

class ShozokuNotifier extends StateNotifier<ApiState> {
  ShozokuNotifier({
    required this.gakunenCode,
    required this.ref,
  }) : super(const ApiState.loading()) {
    _fetch(gakunenCode);
  }

  final Ref ref;
  final String gakunenCode;

  Future<void> init() async {
    state = const ApiState.loading();
    await _fetch(gakunenCode);
  }

  Future<void> _fetch(String gakunenCode) async {
    // final gakunen = ref.read(gakunenProvider);
    // final shozoku = setShozokuValue(ref, gakunen);
    // ref.read(shozokuProvider.notifier).state = shozoku;

    state = const ApiState.loaded();
  }

  ShozokuModel setShozokuValue(
    GakunenModel gakunen, {
    int? shozokuId,
  }) {
    final dantaiId = ref.read(dantaiProvider).id ?? 0;
    final gakunenCode = gakunen.gakunenCode ?? '';

    // 学年コードが空の場合は返す
    if (gakunenCode.isEmpty) {
      return const ShozokuModel();
    }

    final box = Boxes.getShozokus();
    ShozokuModel? shozoku = const ShozokuModel();

    try {
      // 初期値の設定
      final keys = box.keys
          .toList()
          .where((e) => e.toString().startsWith('$dantaiId-$gakunenCode-'))
          .toList();

      // 取得したKeysにより、shozokuListを取得する
      final shozokuList = keys.map(box.get).toList();

      if (keys.isEmpty || shozokuList.isEmpty) {
        return const ShozokuModel();
      }

      shozokuList.sort((a, b) {
        final nameCompare = '${a?.classCode}'.compareTo('${b?.classCode}');
        if (nameCompare != 0) return nameCompare;

        final hyojijunSort = a?.hyojijun ?? 0.compareTo(b?.hyojijun ?? 0);
        if (hyojijunSort != 0) return hyojijunSort;

        return a?.id ?? 0.compareTo(b?.id ?? 0);
      });
      

      try {
        if (shozokuId != null && shozokuId > 0) {
          shozoku = shozokuList.where((e) => e?.id == shozokuId).first;
        } else {
          shozoku = shozokuList.first;
        }
      } catch (e) {
        shozoku = shozokuList.first;
      }
    } catch (e) {
      shozoku = const ShozokuModel();
    }

    shozoku ??= const ShozokuModel();

    return shozoku;
  }
}
