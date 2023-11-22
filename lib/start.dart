import 'dart:async';
import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:kyoumutechou/app/app.dart';
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
  //Hive.registerAdapter(DateTimeAdapter());

  // Hive open box
  await Hive.openBox<String>('shusekibo');
  await Hive.box<String>('shusekibo').put('token', '');
  
  runApp(EasyLocalization(
    supportedLocales: const [Locale('ja')],
    path: 'assets/lang',
    fallbackLocale: const Locale('ja'),
    child: ProviderScope(overrides: [
      platformTypeProvider.overrideWithValue(platformType),
    ], observers: [
      Logger(),
    ], child: const App(),),
  ),);
}
