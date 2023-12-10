import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kyoumutechou/feature/boxes.dart';
import 'package:kyoumutechou/feature/common/model/filter_model.dart';
import 'package:kyoumutechou/feature/common/provider/filter_provider.dart';
import 'package:kyoumutechou/feature/common/state/api_state.dart';
import 'package:kyoumutechou/feature/dashboard/repository/home_health_repository.dart';

import 'package:kyoumutechou/feature/health/model/health_meibo_model.dart';
import 'package:kyoumutechou/feature/health/model/health_reason_model.dart';
import 'package:kyoumutechou/feature/health/model/health_stamp_model.dart';
import 'package:kyoumutechou/feature/health/model/health_status_model.dart';
import 'package:kyoumutechou/feature/health/repository/health_meibo_repository.dart';

final healthMeiboListProvider =
    StateNotifierProvider<HealthMeiboListProvider, ApiState>((ref) {
  final filter = ref.watch(filterProvider);

  return HealthMeiboListProvider(ref, filter);
});

final healthMeiboProvider =
    StateProvider<HealthMeiboModel>((ref) => HealthMeiboModel());
final healthShiftProvider = StateProvider<bool>((ref) => false);

class HealthMeiboListProvider extends StateNotifier<ApiState> {
  HealthMeiboListProvider(this.ref, this.filter)
      : super(const ApiState.loading()) {
    _init();
  }

  final Ref ref;
  final FilterModel filter;
  final reason = HealthReasonModel();

  late final HealthMeiboRepository _repository =
      ref.read(healthMeiboRepositoryProvider);
  late final HomeHealthRepository _homeRepository =
      ref.read(homeHealthRepositoryProvider);

  Future<void> _init() async {
    await _fetch();
  }

  Future<void> _fetch() async {
    final response = await _repository.fetch(filter);
    if (mounted) {
      state = response;
    }
  }

  Future<void> save() async {
    state = await _repository.save();
    final response = await _homeRepository.fetch(
      filter.dantaiId ?? 0, 
      filter.targetDate ?? DateTime.now(),
    );
  }

  // set stamp by Id
  Future<void> updateById(HealthMeiboModel meibo, HealthStampModel stamp,
      HealthReasonModel reason1, HealthReasonModel reason2) async {
    if (stamp.jokyoCd == '001') return;

    // set all.
    if (stamp.bunrui == '50') {
      List<HealthMeiboModel> meibos = Boxes.getHealthMeiboBox().values.toList();
      for (HealthMeiboModel m in meibos) {
        await updateBox(m, stamp, reason1, reason2);
      }
      return;
    }

    //clear all and set one
    if (meibo.jokyoList![0].jokyoCode!.startsWith('5')) {
      List<HealthMeiboModel> meibos = Boxes.getHealthMeiboBox().values.toList();
      HealthStampModel s =
          HealthStampModel(jokyoCd: '999', jokyoNmRyaku: ' ', jokyoKey: ' ');

      for (HealthMeiboModel m in meibos) {
        if (m.studentKihonId == meibo.studentKihonId)
          await updateBox(meibo, stamp, reason1, reason2);
        else
          await updateBox(m, s, HealthReasonModel(), HealthReasonModel());
      }
      return;
    }

    // set one
    await updateBox(meibo, stamp, reason1, reason2);
  }

  // cover blank values
  Future<void> updateByBlank() async {
    List<HealthMeiboModel> meibos = Boxes.getHealthMeiboBox().values.toList();

    if (meibos.length <= 0) return;

    HealthStampModel? stamp = Boxes.getRegistHealthStamp().get('100');
    for (HealthMeiboModel m in meibos) {
      if (m.jokyoList![0].jokyoCode!.isEmpty)
        await updateBox(m, stamp!, HealthReasonModel(jiyuNmSeishiki: '健康'),
            HealthReasonModel());
    }
  }

  Future<void> updateBox(
    HealthMeiboModel meibo,
    HealthStampModel stamp,
    HealthReasonModel reason1,
    HealthReasonModel reason2,
  ) async {
    HealthStatusModel status = stamp.jokyoCd == '999'
        ? HealthStatusModel(
            kokyoDate: DateTime.now(),
            jokyoCode: '',
            ryaku: '',
            jiyu1Code: '',
            jiyu1: '',
            jiyu2: '',
            isEditable: true)
        : HealthStatusModel(
            kokyoDate: DateTime.now(),
            jokyoCode: stamp.jokyoCd,
            ryaku: stamp.jokyoNmRyaku,
            jiyu1Code: reason1.jiyuCd,
            jiyu1: reason1.jiyuNmSeishiki ?? '',
            jiyu2: reason2.jiyuNmSeishiki ?? '',
            isEditable: true);

    final newMeibo = HealthMeiboModel(
        studentKihonId: meibo.studentKihonId,
        studentSeq: meibo.studentSeq,
        gakunen: meibo.gakunen,
        className: meibo.className,
        studentNumber: meibo.studentNumber,
        photoImageFlg: meibo.photoImageFlg,
        name: meibo.name,
        genderCode: meibo.genderCode,
        photoUrl: meibo.photoUrl,
        jokyoList: [status]);

    var _box = Boxes.getHealthMeiboBox();
    final index = Boxes.getAttendanceMeibo().keys.firstWhere(
        (k) => _box.getAt(k as int)?.studentKihonId == newMeibo.studentKihonId,);

    await _box.put(index, newMeibo);
  }
}
