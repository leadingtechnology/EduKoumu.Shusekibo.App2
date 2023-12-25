import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:kyoumutechou/feature/awareness/model/awareness_code_model.dart';
import 'package:kyoumutechou/feature/awareness/repsitory/awareness_code_repository.dart';
import 'package:kyoumutechou/feature/common/state/api_state.dart';

final awarenessCodeListProvider = 
StateNotifierProvider<AwarenessCodeListProvider, ApiState>((ref) {
  return AwarenessCodeListProvider(ref);
});

final awarenessCodeProvider = StateProvider<AwarenessCodeModel>(
  (ref) => const AwarenessCodeModel(),
);

class AwarenessCodeListProvider extends StateNotifier<ApiState> {
  AwarenessCodeListProvider(this.ref)
      : super(const ApiState.loading()) {
    _init();
  }

  final Ref ref;

  late final AwarenessCodeRepository _repository = 
    ref.read(awarenessCodeRepositoryProvider);

  Future<void> _init() async { await _fetch(); }

  Future<void> _fetch() async {
    final response = await _repository.fetch();
    if (mounted) {
      state = response;
    }
  }
}
