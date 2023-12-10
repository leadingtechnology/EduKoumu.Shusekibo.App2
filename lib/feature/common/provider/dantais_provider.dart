import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kyoumutechou/feature/attendance/provider/attendance_stamp_provider.dart';
import 'package:kyoumutechou/feature/attendance/repository/attendance_stamp_repository.dart';
import 'package:kyoumutechou/feature/boxes.dart';
import 'package:kyoumutechou/feature/common/model/dantai_model.dart';
import 'package:kyoumutechou/feature/common/model/gakunen_model.dart';
import 'package:kyoumutechou/feature/common/model/shozoku_model.dart';
import 'package:kyoumutechou/feature/common/model/tannin_model.dart';
import 'package:kyoumutechou/feature/common/provider/filter_provider.dart';
import 'package:kyoumutechou/feature/common/provider/gakunens_provider.dart';
import 'package:kyoumutechou/feature/common/provider/shozokus_provider.dart';
import 'package:kyoumutechou/feature/common/provider/tannin_provider.dart';
import 'package:kyoumutechou/feature/common/provider/timeds_provider.dart';
import 'package:kyoumutechou/feature/common/repository/dantais_repository.dart';
import 'package:kyoumutechou/feature/common/repository/gakunens_repository.dart';
import 'package:kyoumutechou/feature/common/repository/shozokus_repository.dart';
import 'package:kyoumutechou/feature/common/repository/tannin_repository.dart';
import 'package:kyoumutechou/feature/common/repository/timeds_repository.dart';
import 'package:kyoumutechou/feature/common/state/api_state.dart';
import 'package:kyoumutechou/feature/health/provider/health_stamp_provider.dart';
import 'package:kyoumutechou/feature/health/repository/health_stamp_repository.dart';
import 'package:kyoumutechou/shared/http/app_exception.dart';
import 'package:kyoumutechou/shared/util/date_util.dart';

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
  
  // 団体IDを取得した場合
  late final _tannin = ref.watch(tanninRepositoryProvider);
  late final _gakunen = ref.watch(gakunensRepositoryProvider);
  late final _shozoku = ref.watch(shozokusRepositoryProvider);

  late final _timed = ref.watch(timedsRepositoryProvider);

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
          loading: () {isLoading = true;},
          loaded: () {},
        );
      }

      if (isError || isLoading) {
        state = const ApiState.error(
          AppException.errorWithMessage('Error occurred'),
        );

        // トーストを表示、ログアウトする。
        // await ref.read(authNotifierProvider.notifier).logout();
      }

      // 団体の初期値を設定する。// Boxes.getBox().get('dantaiId');
      // 110) ログイン時の団体IDを取得する。
      var dantaiId = 0;
      try {
        dantaiId = int.parse(Boxes.getBox().get('dantaiId') ?? '0');
      } catch (e) {
        dantaiId = 0;
      }
      
      // 120) ログイン時の団体IDにより、団体モデルを取得する。
      var dantai = const DantaiModel();
      final dantaiList = Boxes.getDantais().values.toList();
      if (dantaiList.isNotEmpty) {

        try {
          dantai = dantaiList.where((e) => e.id == dantaiId,).first;
        } catch (e) {
          dantai = dantaiList.first;
        }
      }

      // 団体ドローンダウンの初期値を設定する。
      ref.read(dantaiProvider.notifier).state = dantai;

      // 健康観察スタンプの初期値を設定する。
      ref.read(healthStampProvider.notifier).state =
          Boxes.getRegistHealthStamp().values.first;

      // 出欠スタンプの初期値を設定する。
      ref.read(attendanceStampProvider.notifier).state =
          Boxes.getRegistAttendanceStamp().values.first;

      // 200) （２回目）並列処理でデータを取得する。（学年、担任情報）
      final responses2 = await Future.wait([
        // 担任情報を取得する。
        _tannin.fetch(dantaiId, DateUtil.getStringDate(DateTime.now())),

        // 学年情報を取得する。
        _gakunen.fetch('${dantai.organizationKbn}'),

        //　所属情報を取得す情報
        _shozoku.fetch(dantaiId),

        // 時限情報を取得する。
      ]);

      for (final response in responses2) {
        response.when(
          error: (e) {
            isError = true;
            errorMessage = '$errorMessage {e};';
          },
          loading: () { isLoading = true; },
          loaded: () {},
        );
      }

      if (isError || isLoading) {
        state = const ApiState.error(
          AppException.errorWithMessage('Error occurred'),
        );

        // トーストを表示、ログアウトする。
        // await ref.read(authNotifierProvider.notifier).logout();
      }

      // 本日担任情報の取得
      final strDate = DateUtil.getStringDate(DateTime.now());

      final key = Boxes.getTannin().keys.toList().where(
            (element) =>
                element.toString().startsWith('$dantaiId-$strDate'),
          );
      
      TanninModel? tannin;
      try{
        tannin = Boxes.getTannin().get(key.first)??const TanninModel();
      }catch(e){
        tannin = null;
      } 

      if (tannin != null ) {
        ref.read(tanninProvider.notifier).state = tannin;

        // 学年初期値の設定
        GakunenModel? gakunen;
        try{
          gakunen = Boxes.getGakunens().values.where(
                (e) => e.gakunenCode == tannin?.gakunenCode,
              )
              .first;
          ref.read(gakunenProvider.notifier).state = gakunen;
                }catch(e){
          gakunen = null;
        }
        
        // 所属初期値の設定
        ShozokuModel? shozoku;
        try{
          shozoku = Boxes.getShozokus().values.where(
                (e) => e.id == tannin?.shozokuId,
              )
              .first;
          ref.read(shozokuProvider.notifier).state = shozoku;
                }catch(e){
          shozoku = null;
        }

        if (gakunen != null && shozoku != null){
          
          await _timed.fetch(shozoku.id ??0 , strDate);
          ref.read(timedsProvider.notifier).setDefaultValue();
          
          // フィルターの初期値を設定する。
          ref.read(filterProvider.notifier).init();
          ref.read(filterProvider.notifier).update(targetDate: DateTime.now());
        }
      }


      

      state = const ApiState.loaded();
    } catch (error) {
      state = ApiState.error(AppException.errorWithMessage('$error'));
    }
  }

  Future<void> reset() async {
    state = const ApiState.loading();
  }
}
