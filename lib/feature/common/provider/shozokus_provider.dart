import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kyoumutechou/feature/boxes.dart';
import 'package:kyoumutechou/feature/common/model/shozoku_model.dart';
import 'package:kyoumutechou/feature/common/provider/dantais_provider.dart';
import 'package:kyoumutechou/feature/common/provider/gakunens_provider.dart';
import 'package:kyoumutechou/feature/common/repository/shozokus_repository.dart';

final shozokuProvider =
    StateProvider<ShozokuModel>((ref) => const ShozokuModel());

final shozokusProvider =
    StateNotifierProvider<ShozokuNotifier, List<ShozokuModel>>((ref) {
  final dantai = ref.watch(dantaiProvider);
  final gakunen = ref.watch(gakunenProvider);
  
  return ShozokuNotifier(
    ref: ref, 
    dantaiId: dantai.id??0, 
    gakunenCode: gakunen.gakunenCode ??'',
    );
});

class ShozokuNotifier extends StateNotifier<List<ShozokuModel>> {
  ShozokuNotifier({
    required this.dantaiId, 
    required this.gakunenCode, 
    required this.ref,}) : super([]) {
    _fetchShozoku();
  }

  final Ref ref;
  final int dantaiId;
  final String gakunenCode;
  final box = Boxes.getShozokuModelBox();
  late final ShozokusRepository _rep = ref.watch(shozokusRepositoryProvider);

  Future<void> _fetchShozoku() async {
    // 1.団体IDが空の場合、空のリストを返す
    if (dantaiId == 0) {
      state = [];
      return;
    }

    // // 2.ローカルデータを取得する
    // if (box.isNotEmpty) {
    //   final keys = box.keys.toList().where(
    //         (element) => element.toString().startsWith('$dantaiId-'),
    //       );
    //   if (keys.isNotEmpty) {

    //     final shozokuList = keys
    //         .map(box.get)
    //         .toList()
    //         .where((e) => e?.gakunenCode == gakunenCode)
    //         .toList();

    //     state = shozokuList as List<ShozokuModel>;
    //     return;
    //   }
    // }

    // 3.リモートデータを取得する
    final result = await _rep.fetch(dantaiId);
    result.when(
      error: (e) {
        print(e);
        state = [];
      },
      loading: () {
        print('loading');
        state = [];
      },
      loaded: (shozokuList) {
        if (shozokuList.isNotEmpty) {
          ref.read(shozokuProvider.notifier).state = shozokuList.first;
        }

        // ローカルデータを保存する
        shozokuList.forEach((element) {
          box.put('$dantaiId-${element.id}', element);
        });

        state = shozokuList.where((e) => e.gakunenCode == gakunenCode).toList();
      },
    );
  }
}
