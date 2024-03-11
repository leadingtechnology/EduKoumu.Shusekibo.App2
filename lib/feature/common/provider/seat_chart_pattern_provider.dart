
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kyoumutechou/feature/attendance/provider/attendance_meibo_provider.dart';
import 'package:kyoumutechou/feature/attendance/provider/attendance_timed_meibo_provider.dart';
import 'package:kyoumutechou/feature/awareness/provider/awareness_meibo_provider.dart';
import 'package:kyoumutechou/feature/common/state/api_state.dart';
import 'package:kyoumutechou/feature/health/provider/health_meibo_provider.dart';
import 'package:kyoumutechou/feature/seat/model/seat_setting_model.dart';
import 'package:kyoumutechou/feature/seat/provider/seat_setting_provider.dart';

final seatSettingPatternProvider =
    StateProvider<SeatSettingModel>((ref) => const SeatSettingModel());

final seatSettingHealthProvider = Provider.autoDispose<AsyncValue<bool>>((ref) {
  final state1 = ref.watch(healthMeiboListProvider);
  final state2 = ref.watch(seatSettingListProvider);

  //　成功
  if (state1 == const ApiState.loaded() && state2 == const ApiState.loaded()) {
    ref.read(seatSettingListProvider.notifier).setSeatSettingValue();
    return const AsyncData(true); 
  }

  //エラーが発生しました場合
  else if (state1 != const ApiState.loaded() &&
          state1 != const ApiState.loading() ||
          state2 != const ApiState.loaded() && 
          state2 != const ApiState.loading()
  ) {
    return AsyncError(
      Exception('データの読取エラーが発生しました。'),
      StackTrace.empty,
    );
  }

  // ロード中
  return const AsyncLoading();
});

final seatSettingAttendanceProvider = Provider.autoDispose<AsyncValue<bool>>((ref) {
  final state1 = ref.watch(attendanceMeiboListProvider);
  final state2 = ref.watch(seatSettingListProvider);

  //　成功
  if (state1 == const ApiState.loaded() && state2 == const ApiState.loaded()) {
    return const AsyncData(true);
  }

  //エラーが発生しました場合
  else if (state1 != const ApiState.loaded() &&
          state1 != const ApiState.loading() ||
      state2 != const ApiState.loaded() && state2 != const ApiState.loading()) {
    return AsyncError(
      Exception('データの読取エラーが発生しました。'),
      StackTrace.empty,
    );
  }

  // ロード中
  return const AsyncLoading();
});

final seatSettingTimedProvider = Provider.autoDispose<AsyncValue<bool>>((ref) {
  final state1 = ref.watch(attendanceTimedMeiboListProvider);
  final state2 = ref.watch(seatSettingListProvider);

  //　成功
  if (state1 == const ApiState.loaded() && state2 == const ApiState.loaded()) {
    return const AsyncData(true);
  }

  //エラーが発生しました場合
  else if (state1 != const ApiState.loaded() &&
          state1 != const ApiState.loading() ||
      state2 != const ApiState.loaded() && state2 != const ApiState.loading()) {
    return AsyncError(
      Exception('データの読取エラーが発生しました。'),
      StackTrace.empty,
    );
  }

  // ロード中
  return const AsyncLoading();
});

final seatSettingAwarenessProvider = Provider.autoDispose<AsyncValue<bool>>((ref) {
  final state1 = ref.watch(awarenessMeiboListProvider);
  final state2 = ref.watch(seatSettingListProvider);

  //　成功
  if (state1 == const ApiState.loaded() && state2 == const ApiState.loaded()) {
    return const AsyncData(true);
  }

  //エラーが発生しました場合
  else if (state1 != const ApiState.loaded() &&
          state1 != const ApiState.loading() ||
      state2 != const ApiState.loaded() && state2 != const ApiState.loading()) {
    return AsyncError(
      Exception('One or both states have an error'),
      StackTrace.empty,
    );
  }

  // ロード中
  return const AsyncLoading();
});




// final seatSettingPatternListProvider = StateNotifierProvider<
//     SeatSettingPatternListNotifier, ApiState>((ref) {
//   final filter = ref.watch(filterProvider);

//   return SeatSettingPatternListNotifier(ref: ref, filter: filter);
// });

// class SeatSettingPatternListNotifier
//     extends StateNotifier<ApiState> {
//   SeatSettingPatternListNotifier({
//     required this.ref,
//     this.filter = const FilterModel(),
//   }) : super(const ApiState.loading()){
//     init();
//   }
  
//   final Ref ref;
//   final FilterModel filter;

//   late final _settingRep = ref.read(seatSettingRepositoryProvider);
//   late final _seatChartRep = ref.read(seatChartRepositoryProvider); 
//   final box = Boxes.getSeatSetting();

//   void init() {
//     fetch();
//   }

//   Future<void> fetch() async {
//     final tarDate = filter.targetDate ?? DateTime.now();

//     final classId = ref.read(filterProvider).classId ?? 0;
//     if (classId == 0) {
//       return;
//     } 
    
//     final response = await _settingRep.fetch(classId);

//     var settings = response.when(
//       loading: () => <SeatSettingModel>[],
//       error: (error) => <SeatSettingModel>[],
//       loaded: () => box.values.toList(),
//     );

//     try{
//       settings
//         ..removeWhere(
//           (e) =>
//               e.startDate!.isAfter(tarDate) &&
//               e.endDate!.isBefore(tarDate),
//         )
//         ..sort((a, b) => a.startDate!.compareTo(b.startDate!));
//     }catch(e) {
//       settings = [];
//     }

//     if (mounted) {
//       state = response;
//     }
//   }

//   Future<void> getSettingDetail() async {
//     final setting = ref.watch(seatSettingPatternProvider);

//     if (setting.id == null || setting.id == 0) {
//       return;
//     }

//     if (setting.id! > 0) {
//       await _seatChartRep.fetch(setting.id!);
//     }
//   }
// }
