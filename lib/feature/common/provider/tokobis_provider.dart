import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kyoumutechou/feature/common/model/tokobi_model.dart';
import 'package:kyoumutechou/feature/common/repository/tokobis_repository.dart';

final tokobiProvider = StateProvider<TokobiModel>((ref) => const TokobiModel());

final tokobisProvider =
    StateNotifierProvider<TokobiNotifier, List<TokobiModel>>((ref) {
  return TokobiNotifier(ref: ref);
});

class TokobiNotifier extends StateNotifier<List<TokobiModel>> {
  TokobiNotifier({required this.ref}) : super([]) {
    _fetchTokobi();
  }

  final Ref ref;
  late final TokobisRepository _rep = ref.watch(tokobisRepositoryProvider);

  Future<void> _fetchTokobi() async {
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
      loaded: (tokobiList) {
        if (tokobiList.isNotEmpty) {
          ref.read(tokobiProvider.notifier).state = tokobiList.first;
        }
        state = tokobiList;
      },
    );
  }
}
