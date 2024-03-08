import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:kyoumutechou/feature/awareness/model/awareness_kizuki_model.dart';
import 'package:kyoumutechou/feature/awareness/provider/awareness_meibo_provider.dart';
import 'package:kyoumutechou/feature/awareness/provider/tenpu_provider.dart';
import 'package:kyoumutechou/feature/awareness/repsitory/awareness_kizuki_repository.dart';
import 'package:kyoumutechou/feature/awareness/repsitory/awareness_meibo_repository.dart';
import 'package:kyoumutechou/feature/boxes.dart';
import 'package:kyoumutechou/feature/common/provider/filter_provider.dart';
import 'package:kyoumutechou/feature/common/state/api_state.dart';
import 'package:kyoumutechou/shared/util/date_util.dart';
import 'package:kyoumutechou/shared/util/image_handler.dart';

final awarenessKizukiListProvider = 
StateNotifierProvider<AwarenessKizukiListProvider, ApiState>((ref) {
  final filter = ref.watch(filterProvider);

  return AwarenessKizukiListProvider(ref);
});

final awarenessKizukiProvider = StateProvider<AwarenessKizukiModel>(
  (ref) => const AwarenessKizukiModel(),
);

final awarenessCountProvider = StateProvider<int>((ref) => 0);
final awarenessListSearchProvider = StateProvider<int>((ref) => 0);
final awarenessTabIndexProvider = StateProvider<int>((ref) => 0);

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

  Future<void> get(int kizukiId) async {
    final response = await _repository.get(kizukiId);
    if (mounted) {
      state = response;
    }
  }

  Future<void> patch(String text, String burui) async {
    final juyo = ref.read(awarenessJuyoProvider);
    final images = ref.read(tenpuListProvider);

    final boxKizuki = Boxes.getAwarenessKizukiModelBox();
    final studentList = boxKizuki.values.toList();

    final id = ref.read(awarenessEditProvider);
    final kizuki = studentList.where((e) => e.id == id).toList().first;

    // 添付ファイルデータの作成
    final box = Boxes.getImageUrl();
    final tenpuList = <String>[];
    for (final image in images) {
      final imageData = await ImageHandler.fetchImageData(image);
      
      int? id = 0;
      for (final key in box.keys) {
        if (box.get(key) == image) {
          id = key as int?;
          break;
        }
      }

      final value = '''
{
  "tenpuId": $id,
  "tenpuFileName": "${DateUtil.getDatetimeStamp()}.JPEG",
  "tenpuFileSize": ${imageData.length},
  "tenpuFileData": $imageData
}
''';
      tenpuList.add(value);
    }


    final json = '''
{
    "Id": ${kizuki.id},
    "Kizuki": "$text",
    "JuyoFlg": $juyo,
    "KaruteBunruiCode": $burui,
    "TenpuFileList": $tenpuList
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
