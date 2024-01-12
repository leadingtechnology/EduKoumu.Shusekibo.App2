import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kyoumutechou/feature/boxes.dart';
import 'package:kyoumutechou/feature/common/model/filter_model.dart';
import 'package:kyoumutechou/feature/common/provider/filter_provider.dart';
import 'package:kyoumutechou/feature/common/state/api_state.dart';
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

// 選択された生徒情報
final healthMeiboProvider = StateProvider<HealthMeiboModel>(
  (ref) => const HealthMeiboModel(),
);
final healthShiftProvider = StateProvider<bool>((ref) => false);

//健康観察
class HealthMeiboListProvider extends StateNotifier<ApiState> {
  HealthMeiboListProvider(this.ref, this.filter)
  : super(const ApiState.loading()) {
    _init();
  }

  final Ref ref;
  final FilterModel filter;
  final reason = const HealthReasonModel();

  late final _repository = ref.read(healthMeiboRepositoryProvider);

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
    state = await _repository.save(filter);
  }

  // set stamp by Id
  Future<void> updateById(
    HealthMeiboModel meibo, 
    HealthStampModel stamp,
    HealthReasonModel reason1, 
    HealthReasonModel reason2,
  ) async {
    
    if (stamp.jokyoCd == '001') return;

    // set all.
    if (stamp.bunrui == '50') {
      var meibos = Boxes.getHealthMeiboBox().values.toList();

      // 学年毎
      if (meibos.isNotEmpty) {
        meibos = meibos.where((e) => e.gakunen == meibo.gakunen).toList();
      } 

      for (final m in meibos) {
        await updateBox(m, stamp, reason1, reason2);
      }
      return;
    }

    //clear all and set one
    if (meibo.jokyoList![0].jokyoCode!.startsWith('5')) {

      var meibos = Boxes.getHealthMeiboBox().values.toList();
      const s = HealthStampModel(
        jokyoCd: '999', 
        jokyoNmRyaku: '', 
        jokyoKey: '',
      );

      // 学年毎設定
      if (meibos.isNotEmpty) {
        meibos = meibos.where((e) => e.gakunen == meibo.gakunen).toList();
      }       

      for (final m in meibos) {
        if (m.studentKihonId == meibo.studentKihonId) {
          await updateBox(meibo, stamp, reason1, reason2);
        } else {
          await updateBox(
            m, 
            s, 
            const HealthReasonModel(), 
            const HealthReasonModel(),
          );
        }
      }
      return;
    }
    // set one
    await updateBox(meibo, stamp, reason1, reason2);
  }


  // 未設定の場合、すべての生徒を健康にする
  Future<void> updateByBlank() async {
    final meibos = Boxes.getHealthMeiboBox().values.toList();

    if (meibos.isEmpty) return;

    final stamp = Boxes.getRegistHealthStamp().get('100');

    for (final m in meibos) {
      if (m.jokyoList![0].jokyoCode!.isEmpty) {
        await updateBox(
          m, 
          stamp!, 
          const HealthReasonModel(jiyuNmSeishiki: '健康'),
          const HealthReasonModel(),
        );
      }
    }
  }

  Future<void> updateBox(
    HealthMeiboModel meibo,
    HealthStampModel stamp,
    HealthReasonModel reason1,
    HealthReasonModel reason2,
  ) async {
    final status = stamp.jokyoCd == '999'
        ? HealthStatusModel(
            kokyoDate: DateTime.now(),
            jokyoCode: '',
            ryaku: '',
            jiyu1Code: '',
            jiyu1: '',
            jiyu2: '',
            isEditable: true,
          )
        : HealthStatusModel(
            kokyoDate: DateTime.now(),
            jokyoCode: stamp.jokyoCd,
            ryaku: '${stamp.jokyoNmRyaku}${reason1.jiyuNmRyaku}' ,
            jiyu1Code: reason1.jiyuCd,
            jiyu1: reason1.jiyuNmSeishiki ?? '',
            jiyu2: reason2.jiyuNmSeishiki ?? '',
            isEditable: true,
          );

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
        jokyoList: [status],
      );

    final box = Boxes.getHealthMeiboBox();
    final index = box.keys.firstWhere(
        (k) => box.getAt(k as int)?.studentKihonId == newMeibo.studentKihonId,
      );

    await box.put(index, newMeibo);
  }
}
