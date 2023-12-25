import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kyoumutechou/feature/attendance/provider/attendance_stamp_provider.dart';
import 'package:kyoumutechou/feature/attendance/repository/attendance_stamp_repository.dart';
import 'package:kyoumutechou/feature/boxes.dart';
import 'package:kyoumutechou/feature/common/model/dantai_model.dart';
import 'package:kyoumutechou/feature/common/repository/dantais_repository.dart';
import 'package:kyoumutechou/feature/common/state/api_state.dart';
import 'package:kyoumutechou/feature/health/provider/health_stamp_provider.dart';
import 'package:kyoumutechou/feature/health/repository/health_stamp_repository.dart';
import 'package:kyoumutechou/shared/http/app_exception.dart';

final dantaiProvider = StateProvider<DantaiModel>((ref) => const DantaiModel());

final dantaisProvider =
    StateNotifierProvider.autoDispose<DantaiNotifier, ApiState>((ref) {
  return DantaiNotifier(ref: ref);
});

class DantaiNotifier extends StateNotifier<ApiState> {
  DantaiNotifier({required this.ref}) : super(const ApiState.loading()) {
    fetch();
  }

  final Ref ref;
  late final _dantai = ref.watch(dantaisRepositoryProvider);
  late final _healthStamp = ref.watch(healthStampRepositoryProvider);
  late final _attendStamp = ref.watch(attendanceStampRepositoryProvider);


  Future<void> init() async {
    state = const ApiState.loading();
    await fetch();
  }

  Future<void> fetch() async {
    try {
      // 100) （1回目）並列処理でデータを取得する。
      final responses1 = await Future.wait([
        // 団体一覧の取得
        _dantai.fetch(),

        // 健康観察スタンプの取得
        _healthStamp.fetch(),

        // 出欠スタンプの取得
        _attendStamp.fetch(),

      ]);

      var isError = false;
      var isLoading = false;
      var errorMessage = '';

      for (final response in responses1) {
        response.when(
          error: (e) {
            isError = true;
            errorMessage = '$errorMessage {e};';
          },
          loading: () {
            isLoading = true;
          },
          loaded: () {},
        );
      }

      if (isError || isLoading) {
        state = const ApiState.error(
          AppException.errorWithMessage('Error occurred'),
        );
      }

      // 健康観察スタンプの初期値を設定する。
      ref.read(healthStampProvider.notifier).state =
          Boxes.getRegistHealthStamp().values.first;

      // 出欠スタンプの初期値を設定する。
      ref.read(attendanceStampProvider.notifier).state =
          Boxes.getRegistAttendanceStamp().values.first;
      
      // 団体初期値を設定する。
      setDantai();

      state = const ApiState.loaded();
    } catch (error) {
      state = ApiState.error(AppException.errorWithMessage('$error'));
    }
  }

  DantaiModel setDantai() {
    // 120) ログイン時の団体IDにより、団体モデルを取得する。
    var dantai = const DantaiModel();
    try{
      dantai = Boxes.getDantais().values.where(
        (e) => '${e.id}' == Boxes.getBox().get('dantaiId'),
      ).first;
    }catch(e) {
      dantai = Boxes.getDantais().values.first;
    }
   
    // 団体ドローンダウンの初期値を設定する。
    ref.read(dantaiProvider.notifier).state = dantai;

    return dantai;
  }

}
