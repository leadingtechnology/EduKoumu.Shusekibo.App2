import 'dart:async';
import 'dart:developer';
//import 'dart:html' as html;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kyoumutechou/app/app.dart';
import 'package:kyoumutechou/database/adapter/datetime_adapter.dart';
import 'package:kyoumutechou/feature/attendance/model/attendance_meibo_model.dart';
import 'package:kyoumutechou/feature/attendance/model/attendance_reason_model.dart';
import 'package:kyoumutechou/feature/attendance/model/attendance_stamp_model.dart';
import 'package:kyoumutechou/feature/attendance/model/attendance_status_model.dart';
import 'package:kyoumutechou/feature/attendance/model/attendance_timed_meibo_model.dart';
import 'package:kyoumutechou/feature/attendance/model/attendance_timed_status_model.dart';
import 'package:kyoumutechou/feature/awareness/model/awareness_code_model.dart';
import 'package:kyoumutechou/feature/awareness/model/awareness_kizuki_model.dart';
import 'package:kyoumutechou/feature/awareness/model/awareness_meibo_model.dart';
import 'package:kyoumutechou/feature/awareness/model/kizuki_comment_model.dart';
import 'package:kyoumutechou/feature/common/model/dantai_model.dart';
import 'package:kyoumutechou/feature/common/model/gakunen_model.dart';
import 'package:kyoumutechou/feature/common/model/kamoku_model.dart';
import 'package:kyoumutechou/feature/common/model/shozoku_model.dart';
import 'package:kyoumutechou/feature/common/model/tannin_model.dart';
import 'package:kyoumutechou/feature/common/model/tanto_kyoin_model.dart';
import 'package:kyoumutechou/feature/common/model/teacher_model.dart';
import 'package:kyoumutechou/feature/common/model/tenpu_model.dart';
import 'package:kyoumutechou/feature/common/model/timed_model.dart';
import 'package:kyoumutechou/feature/common/model/tokobi_model.dart';
import 'package:kyoumutechou/feature/health/model/health_meibo_model.dart';
import 'package:kyoumutechou/feature/health/model/health_reason_model.dart';
import 'package:kyoumutechou/feature/health/model/health_stamp_model.dart';
import 'package:kyoumutechou/feature/health/model/health_status_model.dart';
import 'package:kyoumutechou/feature/seat/model/seat_chart_model.dart';
import 'package:kyoumutechou/feature/seat/model/seat_setting_model.dart';
import 'package:kyoumutechou/shared/util/logger.dart';
import 'package:kyoumutechou/shared/util/platform_type.dart';

Future<void> start() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  final platformType = detectPlatformType();

  // Hive init
  await Hive.initFlutter();

  // Hive adapter
  Hive
    ..registerAdapter(DateTimeAdapter())
    ..registerAdapter(DantaiModelAdapter())
    ..registerAdapter(GakunenModelAdapter())
    ..registerAdapter(ShozokuModelAdapter())
    ..registerAdapter(TimedModelAdapter())
    ..registerAdapter(KamokuModelAdapter())
    ..registerAdapter(TantoKyoinModelAdapter())
    ..registerAdapter(TeacherModelAdapter())
    ..registerAdapter(TokobiModelAdapter())
    ..registerAdapter(TanninModelAdapter())
    ..registerAdapter(HealthStampModelAdapter())
    ..registerAdapter(HealthStatusModelAdapter())
    ..registerAdapter(HealthReasonModelAdapter())
    ..registerAdapter(AwarenessCodeModelAdapter())
    ..registerAdapter(HealthMeiboModelAdapter())
    ..registerAdapter(AttendanceStampModelAdapter())
    ..registerAdapter(AttendanceReasonModelAdapter())
    ..registerAdapter(AttendanceMeiboModelAdapter())
    ..registerAdapter(AttendanceStatusModelAdapter())
    ..registerAdapter(AttendanceTimedMeiboModelAdapter())
    ..registerAdapter(AttendanceTimedStatusModelAdapter())
    ..registerAdapter(AwarenessMeiboModelAdapter())
    ..registerAdapter(TenpuModelAdapter())
    ..registerAdapter(KizukiCommentModelAdapter())
    ..registerAdapter(AwarenessKizukiModelAdapter())
    ..registerAdapter(SeatSettingModelAdapter())
    ..registerAdapter(SeatChartModelAdapter());

  // トークン
  await Hive.openBox<String>('shusekibo');
  await Hive.box<String>('shusekibo').put('token', '');

  // 団体
  await Hive.openBox<DantaiModel>('Dantai');

  // 学年
  final gakunenBox = await Hive.openBox<GakunenModel>('Gakunen');
  await gakunenBox.clear();

  // クラス
  final shozokuBox = await Hive.openBox<ShozokuModel>('Shozoku');
  await shozokuBox.clear();

  // 時限
  final timedBox = await Hive.openBox<TimedModel>('Timed');
  await timedBox.clear();

  // 登校日
  final tokobiBox = await Hive.openBox<TokobiModel>('Tokobi');
  await tokobiBox.clear();

  // 担任
  final tanninBox = await Hive.openBox<TanninModel>('Tannin');
  await tanninBox.clear();

  // 科目
  final kamokuBox = await Hive.openBox<KamokuModel>('Kamoku');
  await kamokuBox.clear();

  // 担当教員
  final tantoKyoinBox = await Hive.openBox<TantoKyoinModel>('TantoKyoin');
  await tantoKyoinBox.clear();

  // 教職員
  final teacherBox = await Hive.openBox<TeacherModel>('Teacher');
  await teacherBox.clear();
  

  // 健康観察スタンプ
  await Hive.openBox<HealthStampModel>('RegistHealthStamp');
  await Hive.openBox<HealthStampModel>('UnregistHealthStamp');

  // 健康観察登録
  await Hive.openBox<HealthReasonModel>('HealthReason1');
  await Hive.openBox<HealthReasonModel>('HealthReason2');

  // 気づき分類
  await Hive.openBox<AwarenessCodeModel>('bunrui');

  //
  final hmBox = await Hive.openBox<HealthMeiboModel>('HealthMeibo');
  await hmBox.clear();
  final hmBox1 = await Hive.openBox<HealthMeiboModel>('HealthMeibo1');
  await hmBox1.clear();
  final hmBox2 = await Hive.openBox<HealthMeiboModel>('HealthMeibo2');
  await hmBox2.clear();

  // 出欠スタンプ
  await Hive.openBox<AttendanceStampModel>('RegistAttendanceStamp');
  await Hive.openBox<AttendanceStampModel>('UnregistAttendanceStamp');

  // 出欠理由
  await Hive.openBox<AttendanceReasonModel>('AttendanceReason1');
  await Hive.openBox<AttendanceReasonModel>('AttendanceReason2');

  // 出欠名簿(日)
  final amBox = await Hive.openBox<AttendanceMeiboModel>('AttendanceMeibo');
  await amBox.clear();
  final amBox1 = await Hive.openBox<AttendanceMeiboModel>('AttendanceMeibo1');
  await amBox1.clear();
  final amBox2 = await Hive.openBox<AttendanceMeiboModel>('AttendanceMeibo2');
  await amBox2.clear();

  // 出欠名簿(時限)

  final atmBox =
      await Hive.openBox<AttendanceTimedMeiboModel>('AttendanceTimedMeibo');
  await atmBox.clear();
  final atmBox1 =
      await Hive.openBox<AttendanceTimedMeiboModel>('AttendanceTimedMeibo1');
  await atmBox1.clear();
  final atmBox2 =
      await Hive.openBox<AttendanceTimedMeiboModel>('AttendanceTimedMeibo2');
  await atmBox2.clear();

  // 気づき
  final awBox = await Hive.openBox<AwarenessMeiboModel>('AwarenessMeibo');
  await awBox.clear();

  final akBox = await Hive.openBox<AwarenessKizukiModel>('AwarenessKizuki');
  await akBox.clear();

  // 画像添付
  final tenpuBox = await Hive.openBox<TenpuModel>('Tenpu');
  await tenpuBox.clear();

  final urlBox = await Hive.openBox<String>('ImageUrl');
  await urlBox.clear();

  // 設定
  final ssBox = await Hive.openBox<SeatSettingModel>('SeatSetting');
  await ssBox.clear();

  // 座席表
  final scBox = await Hive.openBox<SeatChartModel>('SeatChart');
  await scBox.clear();

  // Hive アダプター登録
  //setBrowserTabTitle('デジタル教務手帳');
  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('ja')],
      path: 'assets/lang',
      fallbackLocale: const Locale('ja'),
      child: ProviderScope(
        overrides: [
          platformTypeProvider.overrideWithValue(platformType),
        ],
        observers: [
          Logger(),
        ],
        child: const App(),
      ),
    ),
  );
}

// void setBrowserTabTitle(String title) {
//   html.document.title = title;
// }
