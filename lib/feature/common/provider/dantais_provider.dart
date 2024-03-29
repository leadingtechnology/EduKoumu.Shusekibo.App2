import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kyoumutechou/feature/attendance/model/attendance_reason_model.dart';
import 'package:kyoumutechou/feature/attendance/provider/attendance_provider.dart';
import 'package:kyoumutechou/feature/attendance/provider/attendance_reason_provider.dart';
import 'package:kyoumutechou/feature/attendance/provider/attendance_stamp_provider.dart';
import 'package:kyoumutechou/feature/attendance/repository/attendance_stamp_repository.dart';
import 'package:kyoumutechou/feature/awareness/repsitory/awareness_code_repository.dart';
import 'package:kyoumutechou/feature/boxes.dart';
import 'package:kyoumutechou/feature/common/model/dantai_model.dart';
import 'package:kyoumutechou/feature/common/provider/common_provider.dart';
import 'package:kyoumutechou/feature/common/repository/dantais_repository.dart';
import 'package:kyoumutechou/feature/common/state/api_state.dart';
import 'package:kyoumutechou/feature/health/model/health_reason_model.dart';
import 'package:kyoumutechou/feature/health/provider/health_provider.dart';
import 'package:kyoumutechou/feature/health/provider/health_reason_provider.dart';
import 'package:kyoumutechou/feature/health/provider/health_stamp_provider.dart';
import 'package:kyoumutechou/feature/health/repository/health_reason_repository.dart';
import 'package:kyoumutechou/feature/health/repository/health_stamp_repository.dart';
import 'package:kyoumutechou/feature/home/provider/home_provider.dart';
import 'package:kyoumutechou/feature/linkage/provider/contact_linkage_provider.dart';
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
  late final _dantai = ref.read(dantaisRepositoryProvider);
  late final _healthStamp = ref.read(healthStampRepositoryProvider);
  late final _attendStamp = ref.read(attendanceStampRepositoryProvider);
  late final _healthReason = ref.read(healthReasonRepositoryProvider);
  late final _burun = ref.read(awarenessCodeRepositoryProvider);

  Future<void> init() async {
    state = const ApiState.loading();
    await fetch();
  }

  Future<void> fetch() async {
    // トークンがない場合は、ログイン画面に遷移する。
    if (Boxes.getBox().get('token') == null || Boxes.getBox().get('token') == '')
    {
      return;
    }

    try {
      // 100) （1回目）並列処理でデータを取得する。
      final responses1 = await Future.wait([
        // 団体一覧の取得
        _dantai.fetch(),

        // 健康観察スタンプの取得
        _healthStamp.fetch(),

        // 出欠スタンプの取得
        _attendStamp.fetch(),

        // 健康観察理由の取得
        _healthReason.fetch('100', '101'),

        // 分類コード情報を取得する。
        _burun.fetch(),

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
        if (mounted) {
          state = const ApiState.error(
            AppException.errorWithMessage('Error occurred'),
          );
        }
      }

      // 健康観察スタンプの初期値を設定する。
      ref.read(healthStampProvider.notifier).state =
          Boxes.getRegistHealthStamp().values.first;

      // 出欠スタンプの初期値を設定する。
      ref.read(attendanceStampProvider.notifier).state =
          Boxes.getRegistAttendanceStamp().values.first;
      
      // 団体初期値を設定する。
      setDantai();

      // env初期値の処理
      setEnvValue();

      // 各画面初期値
      setProviderInitValue();

      if (mounted) {
        state = const ApiState.loaded();
      }
    } catch (error) {
      if (mounted) {
        state = ApiState.error(AppException.errorWithMessage('$error'));
      }
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
      final dantaiList = Boxes.getDantais().values.toList()
      ..sort((a, b) =>
          '${a.organizationBunrui}${a.organizationKbn}${a.code}'.compareTo(
              '${b.organizationBunrui}${b.organizationKbn}${b.code}',),);
      
      dantai = dantaiList.first;
    }
  
    // 団体ドローンダウンの初期値を設定する。
    ref.read(dantaiProvider.notifier).state = dantai;

    return dantai;
  }

  void setEnvValue() {
    // 1 初期表示時Seat　 Or Listの設定
    final dm = dotenv.env['Display_Mode'];

    ref.read(attendancePageTypeProvider.notifier).state =
        dm == 'seat' ? PageType.seat : PageType.list; 

    ref.read(attendanceTimedPageTypeProvider.notifier).state =
        dm == 'seat' ? PageType.seat : PageType.list;         
    
    ref.read(healthPageTypeProvider.notifier).state =
        dm == 'seat' ? PageType.seat : PageType.list; 
    
    // 保護者初期表示可否設定
    final isCa = dotenv.env['IS_Contact_Allowed'] ?? '';
    ref.read(isContactAllowedProvider.notifier).state = isCa == '1' ;

    // 性別初期表示可否設定
    final strGender = dotenv.env['Display_Gender'];
    final isGender = strGender == '1' ;

    // 保護者連絡からの画面遷移先 (health / attendance);
    final strNavigator = dotenv.env['Contact_Navigation'];
    if (strNavigator == 'health'){
      ref.read(contactNavigatorMenu.notifier).state = Menu.health;
    }
    if (strNavigator == 'attendance'){
      ref.read(contactNavigatorMenu.notifier).state = Menu.attendance;
    }

    ref.read(isGenderProvider.notifier).state = isGender;
  }

  void setProviderInitValue(){

    // 健康観察画面の初期値を設定する健康
    ref.read(healthStampProvider.notifier).state =
        Boxes.getRegistHealthStamp().values.first;
    
    ref.read(healthReason1Provider.notifier).state =
        const HealthReasonModel();
    ref.read(healthReason2Provider.notifier).state =
        const HealthReasonModel();

    // 出欠画面の初期値を設定する
    ref.read(attendanceStampProvider.notifier).state =
        Boxes.getRegistAttendanceStamp().values.first;

    ref.read(attendanceReason1Provider.notifier).state =
        const AttendanceReasonModel();
    ref.read(attendanceReason2Provider.notifier).state =
        const AttendanceReasonModel();
    
    ref.read(buttonEnableProvider.notifier).state = false;

    final fiscalYear = DateUtil.calculateFiscalYear(DateTime.now());
    ref.read(sysBeginDate.notifier).state = fiscalYear.item1;
    ref.read(sysEndDate.notifier).state = fiscalYear.item2;

    // //出欠時限画面の初期値を設定する
    // ref.read(attendanceTimedStampProvider.notifier).state =
    //     const AttendanceTimedStampModel();
    // ref.read(attendanceTimedReason1Provider.notifier).state =
    //     const AttendanceTimedReasonModel();
    // ref.read(attendanceTimedReason2Provider.notifier).state = 
    //     const AttendanceTimedReasonModel();

  }
}
