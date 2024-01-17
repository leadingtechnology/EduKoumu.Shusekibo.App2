import 'package:kyoumutechou/feature/boxes.dart';
import 'package:kyoumutechou/feature/common/provider/dantais_provider.dart';
import 'package:kyoumutechou/feature/common/provider/filter_provider.dart';
import 'package:kyoumutechou/feature/dashboard/model/home_attendance_model.dart';
import 'package:kyoumutechou/feature/dashboard/repository/home_attendance_repository.dart';
import 'package:kyoumutechou/feature/dashboard/state/home_attendance_list_state.dart';
import 'package:kyoumutechou/feature/dashboard/state/home_attendance_state.dart';
import 'package:kyoumutechou/shared/util/date_util.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_attendance_list_provider.g.dart';

@riverpod
class HomeAttendanceListNotifier extends _$HomeAttendanceListNotifier {

  late final _rep = ref.read(homeAttendanceRepositoryProvider);
  final box = Boxes.getTokobis();

  @override
  HomeAttendanceListState build() {
    _fetch();
    return const HomeAttendanceListState.loading();
  }

  Future<void> _fetch() async {
    final dantaiId = ref.watch(dantaiProvider).id ?? 0;
    if (dantaiId == 0) {
      return;
    }

    final filter = ref.watch(filterProvider);
    final shozokuId = filter.classId ?? 0;

    // 本日日付の取得
    final today = DateTime.now();

    // 本日以前登校日keyの取得
    final keys = box.keys
        .toList()
        .where((e)=>'$e'.startsWith('$shozokuId-') 
        && '$e'.compareTo('$shozokuId-${DateUtil.getStringDate(today)}') < 0,
        )
        .toList();
    
    // keysの値により登校日を全部取得する
    var tokobis = keys.map(box.get).toList();

    // isEditableがtrueのデータが取得し, tokobi降順で並び替える
    tokobis = tokobis.where((e) => e?.isEditable ?? false).toList()
      ..sort((a, b) => b!.tokobi!.compareTo(a!.tokobi!));

    // 最初の2日間を取得する
    final topThree = tokobis.take(2);


    // topThreeのtokobiを利用、Future.waitで並列処理で_rep.fetchデータを取得する。
    final futures = <Future<HomeAttendanceState>>[];

    futures.add(_rep.fetch(dantaiId, today));
    for (var i = 0; i < topThree.length; i++) {
      futures.add(_rep.fetch(dantaiId, topThree.elementAt(i)!.tokobi!));
    }

    // 並列処理で取得したデータをresponsesに格納する。
    final responses = await Future.wait(futures);
    final attendanceLists = <List<HomeAttendanceModel>>[];

    var errorMessage = '';

    for (final response in responses) {
      response.when(
        error: (e) {
          errorMessage = '$errorMessage {e};';
        },
        loading: () {
        },
        loaded: (attendanceList) {
          attendanceLists.add(attendanceList);
        },
      );
    }
    
    state = HomeAttendanceListState.loaded(attendanceLists);
  }
}
