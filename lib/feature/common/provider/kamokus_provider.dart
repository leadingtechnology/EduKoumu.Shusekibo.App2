import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kyoumutechou/feature/boxes.dart';
import 'package:kyoumutechou/feature/common/model/filter_model.dart';
import 'package:kyoumutechou/feature/common/model/kamoku_model.dart';
import 'package:kyoumutechou/feature/common/provider/filter_provider.dart';
import 'package:kyoumutechou/feature/common/repository/kamokus_repository.dart';
import 'package:kyoumutechou/feature/common/state/api_state.dart';

final kamokuProvider = StateProvider<KamokuModel>(
  (ref) => const KamokuModel(),
);

final kamokusProvider = StateNotifierProvider<KamokuNotifier, ApiState>((ref) {
  final filter = ref.watch(filterProvider);

  return KamokuNotifier(filter:filter, ref: ref);
});

class KamokuNotifier extends StateNotifier<ApiState> {
  KamokuNotifier({
    required this.filter,
    required this.ref,
  }) : super(const ApiState.loading()) {
    _fetch();
  }

  final Ref ref;
  final FilterModel filter;

  late final _rep = ref.read(kamokusRepositoryProvider);

  Future<void> _fetch() async {
    
    // 最新情報の取得
    await _rep.fetch(
          filter.dantaiId ?? 0,
          filter.gakunenCode ?? '',
        );

    state = const ApiState.loaded();
  }

  // 初期値を設定する
  Future<void> setKamokuValue(
    int dantaiId,
    String gakunenCode, 
  {
    String? dantaiBunrui,
    String? dantaiKbn,
    String? kyokaBunrui,
    String? kamokuCode,
  }) async{

    final box = Boxes.getKamokus();
    KamokuModel? kamoku = const KamokuModel();

    try {
      // 初期値の設定
      final keys = box.keys
          .toList()
          .where((e) => e.toString().startsWith('$dantaiId-$gakunenCode-'))
          .toList();

      // 取得したKeysにより、kamokuListを取得する
      final kamokuList = keys.map(box.get).toList();

      if (keys.isEmpty || kamokuList.isEmpty) {
        return;
      }


      try {
        if (kamokuCode != null && kamokuCode.isNotEmpty) {
          kamoku = kamokuList.where(
            (e) => e?.dantaiBunrui == dantaiBunrui &&
                  e?.dantaiKbn == dantaiKbn &&
                  e?.kyokaBunrui == kyokaBunrui &&
                  e?.kamokuCode == kamokuCode,
          ).first;
        }
      } catch (e) {
        //
      }
    } catch (e) {
      //
    }

    kamoku ??= const KamokuModel();

    ref.read(kamokuProvider.notifier).state = kamoku;

    return;
  }
}
