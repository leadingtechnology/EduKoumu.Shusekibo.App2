
import 'package:kyoumutechou/feature/kizuki/model/kizuki_template_model.dart';
import 'package:kyoumutechou/feature/kizuki/repository/kizuki_template_repository.dart';
import 'package:kyoumutechou/feature/kizuki/state/kizuki_template_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'kizuki_template_provider.g.dart';

//final kzukiSearchTextProvider = StateProvider<String>((ref) => '');

@riverpod
class KizukiTemplateNotifier extends _$KizukiTemplateNotifier {
  late final rep = ref.read(kizukiTemplateRepositoryProvider);

  @override
  KizukiTemplateState build() {
    _fetch();
    return const KizukiTemplateState.loading();
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
