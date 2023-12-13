import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kyoumutechou/feature/boxes.dart';
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
    final dantaiId = ref.read(dantaiProvider).id;
    
    if (dantaiId! > 0 && gakunenCode.isNotEmpty){
      setShozokuValue(ref, dantaiId, gakunenCode);
    }
    state = const ApiState.loaded();
  }
}

void setShozokuValue(
  Ref ref,
  int dantaiId,
  String gakunenCode, {
  int? shozokuId,
}) {
  final box = Boxes.getShozokus();
  ShozokuModel? shozoku;

  var gcode = '';
  if (gakunenCode.isEmpty) {
    gcode = ref.read(gakunenProvider).code ?? '';
  } else {
    gcode = gakunenCode;
  }

  // 初期値の設定
  final keys = box.keys
      .toList()
      .where((e) => e.toString().startsWith('$dantaiId-$gcode-'))
      .toList();

  // ignore: cascade_invocations
  keys.sort((a, b) => a.toString().compareTo(b.toString()));

  if (keys.isNotEmpty) {
    try {
      if (shozokuId != null && shozokuId > 0) {
        shozoku = Boxes.getShozokus()
            .values
            .where(
              (e) => e.id == shozokuId,
            )
            .first;
      } else {
        shozoku = box.get(keys.first);
      }

      ref.read(shozokuProvider.notifier).state =
          shozoku ?? const ShozokuModel();

      // ignore: empty_catches
    } catch (e) {}
  }
}
