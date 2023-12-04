import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kyoumutechou/feature/boxes.dart';
import 'package:kyoumutechou/feature/common/state/api_state.dart';

import 'package:kyoumutechou/feature/health/model/health_stamp_model.dart';
import 'package:kyoumutechou/feature/health/repository/health_stamp_repository.dart';

final healthStampListProvider = 
    StateNotifierProvider<HealthStampListProvider, ApiState>((ref) {

  return HealthStampListProvider(ref);
});

final healthStampProvider = StateProvider<HealthStampModel>(
  (ref) => const HealthStampModel(),
);

class HealthStampListProvider extends StateNotifier<ApiState> {
  HealthStampListProvider(this.ref)
      : super(const ApiState.loading()) {
    _init();
  }

  final Ref ref;

  late final _repository = ref.read(healthStampRepositoryProvider);

  Future<void> _init() async { await _fetch(); }

  Future<void> _fetch() async {
    
    if (Boxes.getRegistHealthStampBox().values.isNotEmpty) {
      state = const ApiState.loaded();
      return;
    }
    
    final response = await _repository.fetch();
    if (mounted) {
      state = response;
    }
  }
}
