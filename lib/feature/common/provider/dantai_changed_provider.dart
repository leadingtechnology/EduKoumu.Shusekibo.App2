import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kyoumutechou/feature/awareness/provider/awareness_code_provider.dart';
import 'package:kyoumutechou/feature/boxes.dart';
import 'package:kyoumutechou/feature/common/model/dantai_model.dart';
import 'package:kyoumutechou/feature/common/model/gakunen_model.dart';
import 'package:kyoumutechou/feature/common/model/shozoku_model.dart';
import 'package:kyoumutechou/feature/common/model/tannin_model.dart';
import 'package:kyoumutechou/feature/common/provider/dantais_provider.dart';
import 'package:kyoumutechou/feature/common/provider/filter_provider.dart';
import 'package:kyoumutechou/feature/common/provider/gakunens_provider.dart';
import 'package:kyoumutechou/feature/common/provider/kamokus_provider.dart';
import 'package:kyoumutechou/feature/common/provider/seat_chart_pattern_provider.dart';
import 'package:kyoumutechou/feature/common/provider/shozokus_provider.dart';
import 'package:kyoumutechou/feature/common/provider/timeds_provider.dart';
import 'package:kyoumutechou/feature/common/provider/tokobis_provider.dart';
import 'package:kyoumutechou/feature/common/repository/gakunens_repository.dart';
import 'package:kyoumutechou/feature/common/repository/kamokus_repository.dart';
import 'package:kyoumutechou/feature/common/repository/last_tokobis_repository.dart';
import 'package:kyoumutechou/feature/common/repository/shozokus_repository.dart';
import 'package:kyoumutechou/feature/common/repository/tannin2_repository.dart';
import 'package:kyoumutechou/feature/common/repository/tannin_repository.dart';
import 'package:kyoumutechou/feature/common/repository/tanto_kyoin_repository.dart';
import 'package:kyoumutechou/feature/common/repository/teachers_repository.dart';
import 'package:kyoumutechou/feature/common/repository/timeds_repository.dart';
import 'package:kyoumutechou/feature/common/repository/tokobis_repository.dart';
import 'package:kyoumutechou/feature/common/state/api_state.dart';
import 'package:kyoumutechou/feature/seat/provider/seat_setting_provider.dart';
import 'package:kyoumutechou/feature/seat/repository/seat_chart_repository.dart';
import 'package:kyoumutechou/feature/seat/repository/seat_setting_repository.dart';
import 'package:kyoumutechou/shared/http/app_exception.dart';
import 'package:kyoumutechou/shared/util/date_util.dart';

final dantaiChangedProvider =
    StateNotifierProvider.autoDispose<DantaiChangedNotifier, ApiState>((ref) {
  final dantai = ref.watch(dantaiProvider);

  return DantaiChangedNotifier(ref: ref, dantai: dantai);
});

class DantaiChangedNotifier extends StateNotifier<ApiState> {
  DantaiChangedNotifier({required this.ref, required this.dantai})
      : super(const ApiState.loading()) {
    fetch(dantai);
  }

  final Ref ref;
  final DantaiModel dantai;

  final today = DateTime.now();

  late final _tannin = ref.read(tanninRepositoryProvider);
  late final _gakunen = ref.read(gakunensRepositoryProvider);
  late final _shozoku = ref.read(shozokusRepositoryProvider);
  late final _tannin2 = ref.read(tannin2RepositoryProvider);

  late final _tokobi = ref.read(tokobisRepositoryProvider);
  late final _lastTokobi = ref.read(lastTokobisRepositoryProvider);
  late final _timed = ref.read(timedsRepositoryProvider);
  late final _seatSetting = ref.read(seatSettingRepositoryProvider);  
  late final _seatChart = ref.read(seatChartRepositoryProvider);  

  late final _teacher = ref.read(teachersRepositoryProvider);
  late final _kamoku = ref.read(kamokusRepositoryProvider);
  late final _tantoKyoin = ref.read(tantoKyoinsRepositoryProvider);


  Future<void> fetch(DantaiModel dantai) async {
    final dantaiId = dantai.id ?? 0;
    
    // 団体Idが0の場合は返す
    if (dantaiId == 0) {
      state = const ApiState.loaded();
      return;
    }

    // 団体Idを取得する
    try {
      // 200) （２回目）並列処理でデータを取得する。（学年、担任情報）
      final responses = await Future.wait([
        // 担任情報を取得する。
        _tannin.fetch(dantaiId, DateUtil.getStringDate(today)),

        // 学年情報を取得する。
        _gakunen.fetch('${dantai.organizationKbn}'),

        // 所属情報を取得す情報
        _shozoku.fetch(dantaiId),

        // 教職員情報を取得する。
        _teacher.fetch('${dantai.id ?? 0}'),

        // 担任２情報を取得する。
        _tannin2.fetch(),
      ]);

      var isError = false;
      var isLoading = false;
      var errorMessage = '';
      for (final response in responses) {
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

      // 対象日付のリセット
      ref.read(targetDateProvider.notifier).state = today;

      // 担任情報の取得
      final strDate = DateUtil.getStringDate(today);
      final key = Boxes.getTannin().keys.toList().where(
            (element) => element.toString().startsWith('$dantaiId-$strDate'),
          );

      var tannin = const TanninModel();
      try {
        tannin = Boxes.getTannin().get(key.first) ?? const TanninModel();
      } catch (e) {
        //
      }

      // 学年情報の取得
      var gakunen = tannin.gakunenCode == null && tannin.shozokuId != null
      ? GakunenModel(
            id: 999,
            organizationId: dantaiId,
            gakunenCode: '0',
            gakunenName: '学年なし',
            gakunenRyakusho: '学年なし',
            kateiKbn: '99',
            code: '999',
            name: '学年なし',
        ) 
      : GakunenModel(
            gakunenCode: tannin.gakunenCode ?? '',
        );
      try {
        gakunen = await ref.read(gakunensProvider.notifier).setGakunenValue(
              ref,
              dantai,
              gakunenCode: gakunen.gakunenCode,
            );
      } catch (e) {
        //
      }
      ref.read(gakunenProvider.notifier).state = gakunen;

      // 所属初期値の設定
      var shozoku = const ShozokuModel();
      try {
        shozoku = await ref.read(shozokusProvider.notifier).setShozokuValue(
              gakunen,
              shozokuId: tannin.shozokuId,
            );
      } catch (e) {
        //
      }
      ref.read(shozokuProvider.notifier).state = shozoku;
      
      // 担任所属IDの場合、所属情報を設定する。
      if (tannin.shozokuId != null) {
        ref.read(shozokuAllProvider.notifier).state = false;
      }else{
        ref.read(shozokuAllProvider.notifier).state = true;
      }

      // 担任クラスリストの取得
      final shozokus =
          await ref.read(shozokusProvider.notifier).getShozokus(dantaiId);

      final boxShozoku = Boxes.getTanninShozoku();
      final tanninShozokus = boxShozoku.values.toList();

      final tanninShozokuList = <ShozokuModel>[];
      for (final shozoku in shozokus) {
        if (tanninShozokus
            .where((e) => e.id == shozoku.id && e.isGakuseki == true)
            .isNotEmpty) {
          tanninShozokuList.add(shozoku);
        }
      }
      ref.read(shozokuListProvider.notifier).state = tanninShozokuList;

      // 分類コード初期値の設定
      final awarenessCode = 
      ref.read(awarenessCodeListProvider.notifier).setCodeValue();
      ref.read(awarenessCodeProvider.notifier).state = awarenessCode;

      final fiscalYear = DateUtil.calculateFiscalYear(DateTime.now());
      final beginDate = fiscalYear.item1;

      final responses2 = await Future.wait([
        // 時限情報の取得
        _timed.fetch(
          shozoku.id ?? 0,
          strDate,
        ),

        // 座席設定情報の取得
        _seatSetting.fetch(
          shozoku.id ?? 0,
        ),

        // 登校日情報(当月)の取得
        _tokobi.fetch(
          shozoku.id ?? 0,
          today,
          false,
        ),

        // 登校日情報(前月)の取得
        if (DateTime(today.year, today.month - 1).isAfter(beginDate))
        _tokobi.fetch(
          shozoku.id ?? 0,
          DateTime(today.year, today.month - 1),
          false,
        ),

        // 登校日情報(前前月)の取得
        if (DateTime(today.year, today.month - 2).isAfter(beginDate))
        _tokobi.fetch(
          shozoku.id ?? 0,
          DateTime(today.year, today.month - 2),
          false,
        ),

        // ラスト登校日情報の取得
        _lastTokobi.fetch(
          dantaiId,
          today,
        ),

        // 科目情報の取得
        _kamoku.fetch(
          dantaiId,
          gakunen.gakunenCode ?? '',
        ),

        // 担当教員情報の取得
        _tantoKyoin.fetch(
          shozoku.id ?? 0,
          today,
        ),
        
        // // 登校日2情報の取得
        // getTokobi(shozoku),
      ]);

      isError = false;
      isLoading = false;
      errorMessage = '';
      for (final response in responses2) {
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

      // 時限初期値の設定
      final timed = await ref.read(timedsProvider.notifier).setTimedValue();
      ref.read(timedProvider.notifier).state = timed;

      // 座席設定
      final setting = await ref
          .read(seatSettingListProvider.notifier)
          .setSeatSettingValue();
      ref.read(seatSettingPatternProvider.notifier).state = setting;



      // 登校日初期値の設定
      await ref.read(tokobisProvider.notifier).setTokobiValue(
        shozoku.id ?? 0,
        today,
      );

      // 教科初期値設定
      await ref.read(kamokusProvider.notifier).setKamokuValue(
        dantaiId,
        gakunen.gakunenCode ?? '',
      );

      ///
      ///検索条件の初期化
      ///
      ref.read(filterProvider.notifier).reset();

      // 検索条件により、座席表情報の初期化を行う
      await _seatChart.fetch(setting.id ?? 0);

      // 処理正常終了
      state = const ApiState.loaded();
    } catch (e) {
      // ignore: avoid_print
      print('その他エラー情報：$e');
    }

  }

  // Future<ApiState> getTokobi(ShozokuModel shozoku) async {
  //   final lastDate = DateUtil.getLastDayOfPriorMonth(DateTime.now());
  //   if (lastDate == null) {
  //     return const ApiState.loaded();
  //   }

  //   // 登校日情報の取得
  //   return _tokobi.fetch(
  //     shozoku.id ?? 0,
  //     lastDate,
  //     false,
  //   );
  // }
}
