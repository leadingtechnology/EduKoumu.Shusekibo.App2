import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kyoumutechou/feature/boxes.dart';
import 'package:kyoumutechou/feature/common/model/dantai_model.dart';
import 'package:kyoumutechou/feature/common/model/gakunen_model.dart';
import 'package:kyoumutechou/feature/common/provider/dantais_provider.dart';
import 'package:kyoumutechou/feature/common/state/api_state.dart';

final gakunenProvider = StateProvider<GakunenModel>(
  (ref) => const GakunenModel(),
);

final gakunensProvider =
    StateNotifierProvider<GakunenNotifier, ApiState>((ref) {

  return GakunenNotifier(ref: ref);
});

class GakunenNotifier extends StateNotifier<ApiState> {
  GakunenNotifier({
    required this.ref,
  }) : super(const ApiState.loading()) {
    _fetch();
  }

  final Ref ref;


  //late final GakunensRepository _rep = ref.watch(gakunensRepositoryProvider);

  Future<void> init() async {
    state = const ApiState.loading();
    await _fetch();
  }

  Future<void> _fetch() async {
    final dantai = ref.read(dantaiProvider);
    setGakunenValue(ref, dantai);

    state = const ApiState.loaded();
  }

  GakunenModel setGakunenValue(
    Ref ref,
    DantaiModel dantai, {
    String? gakunenCode,
  }) {
    final box = Boxes.getGakunens();
    GakunenModel? gakunen = const GakunenModel();

    // 団体Idが空の場合は返す
    if (dantai.id == 0) {
      return const GakunenModel();
    }

    try {
      // 初期値の設定
      final keys = box.keys
          .toList()
          .where(
            (e) => e.toString().startsWith('${dantai.organizationKbn}-'),
          )
          .toList();

      // 取得したKeysにより、gakunenListを取得する
      final gakunenList = keys.map(box.get).toList();

      //　ソートする
      gakunenList.sort(
        (a, b) => '${a?.kateiKbn}-${a?.gakunenCode}'.compareTo('${b?.kateiKbn}-${b?.gakunenCode}'),
      );

      try {
        if (gakunenCode != null && gakunenCode.isNotEmpty) {
          gakunen = gakunenList
              .where(
                (e) => e?.gakunenCode == gakunenCode,
              )
              .first;
        } else {
          gakunen = gakunenList.first;
        }
      } catch (e) {
        gakunen = gakunenList.first;
      }
    } catch (e) {
      gakunen = const GakunenModel();
    }

    gakunen ??= const GakunenModel();

    return gakunen;
  }

}

