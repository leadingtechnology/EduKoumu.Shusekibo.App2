import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kyoumutechou/feature/common/model/shozoku_model.dart';
import 'package:kyoumutechou/feature/common/repository/shozokus_repository.dart';

final shozokuProvider =
    StateProvider<ShozokuModel>((ref) => const ShozokuModel());

final shozokusProvider =
    StateNotifierProvider<ShozokuNotifier, List<ShozokuModel>>((ref) {
  return ShozokuNotifier(ref: ref);
});

class ShozokuNotifier extends StateNotifier<List<ShozokuModel>> {
  ShozokuNotifier({required this.ref}) : super([]) {
    _fetchShozoku();
  }

  final Ref ref;
  late final ShozokusRepository _rep = ref.watch(shozokusRepositoryProvider);

  Future<void> _fetchShozoku() async {
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
      loaded: (shozokuList) {
        if (shozokuList.isNotEmpty) {
          ref.read(shozokuProvider.notifier).state = shozokuList.first;
        }
        state = shozokuList;
      },
    );
  }
}
