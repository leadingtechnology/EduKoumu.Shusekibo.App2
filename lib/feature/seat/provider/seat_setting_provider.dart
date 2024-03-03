import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kyoumutechou/feature/boxes.dart';
import 'package:kyoumutechou/feature/common/model/filter_model.dart';
import 'package:kyoumutechou/feature/common/provider/filter_provider.dart';
import 'package:kyoumutechou/feature/common/provider/seat_chart_pattern_provider.dart';
import 'package:kyoumutechou/feature/common/state/api_state.dart';
import 'package:kyoumutechou/feature/seat/model/seat_setting_model.dart';
import 'package:kyoumutechou/feature/seat/repository/seat_chart_repository.dart';
import 'package:kyoumutechou/feature/seat/repository/seat_setting_repository.dart';
import 'package:kyoumutechou/shared/util/date_util.dart';


final seatSettingListProvider =
    StateNotifierProvider<SeatSettingListProvider, ApiState>((ref) {

  final filter = ref.watch(filterProvider);
  
  return SeatSettingListProvider(ref, filter);
});

class SeatSettingListProvider extends StateNotifier<ApiState> {
  SeatSettingListProvider(
    this.ref, 
    this.filter,
  ) : super(const ApiState.loading()) {
    _init();
  }

  final Ref ref;
  final FilterModel filter;
  late final _settingRep = ref.read(seatSettingRepositoryProvider);
  late final _seatChartRep = ref.read(seatChartRepositoryProvider);

  Future<void> _init() async {
    if (filter.classId == null) {
      state = const ApiState.loading();
      return;
    }
    await fetch();
  }

  // 検索処理
  Future<void> fetch() async {
    final classId = ref.read(filterProvider).classId ?? 0;
    if (classId == 0) {
      return;
    } 
    
    final response = await _settingRep.fetch(classId);

    await setSeatSettingValue();
    
    if (mounted) {
      state = response;
    }

    
  }

  // 初期値を設定する
  Future<SeatSettingModel> setSeatSettingValue() async {
    // 最新情報の取得条件
    final filter = ref.read(filterProvider);
    final tarDate = filter.targetDate ?? DateTime.now();


    var setting = const SeatSettingModel(
      id: 0,
    );
    try{
      final box = Boxes.getSeatSetting();
      final settings = box.values.toList()
        ..removeWhere(
          (e) => e.startDate!.isBefore(tarDate) && e.endDate!.isAfter(tarDate),
        )
        ..sort((a, b) => a.id!.compareTo(b.id!));
      
      setting = settings.first;
    }catch(e){
      //
    }

    if (setting.id! > 0) {
      await _seatChartRep.fetch(setting.id!);
    }

    ref.read(seatSettingPatternProvider.notifier).state = setting;
    return setting;
  }

  // 削除処理
  Future<void> delete(int id) async {
    final response = await _settingRep.delete(id);

    if (mounted) {
      state = response;
    }
  }

  Future<void> patch({
    required int id,
    required int row, 
    required int col, 
    required int seatOrder,
    required String seatPattern,
    required String seatPatternName,
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    final classId = ref.read(filterProvider).classId ?? 0;

    //データ作成
    final json = '''
{
    "SeatPattern": "$seatPattern",
    "SeatPatternName": "$seatPatternName",
    "Row": $row,
    "Column": $col,
    "SeatOrder": $seatOrder,
    "StartDate": "${DateUtil.getStringDate(startDate)}",
    "EndDate": "${DateUtil.getStringDate(endDate)}"
}
''';
    
    //データ作成
    await _settingRep.patch(id, json);
    await _settingRep.fetch(classId);
    
  }

  Future<void> save({
    required int row,
    required int col,
    required int seatOrder,
    required String seatPattern,
    required String seatPatternName,
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    // 団体Idの取得
    final dantaiId = ref.read(filterProvider).dantaiId;

    //所属Idの取得
    final shozokuId = ref.read(filterProvider).classId ?? 0;

    //データ作成
    final json = '''
{
    "DantaiId": $dantaiId,
    "ShozokuId": $shozokuId,
    "SeatPattern": "$seatPattern",
    "SeatPatternName": "$seatPatternName",
    "Row": $row,
    "Column": $col,
    "SeatOrder": $seatOrder,
    "StartDate": "${DateUtil.getStringDate(startDate)}",
    "EndDate": "${DateUtil.getStringDate(endDate)}"
}
''';

    //データ作成
    await _settingRep.save(json);
    await _settingRep.fetch(shozokuId);
  }  
}
