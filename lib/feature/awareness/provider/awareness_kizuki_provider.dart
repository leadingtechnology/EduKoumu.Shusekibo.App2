import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:kyoumutechou/feature/awareness/model/awareness_kizuki_model.dart';
import 'package:kyoumutechou/feature/awareness/provider/awareness_meibo_provider.dart';
import 'package:kyoumutechou/feature/awareness/repsitory/awareness_kizuki_repository.dart';
import 'package:kyoumutechou/feature/awareness/repsitory/awareness_meibo_repository.dart';
import 'package:kyoumutechou/feature/boxes.dart';
import 'package:kyoumutechou/feature/common/provider/filter_provider.dart';
import 'package:kyoumutechou/feature/common/state/api_state.dart';

final awarenessKizukiListProvider = 
StateNotifierProvider<AwarenessKizukiListProvider, ApiState>((ref) {
  final filter = ref.watch(filterProvider);

  return AwarenessKizukiListProvider(ref);
});

final awarenessKizukiProvider = StateProvider<AwarenessKizukiModel>(
  (ref) => const AwarenessKizukiModel(),
);

// カメラ撮った写真リストを保持する
final tenpuList = StateProvider<List<String>>((ref) => []);


final awarenessCountProvider = StateProvider<int>((ref) => 0);
final awarenessListSearchProvider = StateProvider<int>((ref) => 0);

class AwarenessKizukiListProvider extends StateNotifier<ApiState> {
  AwarenessKizukiListProvider(this.ref,) : super(const ApiState.loading()) {
    _init();
  }

  final Ref ref;
  late final _repository = ref.read(awarenessKizukiRepositoryProvider);
  late final _rep = ref.read(awarenessMeiboRepositoryProvider);

  Future<void> _init() async {
    await _fetch();
  }

  Future<void> _fetch() async {
    final response = await _repository.fetch();
    if (mounted) {
      state = response;
    }
  }

  Future<void> patch(String str) async {
    final juyo = ref.read(awarenessJuyoProvider);
    final burui = ref.read(awarenessBunruiProvider);

    final boxKizuki = Boxes.getAwarenessKizukiModelBox();
    final studentList = boxKizuki.values.toList();

    final id = ref.read(awarenessEditProvider);
    final kizuki = studentList.where((e) => e.id == id).toList().first;

    final json = '''
{
    "Id": ${kizuki.id},
    "Kizuki": "$str",
    "JuyoFlg": $juyo,
    "KaruteBunruiCode": $burui,
}
   ''';

    await _repository.patch(id, json);
    await _repository.fetch();

  }

  Future<void> delete(AwarenessKizukiModel kizuki) async {
    final response = await _repository.delete(kizuki, '');
    await _rep.fetchAwarenessMeibo();
    await _repository.fetch();
    
    await Boxes.getAwarenessKizukiModelBox().delete('${kizuki.id}');

    if (mounted) {
      state = response;
    }
  }
}
