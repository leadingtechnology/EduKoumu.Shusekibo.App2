import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kyoumutechou/feature/attendance/model/attendance_meibo_model.dart';
import 'package:kyoumutechou/feature/attendance/repository/attendance_meibo_repository.dart';
import 'package:kyoumutechou/feature/boxes.dart';
import 'package:kyoumutechou/feature/common/model/filter_model.dart';
import 'package:kyoumutechou/feature/common/provider/common_provider.dart';
import 'package:kyoumutechou/feature/common/state/api_state.dart';
import 'package:kyoumutechou/feature/seat/model/seat_chart_model.dart';
import 'package:kyoumutechou/feature/seat/repository/seat_chart_repository.dart';
import 'package:kyoumutechou/feature/seat/widget/seat_chart_seito_for_stack_widget.dart';

// 一覧表示 or 座席表表示
final seatChartPageTypeProvider = StateProvider<PageType>((ref) {
  return PageType.list; // 初始值
});

// 座席表設定ID(一覧画面から登録したID)
final seatSettingIdProvider = StateProvider<int>((ref) {return 0;});
// 展開フラグ
final isSeatExpandedProvider = StateProvider<bool>((ref) {return true;});
// 教卓フラグ
final lecternPositionProvider = StateProvider<LecternPosition>((ref) {
  return LecternPosition.top;
});

// フォーカスON座席
final seatChartListFocusProvider = StateProvider<int>((ref) {return -1;});
// フォーカスON設定値
final seatChartStackFocusProvider = StateProvider<int>((ref) {return 1;});

// 選択用生徒リスト
final scMeibosListProvider = StateProvider<List<AttendanceMeiboModel>>(
  (ref) {return [];},
);
// 座席表リスト
final scMeibosStackProvider = StateProvider<List<SeatChartSeitoForStackWidget>>(
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
  late final _seatSettingRep = _ref.read(seatChartRepositoryProvider);
  late final _meiboRep = _ref.read(attendanceMeiboRepositoryProvider);

  Future<void> _init() async {
    await _fetch(seatSettingId);
  }

  Future<void> _fetch(int seatSettingId) async {
    final response = await _seatSettingRep.fetch(seatSettingId);
    if (mounted) {
      state = response;
    }
  }

  Future<List<AttendanceMeiboModel>> getMeibos(
    FilterModel filter,
    DateTime targetDate,
  ) async {
    final response = await _meiboRep.fetch(
      filter,
      0,
      targetDate,
    );

    var meibos = <AttendanceMeiboModel>[];

    response.when(
      loaded: () {
        meibos = Boxes.getAttendanceMeibo().values.toList();
      },
      error: (e) {},
      loading: () {},
    );

    return meibos;
  }

}
