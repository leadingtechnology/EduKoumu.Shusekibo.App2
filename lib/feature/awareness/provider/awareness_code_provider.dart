import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:kyoumutechou/feature/awareness/model/awareness_code_model.dart';
import 'package:kyoumutechou/feature/boxes.dart';
import 'package:kyoumutechou/feature/common/model/dantai_model.dart';
import 'package:kyoumutechou/feature/common/state/api_state.dart';

final awarenessCodeListProvider = 
StateNotifierProvider<AwarenessCodeListProvider, ApiState>((ref) {
  return AwarenessCodeListProvider(ref);
});

final awarenessCodeProvider = StateProvider<AwarenessCodeModel>(
  (ref) => const AwarenessCodeModel(),
);

class AwarenessCodeListProvider extends StateNotifier<ApiState> {
  AwarenessCodeListProvider(this.ref)
      : super(const ApiState.loading()) {
    _init();
  }

  final Ref ref;

  Future<void> _init() async { await fetch(); }

  Future<void> fetch() async {

  }

  AwarenessCodeModel setCodeValue(
    Ref ref,
    DantaiModel dantai, {
    String? code,
  }) {
    AwarenessCodeModel? awarenessCode = const AwarenessCodeModel();

    // 団体Idが空の場合は返す
    if (dantai.id == 0) {
      return awarenessCode;
    }

    // 初期値の取得
    final box = Boxes.getBunruiBox();
    try {
      // 初期値の設定
      final keys = box.keys
          .toList()
          .where((e) => e.toString().startsWith('${dantai.id}}-'))
          .toList();

      // 取得したKeysにより、shozokuListを取得する
      final codeList = keys.map(box.get).toList();
      codeList.sort((a, b) => '${a?.code}'.compareTo('${a?.code}'));

      if (code != null && code.isNotEmpty) {
        // codeが存在する場合、codeListからcodeを取得する
        awarenessCode = codeList.firstWhere((e) => e?.code == code);
      } else {
        // codeが存在しない場合、codeListの一番最初の値を取得する
        awarenessCode = codeList.first;
      }
    } catch (e) {
      awarenessCode = const AwarenessCodeModel();
    }

    awarenessCode ??= AwarenessCodeModel();
    return awarenessCode;
  }

}


