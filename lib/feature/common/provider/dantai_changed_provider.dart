import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kyoumutechou/feature/awareness/provider/awareness_code_provider.dart';
import 'package:kyoumutechou/feature/awareness/repsitory/awareness_code_repository.dart';
import 'package:kyoumutechou/feature/boxes.dart';
import 'package:kyoumutechou/feature/common/model/dantai_model.dart';
import 'package:kyoumutechou/feature/common/model/shozoku_model.dart';
import 'package:kyoumutechou/feature/common/model/tannin_model.dart';
import 'package:kyoumutechou/feature/common/provider/dantais_provider.dart';
import 'package:kyoumutechou/feature/common/provider/filter_provider.dart';
import 'package:kyoumutechou/feature/common/provider/gakunens_provider.dart';
import 'package:kyoumutechou/feature/common/provider/shozokus_provider.dart';
import 'package:kyoumutechou/feature/common/provider/timeds_provider.dart';
import 'package:kyoumutechou/feature/common/provider/tokobis_provider.dart';
import 'package:kyoumutechou/feature/common/repository/gakunens_repository.dart';
import 'package:kyoumutechou/feature/common/repository/shozokus_repository.dart';
import 'package:kyoumutechou/feature/common/repository/tannin_repository.dart';
import 'package:kyoumutechou/feature/common/repository/timeds_repository.dart';
import 'package:kyoumutechou/feature/common/repository/tokobis_repository.dart';
import 'package:kyoumutechou/feature/common/state/api_state.dart';
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

  late final _tannin = ref.read(tanninRepositoryProvider);
  late final _gakunen = ref.read(gakunensRepositoryProvider);
  late final _shozoku = ref.read(shozokusRepositoryProvider);
  late final _burun = ref.read(awarenessCodeRepositoryProvider);

  late final _tokobi = ref.watch(tokobisRepositoryProvider);
  late final _timed = ref.read(timedsRepositoryProvider);

  Future<void> fetch(DantaiModel dantai) async {
    // 団体Idが0の場合は返す
    if (dantai.id == 0) {
      state = const ApiState.loaded();
      return;
    }

    // 団体Idを取得する
    final dantaiId = dantai.id ?? 0;

    try {
      // 200) （２回目）並列処理でデータを取得する。（学年、担任情報）
      final responses = await Future.wait([
        // 担任情報を取得する。
        _tannin.fetch(dantaiId, DateUtil.getStringDate(DateTime.now())),

        // 学年情報を取得する。
        _gakunen.fetch('${dantai.organizationKbn}'),

        //　所属情報を取得す情報
        _shozoku.fetch(dantaiId),

        // 分類コード情報を取得する。
        _burun.fetch(dantaiId),
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
      ref.read(targetDateProvider.notifier).state = DateTime.now();

      // 担任情報の取得
      final strDate = DateUtil.getStringDate(DateTime.now());
      final key = Boxes.getTannin().keys.toList().where(
            (element) => element.toString().startsWith('$dantaiId-$strDate'),
          );

      TanninModel? tannin;
      try {
        tannin = Boxes.getTannin().get(key.first) ?? const TanninModel();
      } catch (e) {
        tannin = const TanninModel();
      }

      // 学年情報の取得
      final gakunen = 
      ref.read(gakunensProvider.notifier).setGakunenValue(
        ref,
        dantai,
        gakunenCode: tannin.gakunenCode,
      );
      ref.read(gakunenProvider.notifier).state = gakunen;

      // 所属初期値の設定
      final shozoku = 
      ref.read(shozokusProvider.notifier).setShozokuValue(
        gakunen,
        shozokuId: tannin.shozokuId,
      );
      ref.read(shozokuProvider.notifier).state = shozoku;

      // 分類コード初期値の設定
      final awarenessCode = 
      ref.read(awarenessCodeListProvider.notifier).setCodeValue(
        ref,
        dantai,
      );
      ref.read(awarenessCodeProvider.notifier).state = awarenessCode;


      final responses2 = await Future.wait([
        // 時限情報の取得
        _timed.fetch(
          shozoku.id ?? 0,
          strDate,
        ),

        // 登校日情報の取得
        _tokobi.fetch(
          shozoku.id ?? 0,
          DateTime.now(),
          false,
        ),

        // 登校日2情報の取得
        getTokobi(shozoku),

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

      // 登校日初期値の設定
      final tokobi = await ref.read(tokobisProvider.notifier).setTokobiValue(
        shozoku.id ?? 0,
        DateTime.now(),
      );

      ///
      ///検索条件の初期化
      ///
      ref.read(filterProvider.notifier).reset();

      // 処理正常終了
      state = const ApiState.loaded();
    } catch (e) {
      // ignore: avoid_print
      print('その他エラー情報：$e');
    }
  }

  Future<ApiState> getTokobi(ShozokuModel shozoku) async {
    final date = DateUtil.getLastDayOfPriorMonth(DateTime.now());
    if (date == null) {
      return const ApiState.loaded();
    }

    // 登校日情報の取得
    return _tokobi.fetch(
      shozoku.id ?? 0,
      DateTime.now(),
      false,
    );
  }
}
