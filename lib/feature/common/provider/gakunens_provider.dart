import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kyoumutechou/feature/boxes.dart';
import 'package:kyoumutechou/feature/common/model/dantai_model.dart';
import 'package:kyoumutechou/feature/common/model/gakunen_model.dart';
import 'package:kyoumutechou/feature/common/provider/dantais_provider.dart';
import 'package:kyoumutechou/feature/common/repository/gakunens_repository.dart';
import 'package:kyoumutechou/feature/common/state/api_state.dart';

final gakunenProvider = StateProvider<GakunenModel>(
  (ref) => const GakunenModel(),
);

final gakunensProvider = 
StateNotifierProvider<GakunenNotifier, ApiState>((ref) {
  final dantai = ref.watch(dantaiProvider);

  return GakunenNotifier(
    ref: ref, 
    dantai: dantai,
  );
});

class GakunenNotifier extends StateNotifier<ApiState> {
  GakunenNotifier({
    required this.ref, 
    required this.dantai,
  }) : super(const ApiState.loading()) {
    _fetch();
  }

  final Ref ref;
  final DantaiModel dantai;

  final box = Boxes.getGakunens();
  late final GakunensRepository _rep = ref.watch(gakunensRepositoryProvider);

  Future<void> init() async {
    state = const ApiState.loading();
    await _fetch();
  }

  Future<void> _fetch() async {
    // データを取得する
    final response = await _rep.fetch('${dantai.organizationKbn}' );

    setDefaultValue();
    
    if (mounted) {
      state = response;
    }
  }

  void setDefaultValue(){
    // 初期値の設定
    final keys = box.keys.toList().where(
          (e) => e.toString().startsWith('${dantai.organizationKbn}-'),
        ).toList(); 
    
    // ignore: cascade_invocations    
    keys.sort((a, b) => a.toString().compareTo(b.toString()),);

    if(keys.isNotEmpty){
      try {
        final oldGakunen = ref.read(gakunenProvider);
        
        if (!keys.contains('${dantai.organizationKbn}-${oldGakunen.id}'))
        {
          final gakunen = box.get(keys.first)!;

          if (gakunen.code != oldGakunen.code) {
            ref.read(gakunenProvider.notifier).state = gakunen;
          }
        }
        // ignore: empty_catches
      } catch (e) {}
    }
  }
}
