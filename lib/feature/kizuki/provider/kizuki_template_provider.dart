
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kyoumutechou/feature/common/model/filter_model.dart';
import 'package:kyoumutechou/feature/common/provider/filter_provider.dart';
import 'package:kyoumutechou/feature/kizuki/repository/kizuki_template_repository.dart';
import 'package:kyoumutechou/feature/kizuki/state/kizuki_template_state.dart';


final kizukiTemplateProvider =
    StateNotifierProvider<KizukiTemplateProvider, KizukiTemplateState>((ref) {
  final filter = ref.watch(filterProvider);

  return KizukiTemplateProvider(ref, filter);
});

class  KizukiTemplateProvider extends StateNotifier<KizukiTemplateState> {
  KizukiTemplateProvider(this.ref, this.filter)
      : super(const KizukiTemplateState.loading()) {
    _init();
  }

  final Ref ref;
  final FilterModel filter;

  late final rep = ref.read(kizukiTemplateRepositoryProvider);

  Future<void> _init() async {
    await _fetch();
  }

  Future<void> _fetch() async {
    final response = await rep.fetch();
    state = response;
  }

  Future<void> save({
    required String kinyuKyoinId,

    required String karuteSettingId,
    required String karuteShubetsuNaibuCode,
    required String karuteBunruiCode,

    required String title,
    required String kizukiTemplate,
    required String commonFlg,
  }) async {
    final dantaiId = ref.read(filterProvider).dantaiId ?? 0;

    final json = '''
{
    "DantaiId": $dantaiId,
    "KinyuKyoinId": $kinyuKyoinId,
    "KaruteSettingId": $karuteSettingId,
    "KaruteShubetsuNaibuCode": "$karuteShubetsuNaibuCode",
    "KaruteBunruiCode": "$karuteBunruiCode",
    "Title": "$title",
    "KizukiTemplate": "$kizukiTemplate",
    "CommonFlg": ${commonFlg == '1' ? 'true' : 'false'}
}
''';

    final response = await rep.save(json);

    state = response;
  }

  Future<void> patch({
    required int id,
    required String kinyuKyoinId,
    required String karuteSettingId,
    required String karuteShubetsuNaibuCode,
    required String karuteBunruiCode,
    required String title,
    required String kizukiTemplate,
    required String commonFlg,
  }) async {
    final json = '''
{
    "KinyuKyoinId": $kinyuKyoinId,
    "KaruteSettingId": $karuteSettingId,
    "KaruteShubetsuNaibuCode": "$karuteShubetsuNaibuCode",
    "KaruteBunruiCode": "$karuteBunruiCode",
    "Title": "$title",
    "KizukiTemplate": "$kizukiTemplate",
    "CommonFlg": ${commonFlg == '1' ? 'true' : 'false'}
}
''';

    final response = await rep.patch(id, json);

    state = response;
  }

  Future<void> delete(int id) async {
    final response = await rep.delete(id);

    state = response;
  }
}
