import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kyoumutechou/feature/common/provider/filter_provider.dart';
import 'package:kyoumutechou/feature/common/state/api_state.dart';
import 'package:kyoumutechou/feature/seat/model/seat_setting_model.dart';
import 'package:kyoumutechou/feature/seat/repository/seat_setting_repository.dart';
import 'package:kyoumutechou/shared/util/date_util.dart';


final seatSettingListProvider =
    StateNotifierProvider<SeatSettingListProvider, ApiState>((ref) {
  
  final filter = ref.watch(filterProvider);

  return SeatSettingListProvider(ref, '${filter.classId ?? ''}');
});

final seatSettingProvider = 
    StateProvider<SeatSettingModel>((ref) => const SeatSettingModel());

class SeatSettingListProvider extends StateNotifier<ApiState> {
  SeatSettingListProvider(
    this.ref, 
    this.classId,
  ) : super(const ApiState.loading()) {
    _init();
  }

  final Ref ref;
  final String classId;
  late final _repository = ref.read(seatSettingRepositoryProvider);

  Future<void> _init() async {
    await fetch();
  }

  Future<void> fetch() async {
    if (classId == '') {
      return;
    } 
    
    final response = await _repository.fetch(classId);
    if (mounted) {
      state = response;
    }
  }

  Future<void> delete(int id) async {
    final response = await _repository.delete(id);

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
    await _repository.patch(id, json);
    await _repository.fetch(classId);
    
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
    final shozokuId = ref.read(filterProvider).classId;

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
    await _repository.save(json);
    await _repository.fetch(classId);
  }  
}
