import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kyoumutechou/feature/attendance/model/attendance_meibo_model.dart';
import 'package:kyoumutechou/feature/common/provider/common_provider.dart';
import 'package:kyoumutechou/feature/common/state/api_state.dart';
import 'package:kyoumutechou/feature/seat/model/seat_chart_model.dart';
import 'package:kyoumutechou/feature/seat/repository/seat_chart_repository.dart';
import 'package:kyoumutechou/feature/seat/widget/seat_chart_seito_widget.dart';

// 一覧表示 or 座席表表示
final seatChartPageTypeProvider = StateProvider<PageType>((ref) {
  return PageType.list; // 初始值
});

// 座席表設定ID
final seatSettingIdProvider = StateProvider<int>((ref) {return 0;});
// 展開フラグ
final isSeatExpandedProvider = StateProvider<bool>((ref) {return true;});

// フォーカスON座席
final seatChartListFocusProvider = StateProvider<int>((ref) {return -1;});
// フォーカスON設定値
final seatChartStackFocusProvider = StateProvider<int>((ref) {return 1;});
// 生徒リスト
final scMeiboListProvider = StateProvider<List<AttendanceMeiboModel>>(
  (ref) {return [];},
);
// 座席表リスト
final scMeiboStackProvider = StateProvider<List<SeatChartSeitoWidget>>(
  (ref) {return [];},
);



final seatChartListProvider =
    StateNotifierProvider<SeatChartListProvider, ApiState>((ref) {
  
  final seatSettingId = ref.watch(seatSettingIdProvider);

  return SeatChartListProvider(ref, seatSettingId);
});

final seatChartProvider =
    StateProvider<SeatChartModel>((ref) => const SeatChartModel());

class SeatChartListProvider extends StateNotifier<ApiState> {
  SeatChartListProvider(this._ref, this.seatSettingId) : super(const ApiState.loading()) {
    _init();
  }

  final Ref _ref;
  final int seatSettingId;
  late final _repository = _ref.read(seatChartRepositoryProvider);

  Future<void> _init() async {
    await _fetch(seatSettingId);
  }

  Future<void> _fetch(int seatSettingId) async {
    final response = await _repository.fetch(seatSettingId);
    if (mounted) {
      state = response;
    }
  }
}
