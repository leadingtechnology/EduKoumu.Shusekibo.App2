import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:kyoumutechou/feature/awareness/repsitory/awareness_kizuki_repository.dart';
import 'package:kyoumutechou/feature/common/state/api_state.dart';

final awarenessPhotoListProvider = 
StateNotifierProvider<AwarenessPhotoListNotifier, ApiState>((ref) {
  final id = ref.watch(awarenessIdProvider);

  return AwarenessPhotoListNotifier(ref, id);
});

final awarenessIdProvider = StateProvider<int>((ref) => 0);

class AwarenessPhotoListNotifier extends StateNotifier<ApiState> {
  AwarenessPhotoListNotifier(
    this.ref, 
    this.id,
  ) : super(const ApiState.loading()) {
    _init();
  }

  final Ref ref;
  final int id;
  late final _repository = ref.read(awarenessKizukiRepositoryProvider);

  Future<void> _init() async {
    await get(id);
  }

  Future<void> get(int kizukiId) async {
    final response = await _repository.get(kizukiId);
    if (mounted) {
      state = response;
    }
  }
}
