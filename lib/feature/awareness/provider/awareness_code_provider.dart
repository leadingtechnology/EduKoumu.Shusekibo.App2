import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:kyoumutechou/feature/awareness/model/awareness_code_model.dart';
import 'package:kyoumutechou/feature/boxes.dart';
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
  final box = Boxes.getBunruiBox();

  Future<void> _init() async { await fetch(); }
  Future<void> fetch() async { state = const ApiState.loading(); }

  AwarenessCodeModel setCodeValue(
    {String? code,}
  ) {
    var awarenessCode = const AwarenessCodeModel(
      code: '',
      name: '',
      id: 0,
      shortName: '',
    );

    // 初期値の取得
    final box = Boxes.getBunruiBox();
    try {
      // リストを取得する
      final codeList = box.values.toList()
      ..sort((a, b) => '${a.code}'.compareTo('${a.code}'));

      if (code != null && code.isNotEmpty) {
        // codeが存在する場合、codeListからcodeを取得する
        awarenessCode = codeList.firstWhere((e) => e.code == code);
      } else {
        // codeが存在しない場合、codeListの一番最初の値を取得する
        awarenessCode = codeList.first;
      }
    } catch (e) {
      awarenessCode = const AwarenessCodeModel();
    }

    return awarenessCode;
  }

  Map<String, String> getBunruiList() {
    

    final bunruiMap = <String, String>{};

    try {
      final codeList = box.values.toList();
      // ignore: cascade_invocations
      codeList.sort(
        (a, b) => '${a.code}'.compareTo('${b.code}'),
      );

      for (final e in codeList) {
        bunruiMap['${e.code}'] = '${e.name}';
      }
    } on Exception {
      //
    }
    return bunruiMap;
  }

}
