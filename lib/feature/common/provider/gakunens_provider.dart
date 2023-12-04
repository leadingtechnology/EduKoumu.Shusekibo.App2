import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kyoumutechou/feature/boxes.dart';
import 'package:kyoumutechou/feature/common/model/gakunen_model.dart';
import 'package:kyoumutechou/feature/common/provider/dantais_provider.dart';
import 'package:kyoumutechou/feature/common/repository/gakunens_repository.dart';

final gakunenProvider =
    StateProvider<GakunenModel>((ref) => const GakunenModel());

final gakunensProvider =
    StateNotifierProvider<GakunenNotifier, List<GakunenModel>>((ref) {
      final dantai = ref.watch(dantaiProvider);

  return GakunenNotifier(ref: ref, organizationKbn: dantai.organizationKbn??'');
});

class GakunenNotifier extends StateNotifier<List<GakunenModel>> {
  GakunenNotifier({
    required this.ref, 
    required this.organizationKbn,}) : super([]) {
    _fetch();
  }

  final Ref ref;
  final String organizationKbn;
  final box = Boxes.getGakunenModelBox();
  late final GakunensRepository _rep = ref.watch(gakunensRepositoryProvider);

  Future<void> _fetch() async {
    // 1.団体区分が空の場合、空のリストを返す
    if (organizationKbn.isEmpty) {
      state = [];
      return;
    }
    
    // 2.ローカルデータを取得する
    // if (box.isNotEmpty) {
    //   final keys = box.keys.toList().where(
    //         (element) => element.toString().startsWith('$organizationKbn-'),
    //       );
      
    //   // keysの値が存在した場合、boxから取得したデータをstateにセットする
    //   if (keys.isNotEmpty) {
    //     final gakunenList = keys
    //         .map(box.get)
    //         .toList();
    //     state = gakunenList as List<GakunenModel>;
    //     return;
    //   }
    // }    
    
    // 3.リモートデータを取得する
    final result = await _rep.fetch(organizationKbn);
    result.when(
      error: (e) {
        print(e);
        state = [];
      },
      loading: () {
        print('loading');
        state = [];
      },
      loaded: (gakunenList) {
        if (gakunenList.isNotEmpty) {
          ref.read(gakunenProvider.notifier).state = gakunenList.first;
        }

        // ローカルデータを保存する
        for (final element in gakunenList) {
          box.put('$organizationKbn-${element.id}', element);
        }

        state = gakunenList;
      },
    );
  }
}
