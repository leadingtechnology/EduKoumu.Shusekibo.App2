import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kyoumutechou/feature/common/model/dantai_model.dart';
import 'package:kyoumutechou/feature/common/model/filter_model.dart';
import 'package:kyoumutechou/feature/common/model/timed_model.dart';
import 'package:kyoumutechou/feature/common/provider/dantais_provider.dart';
import 'package:kyoumutechou/feature/common/provider/gakunens_provider.dart';
import 'package:kyoumutechou/feature/common/provider/shozokus_provider.dart';
import 'package:kyoumutechou/feature/common/provider/timeds_provider.dart';
import 'package:kyoumutechou/shared/util/date_util.dart';

final beginDateProvider = StateProvider<DateTime>(
  (ref) => DateTime.now().subtract(const Duration(days: 7)),
);
final endDateProvider = StateProvider<DateTime>((ref) => DateTime.now());
final targetDateProvider = StateProvider<DateTime>((ref) => DateTime.now());
final kouryuProvider = StateProvider<bool>((ref) => false);

//final hasData = StateProvider<bool>((ref) => false);

final filterProvider = StateNotifierProvider<FilterNotifier, FilterModel>((ref){
  final dantai = ref.watch(dantaiProvider);

  return FilterNotifier(ref: ref, dantai: dantai);
});

class FilterNotifier extends StateNotifier<FilterModel> {
  FilterNotifier(
    {
      required this.ref,
      this.dantai = const DantaiModel(),
    }
  ) : super(const FilterModel());
  
  final Ref ref;
  final DantaiModel dantai;

  // // 団体IDを取得した場合
  // late final _tannin = ref.watch(tanninRepositoryProvider);
  // late final _gakunen = ref.watch(gakunensRepositoryProvider);
  // late final _shozoku = ref.watch(shozokusRepositoryProvider);

  // late final _timed = ref.watch(timedsRepositoryProvider);

  void init() {
    state = FilterModel(
      dantaiId: 0,
      gakunenCode: '',
      gakunenRyakusho: '',
      classId: 0,
      classCode: '',
      className: '',
      kouryuGakkyu: false,
      targetDate: DateTime.now(),
      japanDate: DateUtil.getJapaneseDate(DateTime.now()),
      jigenIdx: 0,
      jigenRyaku: '',
      beginDate: DateTime.now(),
      endDate: DateTime.now(),
    );
  }

  // 1対象日付の更新
  void updateTargetDate(DateTime newTargetDate) {
    // 使用 copyWith 方法来更新 FilterModel 的状态，只改变 targetDate
    state = state.copyWith(
      targetDate: newTargetDate,
      japanDate: DateUtil.getJapaneseDate(newTargetDate),
    );
  }

  void refresh(){
    state = state.copyWith();
  }

  void update({required DateTime targetDate}){
    final Dantai = ref.read(dantaiProvider);
    final gakunen = ref.read(gakunenProvider);
    final shozoku = ref.read(shozokuProvider);
    final kouryu = ref.read(kouryuProvider);
    final timed = ref.read(timedProvider);
    final startDate = ref.read(beginDateProvider);
    final endDate = ref.read(endDateProvider);

    state = state.copyWith(
      dantaiId: Dantai.id,
      gakunenCode: gakunen.gakunenCode,
      gakunenRyakusho: gakunen.gakunenRyakusho,
      classId: shozoku.id,
      classCode: shozoku.classCode,
      className: shozoku.className,
      kouryuGakkyu: kouryu,
      targetDate: targetDate,
      japanDate: DateUtil.getJapaneseDate(targetDate),
      jigenIdx: timed.jigenIdx,
      jigenRyaku: timed.ryaku,
      beginDate: startDate,
      endDate: endDate,
    );
  }

  void reset() {
    final dantai = ref.read(dantaiProvider);
    final gakunen = ref.read(gakunenProvider);
    final shozoku = ref.read(shozokuProvider);
    final kouryu = ref.read(kouryuProvider);
    final timed = ref.read(timedProvider);
    final startDate = ref.read(beginDateProvider);
    final endDate = ref.read(endDateProvider);


    state = state.copyWith(
      dantaiId: dantai.id,
      gakunenCode: gakunen.gakunenCode,
      gakunenRyakusho: gakunen.gakunenRyakusho,
      classId: shozoku.id,
      classCode: shozoku.classCode,
      className: shozoku.className,
      kouryuGakkyu: kouryu,
      targetDate: DateTime.now(),
      japanDate: DateUtil.getJapaneseDate(DateTime.now()),
      jigenIdx: timed.jigenIdx,
      jigenRyaku: timed.ryaku,
      beginDate: startDate,
      endDate: endDate,      
    );
  }

  void updateAttendanceTimedFilter({
    required TimedModel timed,
  }) {
    state = state.copyWith(
      jigenIdx: timed.jigenIdx,
      jigenRyaku: timed.ryaku,
    );
  }

  void updateAwarenessFilter({
    DateTime? beginDate,
    DateTime? endDate,
  }) {
    beginDate = beginDate ?? DateTime.now().subtract(const Duration(days: 7));
    endDate = endDate ?? DateTime.now();
    state = state.copyWith(beginDate: beginDate, endDate: endDate);
  }

  // Future<void> fetch(DantaiModel dantai) async {

  //   try {

  //     // 団体IDを取得する。
  //     final dantaiId = int.parse(Boxes.getBox().get('dantaiId') ?? '0');

  //     // 200) （２回目）並列処理でデータを取得する。（学年、担任情報）
  //     await Future.wait([
  //       // 担任情報を取得する。
  //       _tannin.fetch(dantaiId, DateUtil.getStringDate(DateTime.now())),

  //       // 学年情報を取得する。
  //       _gakunen.fetch('${dantai.organizationKbn}'),

  //       //　所属情報を取得す情報
  //       _shozoku.fetch(dantaiId),
  //     ]);

  //     // 本日担任情報の取得
  //     final strDate = DateUtil.getStringDate(DateTime.now());

  //     final key = Boxes.getTannin().keys.toList().where(
  //           (element) =>
  //               element.toString().startsWith('$dantaiId-$strDate'),
  //         );
      
  //     TanninModel? tannin;
  //     try{
  //       tannin = Boxes.getTannin().get(key.first)??const TanninModel();
  //     }catch(e){
  //       tannin = null;
  //     } 

  //     // 学年初期値の設定
  //     GakunenModel? gakunen;
  //     // 所属初期値の設定
  //     ShozokuModel? shozoku;

  //     if (tannin != null && 
  //         tannin.gakunenCode != null && 
  //         tannin.shozokuId != null) {
  //       ref.read(tanninProvider.notifier).state = tannin;

    
  //       try{
  //         gakunen = Boxes.getGakunens().values.where(
  //               (e) => e.gakunenCode == tannin?.gakunenCode,
  //             )
  //             .first;
  //         ref.read(gakunenProvider.notifier).state = gakunen;
  //               }catch(e){
  //         gakunen = null;
  //       }
        
  //       try{
  //         shozoku = Boxes.getShozokus().values.where(
  //               (e) => e.id == tannin?.shozokuId,
  //             )
  //             .first;
  //         ref.read(shozokuProvider.notifier).state = shozoku;
  //               }catch(e){
  //         shozoku = null;
  //       }

  //     }else{
  //       // 学年初期値の設定
  //       ref.read(gakunensProvider.notifier).setDefaultValue();

  //       // 所属初期値の設定
  //       ref.read(shozokusProvider.notifier).setDefaultValue();

  //       shozoku = ref.read(shozokuProvider);
  //       gakunen = ref.read(gakunenProvider);
  //     }

  //     if (gakunen != null && shozoku != null) {
  //       await _timed.fetch(shozoku.id ?? 0, strDate);
  //       ref.read(timedsProvider.notifier).setDefaultValue();

  //       // フィルターの初期値を設定する。
  //       ref.read(filterProvider.notifier).update(targetDate: DateTime.now());
  //     }

  //   } catch (error) {
  //     //state = ApiState.error(AppException.errorWithMessage('$error'));
  //   }

  // }

}
