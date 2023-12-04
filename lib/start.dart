import 'dart:async';
import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:kyoumutechou/app/app.dart';
import 'package:kyoumutechou/database/adapter/datetime_adapter.dart';
import 'package:kyoumutechou/feature/attendance/model/attendance_reason_model.dart';
import 'package:kyoumutechou/feature/attendance/model/attendance_stamp_model.dart';
import 'package:kyoumutechou/feature/common/model/gakunen_model.dart';
import 'package:kyoumutechou/feature/common/model/shozoku_model.dart';
import 'package:kyoumutechou/feature/common/model/timed_model.dart';
import 'package:kyoumutechou/feature/common/model/tokobi_model.dart';
import 'package:kyoumutechou/feature/health/model/health_reason_model.dart';
import 'package:kyoumutechou/feature/health/model/health_stamp_model.dart';
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

  // 学年
  Hive.registerAdapter(GakunenModelAdapter());
  await Hive.openBox<GakunenModel>('Gakunen');

  // クラス
  Hive.registerAdapter(ShozokuModelAdapter());
  await Hive.openBox<ShozokuModel>('Shozoku');

  // 時限
  Hive.registerAdapter(TimedModelAdapter());
  await Hive.openBox<TimedModel>('Timed');

  // 登校日
  Hive.registerAdapter(TokobiModelAdapter());
  await Hive.openBox<TokobiModel>('Tokobi');

  // 健康観察スタンプ
  Hive.registerAdapter(HealthStampModelAdapter());
  await Hive.openBox<HealthStampModel>('RegistHealthStamp');
  await Hive.openBox<HealthStampModel>('UnregistHealthStamp');

  // 健康観察理由
  Hive.registerAdapter(HealthReasonModelAdapter());
  await Hive.openBox<HealthReasonModel>('HealthReason1');
  await Hive.openBox<HealthReasonModel>('HealthReason2');

  // 出欠スタンプ
  Hive.registerAdapter(AttendanceStampModelAdapter());
  await Hive.openBox<AttendanceStampModel>('RegistAttendanceStamp');
  await Hive.openBox<AttendanceStampModel>('UnregistAttendanceStamp');

  // 出欠理由
  Hive.registerAdapter(AttendanceReasonModelAdapter());
  await Hive.openBox<AttendanceReasonModel>('AttendanceReason1');
  await Hive.openBox<AttendanceReasonModel>('AttendanceReason2');

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
