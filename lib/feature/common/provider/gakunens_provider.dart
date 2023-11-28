import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kyoumutechou/feature/common/model/gakunen_model.dart';
import 'package:kyoumutechou/feature/common/provider/dantais_provider.dart';
import 'package:kyoumutechou/feature/common/repository/gakunens_repository.dart';

final gakunenProvider =
    StateProvider<GakunenModel>((ref) => const GakunenModel());

final gakunensProvider =
    StateNotifierProvider<GakunenNotifier, List<GakunenModel>>((ref) {
      final dantai = ref.watch(dantaiProvider);

  return GakunenNotifier(ref: ref, dantaiId: dantai.id??0);
});

class GakunenNotifier extends StateNotifier<List<GakunenModel>> {
  GakunenNotifier({required this.ref, required this.dantaiId}) : super([]) {
    _fetchGakunen();
  }

  final Ref ref;
  final int dantaiId;
  late final GakunensRepository _rep = ref.watch(gakunensRepositoryProvider);

  Future<void> _fetchGakunen() async {
    final result = await _rep.fetch();
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
        state = gakunenList;
      },
    );
  }
}
