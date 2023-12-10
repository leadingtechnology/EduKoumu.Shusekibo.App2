import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kyoumutechou/feature/boxes.dart';
import 'package:kyoumutechou/feature/common/model/shozoku_model.dart';
import 'package:kyoumutechou/feature/common/provider/dantais_provider.dart';
import 'package:kyoumutechou/feature/common/provider/gakunens_provider.dart';
import 'package:kyoumutechou/feature/common/repository/shozokus_repository.dart';
import 'package:kyoumutechou/feature/common/state/api_state.dart';

final shozokuProvider = StateProvider<ShozokuModel>(
  (ref) => const ShozokuModel(),
);

final shozokusProvider = 
StateNotifierProvider<ShozokuNotifier, ApiState>((ref) {
  final dantai = ref.watch(dantaiProvider);
  final gakunen = ref.watch(gakunenProvider);
  
  return ShozokuNotifier(
    ref: ref, 
    dantaiId: dantai.id??0, 
    gakunenCode: gakunen.code??'',
  );
});

class ShozokuNotifier extends StateNotifier<ApiState> {
  ShozokuNotifier({
    required this.dantaiId, 
    required this.gakunenCode,
    required this.ref,}) : super(const ApiState.loading()) {
    _fetch();
  }

  final Ref ref;
  final int dantaiId;
  final String gakunenCode;

  final box = Boxes.getShozokus();
  late final ShozokusRepository _rep = ref.watch(shozokusRepositoryProvider);

  Future<void> _fetch() async {
    // 団体IDが空の場合、空のリストを返す
    if (dantaiId == 0) {
      state = const ApiState.loaded();
      return;
    }

    // データを取得する
    final response = await _rep.fetch(dantaiId);

    setDefaultValue();

    if (mounted) {
      state = response;
    }
  }

  void setDefaultValue(){
    // 初期値の設定
    final keys = box.keys
        .toList()
        .where((e) => e.toString().startsWith('$dantaiId-$gakunenCode-'))
        .toList();
        
    // ignore: cascade_invocations
    keys.sort((a, b) => a.toString().compareTo(b.toString()));

    if (keys.isNotEmpty) {
      try {
        final old = ref.read(shozokuProvider);
        if (!keys.contains('$dantaiId-${old.gakunenCode}-${old.id}')){
          final shozoku = box.get(keys.first)!;

          final oldShozoku = ref.read(shozokuProvider);
          if (shozoku.code != oldShozoku.code) {
            ref.read(shozokuProvider.notifier).state = shozoku;
          }
        }

      // ignore: empty_catches
      } catch (e) {}
    }
  }
}
