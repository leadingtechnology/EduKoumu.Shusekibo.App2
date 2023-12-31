import 'dart:async';
import 'dart:developer';

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
import 'package:kyoumutechou/feature/boxes.dart';
import 'package:kyoumutechou/feature/common/model/dantai_model.dart';
import 'package:kyoumutechou/feature/common/model/gakunen_model.dart';
import 'package:kyoumutechou/feature/common/model/shozoku_model.dart';
import 'package:kyoumutechou/feature/common/model/tannin_model.dart';
import 'package:kyoumutechou/feature/common/model/tenpu_model.dart';
import 'package:kyoumutechou/feature/common/model/timed_model.dart';
import 'package:kyoumutechou/feature/common/model/tokobi_model.dart';
import 'package:kyoumutechou/feature/health/model/health_meibo_model.dart';
import 'package:kyoumutechou/feature/health/model/health_reason_model.dart';
import 'package:kyoumutechou/feature/health/model/health_stamp_model.dart';
import 'package:kyoumutechou/feature/health/model/health_status_model.dart';
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
  Hive.registerAdapter(DateTimeAdapter());

  // トークン
  await Hive.openBox<String>('shusekibo');
  await Hive.box<String>('shusekibo').put('token', '');

  // 団体
  Hive.registerAdapter(DantaiModelAdapter());
  await Hive.openBox<DantaiModel>('Dantai');

  // 学年
  Hive.registerAdapter(GakunenModelAdapter());
  final gakunenBox = await Hive.openBox<GakunenModel>('Gakunen');
  await gakunenBox.clear();

  // クラス
  Hive.registerAdapter(ShozokuModelAdapter());
  final shozokuBox = await Hive.openBox<ShozokuModel>('Shozoku');
  await shozokuBox.clear();

  // 時限
  Hive.registerAdapter(TimedModelAdapter());
  final timedBox = await Hive.openBox<TimedModel>('Timed');
  await timedBox.clear();

  // 登校日
  Hive.registerAdapter(TokobiModelAdapter());
  final tokobiBox = await Hive.openBox<TokobiModel>('Tokobi');
  await tokobiBox.clear();

  // 担任
  Hive.registerAdapter(TanninModelAdapter());
  final tanninBox = await Hive.openBox<TanninModel>('Tannin');
  await tanninBox.clear();

  // 健康観察スタンプ
  Hive.registerAdapter(HealthStampModelAdapter());
  await Hive.openBox<HealthStampModel>('RegistHealthStamp');
  await Hive.openBox<HealthStampModel>('UnregistHealthStamp');

  // 健康観察登録
  Hive..registerAdapter(HealthStatusModelAdapter())
  ..registerAdapter(HealthReasonModelAdapter());
  await Hive.openBox<HealthReasonModel>('HealthReason1');
  await Hive.openBox<HealthReasonModel>('HealthReason2');

  // 気づき分類
  Hive.registerAdapter(AwarenessCodeModelAdapter());
  await Hive.openBox<AwarenessCodeModel>('bunrui');

  //
  Hive.registerAdapter(HealthMeiboModelAdapter());
  final hmBox = await Hive.openBox<HealthMeiboModel>('HealthMeibo');
  await hmBox.clear();
  

  // 出欠スタンプ
  Hive.registerAdapter(AttendanceStampModelAdapter());
  await Hive.openBox<AttendanceStampModel>('RegistAttendanceStamp');
  await Hive.openBox<AttendanceStampModel>('UnregistAttendanceStamp');

  // 出欠理由
  Hive.registerAdapter(AttendanceReasonModelAdapter());
  await Hive.openBox<AttendanceReasonModel>('AttendanceReason1');
  await Hive.openBox<AttendanceReasonModel>('AttendanceReason2');

  // 出欠名簿(日)
  Hive.registerAdapter(AttendanceMeiboModelAdapter());
  final amBox = await Hive.openBox<AttendanceMeiboModel>('AttendanceMeibo');
  await amBox.clear();

  Hive.registerAdapter(AttendanceStatusModelAdapter());
  
  // 出欠名簿(時限)
  
  Hive.registerAdapter(AttendanceTimedMeiboModelAdapter());
  final atmBox = await Hive.openBox<AttendanceTimedMeiboModel>('AttendanceTimedMeibo');
  await atmBox.clear();

  Hive.registerAdapter(AttendanceTimedStatusModelAdapter());
  // 気づき
  Hive.registerAdapter(AwarenessMeiboModelAdapter());
  final awBox = await Hive.openBox<AwarenessMeiboModel>('AwarenessMeibo');
  await awBox.clear(); 

  Hive..registerAdapter(TenpuModelAdapter())
  ..registerAdapter(AwarenessKizukiModelAdapter());
  final akBox = await Hive.openBox<AwarenessKizukiModel>('AwarenessKizuki');
  await akBox.clear();

  final tenpuBox = await Hive.openBox<TenpuModel>('Tenpu');
  await tenpuBox.clear();

  final urlBox = await Hive.openBox<String>('ImageUrl');
  await urlBox.clear();

  // 設定
  Hive.registerAdapter(SeatSettingModelAdapter());
  final ssBox = await Hive.openBox<SeatSettingModel>('SeatSetting');  
  await ssBox.clear();

  // Hive アダプター登録

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
