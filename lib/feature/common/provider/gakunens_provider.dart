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

    // // データを取得する
    // final response = await _rep.fetch('${dantai.organizationKbn}');

    setGakunenValue(ref, dantai);

    // if (mounted) {
    //   state = response;
    // }
    state = const ApiState.loaded();
  }
}

void setGakunenValue(
  Ref ref,
  DantaiModel dantai, {
  String? gakunenCode,
}) {
  final box = Boxes.getGakunens();
  GakunenModel? gakunen;

  // 初期値の設定
  final keys = box.keys
      .toList()
      .where(
        (e) => e.toString().startsWith('${dantai.organizationKbn}-'),
      )
      .toList();

  // ignore: cascade_invocations
  keys.sort(
    (a, b) => a.toString().compareTo(b.toString()),
  );

  if (keys.isNotEmpty) {
    try {
      if (gakunenCode != null && gakunenCode.isNotEmpty) {
        gakunen = Boxes.getGakunens()
            .values
            .where(
              (e) => e.gakunenCode == gakunenCode,
            )
            .first;
      } else {
        gakunen = box.get(keys.first);
      }

      ref.read(gakunenProvider.notifier).state =
          gakunen ?? const GakunenModel();

      // ignore: empty_catches
    } catch (e) {}
  }
}
