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
  final gakunen = ref.watch(gakunenProvider);
  
  return ShozokuNotifier(ref: ref, gakunenCode: gakunen.code??'',);
});

class ShozokuNotifier extends StateNotifier<ApiState> {
  ShozokuNotifier({
    required this.gakunenCode, required this.ref,
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
    final gakunen = ref.read(gakunenProvider);
    setShozokuValue(ref, gakunen);

    state = const ApiState.loaded();
  }
}

ShozokuModel setShozokuValue(
  Ref ref,
  GakunenModel gakunen,
 {
  int? shozokuId,
}) {
  final dantaiId = ref.read(dantaiProvider).id ?? 0;
  final gakunenCode = gakunen.code ?? '';

  // 学年コードが空の場合は返す
  if (gakunenCode.isEmpty) {
    
    return const ShozokuModel();
  }

  final box = Boxes.getShozokus();
  ShozokuModel? shozoku = const ShozokuModel();

  try{
    // 初期値の設定
    final keys = box.keys
        .toList()
        .where((e) => e.toString().startsWith('$dantaiId-$gakunenCode-'))
        .toList();

    // ignore: cascade_invocations
    keys.sort((a, b) => a.toString().compareTo(b.toString()));

    // 取得したKeysにより、shozokuListを取得する
    final shozokuList = keys.map(box.get).toList();

    try {
      if (shozokuId != null && shozokuId > 0) {
        shozoku = shozokuList
            .where((e) => e?.id == shozokuId)
            .first;
      } else {
        shozoku = shozokuList.first;
      }
    } catch (e) {
      shozoku = shozokuList.first;
    }

  }catch(e){
    shozoku = const ShozokuModel();
  }

  shozoku ??= const ShozokuModel();

  return shozoku;
}
