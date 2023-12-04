import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:kyoumutechou/feature/common/model/dantai_model.dart';
import 'package:kyoumutechou/feature/common/model/filter_model.dart';
import 'package:kyoumutechou/feature/common/model/gakunen_model.dart';
import 'package:kyoumutechou/feature/common/model/shozoku_model.dart';
import 'package:kyoumutechou/feature/common/model/timed_model.dart';
import 'package:kyoumutechou/feature/common/provider/dantais_provider.dart';
import 'package:kyoumutechou/feature/common/provider/gakunens_provider.dart';
import 'package:kyoumutechou/feature/common/provider/shozokus_provider.dart';
import 'package:kyoumutechou/shared/util/date_util.dart';

final filterBeginDateProvider = StateProvider<DateTime>((ref) => DateTime.now());
final filterEndDateProvider = StateProvider<DateTime>((ref) => DateTime.now());
final filterDateProvider = StateProvider<DateTime>((ref) => DateTime.now());

final filterProvider = StateNotifierProvider<Filter, FilterModel>((ref) => Filter(ref));
final kouryuProvider = StateProvider<bool>((ref) => false);

class Filter extends StateNotifier<FilterModel> {
  Filter(this.ref) : super(const FilterModel());
  final Ref ref;

  Future<void> init() async{
    final DantaiModel dantai = ref.watch(dantaiProvider);

    // // 1. get school year
    // final GakunenRepository _gakunenRepository = ref.watch(gakunenRepositoryProvider);
    // await _gakunenRepository.fetchGakunenList();

    // // 2. set default value -- school year
    // List<GakunenModel> gakunenList = Boxes.getGakunenModelBox().values.toList();
    // if (gakunenList.length > 0) {
    //   gakunenList.sort(((a, b) => int.parse('${a.code}').compareTo(int.parse('${b.code}'))));
    //   ref.read(gakunenProvider.notifier).state = gakunenList.first;
    // } else {
    //   ref.read(gakunenProvider.notifier).state = GakunenModel();
    // }
    // GakunenModel gakunen = ref.read(gakunenProvider);

    // // 3. get class
    // final ShozokuRepository _shozokuRepository = ref.watch(shozokuRepositoryProvider);
    // await _shozokuRepository.fetchShozokuList();

    // // 4. set default value -- class
    // Box<ShozokuModel> _shozokuBox = Boxes.getShozokuModelBox();
    // List keys = _shozokuBox.keys.toList().where(
    //   (e) => e.toString().startsWith('${dantai.id}-')
    // ).toList();
    // keys.sort((a, b) => a.toString().compareTo(b.toString()));

    // List<ShozokuModel> shozokuList = [];
    // keys.forEach((key) {
    //   if (_shozokuBox.get(key)!.gakunenCode == gakunen.gakunenCode) {
    //     shozokuList.add(_shozokuBox.get(key)!);
    //   }
    // });

    // if (shozokuList.length > 0){
    //   ref.read(shozokuProvider.notifier).state = shozokuList.first;
    // }else{
    //   ref.read(shozokuProvider.notifier).state = ShozokuModel();
    // }   
    // ShozokuModel shozoku = ref.read(shozokuProvider);

    // // // 5. get timed
    // final TimedRepository _timedRepository = ref.watch(timedRepositoryProvider);
    // await _timedRepository.fetchTimedList();

    // // 6. set default value -- timed
    // List<TimedModel> timedList = Boxes.getTimedModelBox().values.toList();
    // timedList.sort(((a, b) => '${a.jigenIdx}'.compareTo('${b.jigenIdx}')));
    // if( timedList.length > 0 ){
    //   ref.read(timedProvider.notifier).state = timedList.first;
    // }else{
    //   ref.read(timedProvider.notifier).state = TimedModel();
    // }
    // TimedModel timed = ref.read(timedProvider);

    // state = FilterModel(
    //   gakunenCode: gakunen.gakunenCode,
    //   gakunenRyakusho: gakunen.gakunenRyakusho,
    //   classId: shozoku.id,
    //   classCode: shozoku.classCode,
    //   className: shozoku.className,
    //   //
    //   jigenIdx: timed.jigenIdx,
    //   jigenRyaku: timed.ryaku,
    // );
  }

  // 1対象日付の更新
  void updateTargetDate(DateTime newTargetDate) {
    // 使用 copyWith 方法来更新 FilterModel 的状态，只改变 targetDate
    state = state.copyWith(targetDate: newTargetDate);
  }

  void update({required DateTime targetDate}){
    final GakunenModel gakunen = ref.read(gakunenProvider);
    final ShozokuModel shozoku = ref.read(shozokuProvider);

    state = state.copyWith(
      gakunenCode: gakunen.gakunenCode,
      gakunenRyakusho: gakunen.gakunenRyakusho,
      classId: shozoku.id,
      classCode: shozoku.classCode,
      className: shozoku.className,
      kouryuGakkyu: ref.read(kouryuProvider),
      targetDate: targetDate,
      japanDate: DateUtil.getJapaneseDate(targetDate),
    );
  }

  void updateAttendanceTimedFilter({
    required TimedModel timed,
  }) {
    state = state.copyWith(
      jigenIdx: timed.jigenIdx,
      jigenRyaku: timed.ryaku
    );
  }

  void updateAwarenessFilter({
    required DateTime beginDate,
    required DateTime endDate,
  }) {
    state = state.copyWith(beginDate: beginDate, endDate: endDate);
  }

}
