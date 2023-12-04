import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kyoumutechou/feature/boxes.dart';
import 'package:kyoumutechou/feature/common/state/api_state.dart';
import 'package:kyoumutechou/feature/health/model/health_reason_model.dart';
import 'package:kyoumutechou/feature/health/provider/health_stamp_provider.dart';
import 'package:kyoumutechou/feature/health/repository/health_reason_repository.dart';

final healthReasonListProvider = 
  StateNotifierProvider<HealthReasonListProvider, ApiState>((ref) {
    
  final stamp = ref.watch(healthStampProvider);
  
  return HealthReasonListProvider(ref, stamp.jokyoCd??'');
});

final healthReason1Provider = StateProvider<HealthReasonModel>(
  (ref) => const HealthReasonModel(),
);
final healthReason2Provider = StateProvider<HealthReasonModel>(
  (ref) => const HealthReasonModel()
);

class HealthReasonListProvider extends StateNotifier<ApiState> {
  HealthReasonListProvider(this.ref, this._jokyoCd) : 
  super(const ApiState.loading()) {
    _init();
  }

  final Ref ref;
  final String _jokyoCd;
  late final _repository = ref.read(healthReasonRepositoryProvider);

  Future<void> _init() async { await _fetch(); }

  Future<void> _fetch() async {

    final response = await _repository.fetch(_jokyoCd); // _jokyoCd

    var keys = Boxes.getHealthReason1().keys.toList().where(
      (element) => element.toString().startsWith(_jokyoCd),
    ).toList(); 
    keys.sort((a, b) => a.toString().compareTo(b.toString()),);

    if (keys.isNotEmpty) {
      ref.read(healthReason1Provider.notifier).state = 
      Boxes.getHealthReason1().get(keys[0])!;
    } else {
      ref.read(healthReason1Provider.notifier).state = 
      const HealthReasonModel();
    }

    keys = Boxes.getHealthReason2().keys.toList().where(
      (element) => element.toString().startsWith(_jokyoCd),
    ).toList(); 
    
    if (keys.isNotEmpty) {
      keys.sort((a, b) => a.toString().compareTo(b.toString()),);
      ref.read(healthReason2Provider.notifier).state =
          Boxes.getHealthReason2().get(keys[0])!;
    } else {
      ref.read(healthReason2Provider.notifier).state = 
      const HealthReasonModel();
    } 

    if (mounted) {
      state = response;
    }
  }
}
