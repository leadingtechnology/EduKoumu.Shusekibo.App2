import 'dart:html' as html;
import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kyoumutechou/feature/awareness/model/awareness_common.dart';
import 'package:kyoumutechou/feature/awareness/model/awareness_meibo_model.dart';
import 'package:kyoumutechou/feature/awareness/provider/awareness_kizuki_provider.dart';
import 'package:kyoumutechou/feature/awareness/provider/tenpu_provider.dart';
import 'package:kyoumutechou/feature/awareness/repsitory/awareness_kizuki_repository.dart';
import 'package:kyoumutechou/feature/awareness/repsitory/awareness_meibo_repository.dart';
import 'package:kyoumutechou/feature/boxes.dart';
import 'package:kyoumutechou/feature/common/provider/filter_provider.dart';
import 'package:kyoumutechou/feature/common/state/api_state.dart';
import 'package:kyoumutechou/shared/util/date_util.dart';
import 'package:kyoumutechou/shared/util/image_handler.dart';

final awarenessMeiboListProvider = 
StateNotifierProvider<AwarenessMeiboListProvider, ApiState>((ref) {
  final filter = ref.watch(filterProvider);

  return AwarenessMeiboListProvider(ref);
});

final awarenessMeiboProvider = StateProvider<AwarenessMeiboModel>(
  (ref) => const AwarenessMeiboModel(),
);
final awarenessTabProvider = StateProvider<int>((ref) => 0); // switch the tab.
final awarenessBunruiProvider = StateProvider<String>((ref) => '10'); 
final awarenessJuyoProvider = StateProvider<bool>((ref) => false);
final awarenessStudentAddProvider = StateProvider<List<int>>((ref) => []);
final awarenessEditProvider = StateProvider<int>((ref) => 0);

final awarenessListJuyoProvider = StateProvider<bool>((ref) => false);
final awarenessListTextProvider = StateProvider<String>((ref) => '');
final awarenessListIdProvider = StateProvider<String>((ref) => '');

final awarenessTextProvider = StateProvider<String>((ref) => '');

class AwarenessMeiboListProvider extends StateNotifier<ApiState> {
  AwarenessMeiboListProvider(this.ref,)
      : super(const ApiState.loading()) {
    _init();
  }

  final Ref ref;
  late final _repository = ref.read(awarenessMeiboRepositoryProvider);
  late final _rep = ref.read(awarenessKizukiRepositoryProvider);

  Future<void> _init() async { await _fetch(); }

  Future<void> _fetch() async {
    final response = await _repository.fetchAwarenessMeibo();
    if (mounted) {
      state = response;
    }
  }

  Future<void> updateByList(List<AwarenessMeiboModel> meibos) async {
    final box = Boxes.getAwarenessMeiboBox();
    for(var meibo in meibos){
      meibo = AwarenessMeiboModel(
          gakunen: meibo.gakunen,
          shozokuId: meibo.shozokuId,
          className: meibo.className,
          shussekiNo: meibo.shussekiNo,
          studentId: meibo.studentId,
          studentName: meibo.studentName,
          photoUrl: meibo.photoUrl,
          genderCode: meibo.genderCode,
          kizukiCount: meibo.kizukiCount,
          selectFlag: !(meibo.selectFlag ?? false),
      );

      final index =
          box.keys.firstWhere(
            (k) => box.getAt(k as int)?.studentId == meibo.studentId,
          );      
      await box.put(index, meibo);
    }

    ref.read(awarenessCountProvider.notifier).state = 
    box.values.toList().where((e) => e.selectFlag??false ).toList().length;

  }
  
  Future<void> updateById(int studentId) async {
    final box = Boxes.getAwarenessMeiboBox();
    var meibo = box.values.where(
      (e) => e.studentId == studentId,
    ).toList().first;

    meibo = AwarenessMeiboModel(
        gakunen: meibo.gakunen,
        shozokuId: meibo.shozokuId,
        className: meibo.className,
        shussekiNo: meibo.shussekiNo,
        studentId: meibo.studentId,
        studentName: meibo.studentName,
        photoUrl: meibo.photoUrl,
        genderCode: meibo.genderCode,
        kizukiCount: meibo.kizukiCount,
        selectFlag: !(meibo.selectFlag ?? false),);

    final index = box.keys
        .firstWhere((k) => box.getAt(k as int)?.studentId == studentId);
    await box.put(index, meibo);

    ref.read(awarenessCountProvider.notifier).state = box.values
        .toList()
        .where((e) => e.selectFlag ?? false)
        .toList()
        .length;
  }

  // set stamp by Id
  Future<void> updateByMeibo(AwarenessMeiboModel meibo) async {
    final box = Boxes.getAwarenessMeiboBox();

    final newMeibo = AwarenessMeiboModel(
        gakunen: meibo.gakunen,
        shozokuId: meibo.shozokuId,
        className: meibo.className,
        shussekiNo: meibo.shussekiNo,
        studentId: meibo.studentId,
        studentName: meibo.studentName,
        photoUrl: meibo.photoUrl,
        genderCode: meibo.genderCode,
        kizukiCount: meibo.kizukiCount,
        selectFlag: !(meibo.selectFlag ?? false),
    );

    final index = box.keys.firstWhere(
      (k) => box.getAt(k as int)?.studentId == newMeibo.studentId,);
    await box.put(index, newMeibo);

    ref.read(awarenessCountProvider.notifier).state = box.values.toList().where((e) => e.selectFlag??false ).toList().length;
    
  }

  Future<void> save(String str, AwarenessOperationItem opt) async {
    final juyo = ref.read(awarenessJuyoProvider);
    final burui = ref.read(awarenessBunruiProvider);
    final images = ref.read(tenpuListProvider);
    
    String students;
    int shozokuId;
    if (opt == AwarenessOperationItem.add){
      final boxMeibo = Boxes.getAwarenessMeiboBox();
      final studentList = boxMeibo.values.toList().where(
        (e) => e.selectFlag ?? false, 
      ).toList();
      
      shozokuId = studentList.first.shozokuId ?? 0;
      students = studentList.map((e) => e.studentId).toList().toString();
    }else{
      final boxKizuki = Boxes.getAwarenessKizukiModelBox();
      final studentList = boxKizuki.values.toList();

      shozokuId = studentList.first.shozokuId ?? 0;
      students = ref.read(awarenessStudentAddProvider).toString();
    }

    final tenpuList = <String>[];
    for (final image in images){
      final imageData = await ImageHandler.fetchImageData(image);

      final value = '''
{
  "tenpuFileName": "${DateUtil.getDatetimeStamp()}.JPEG",
  "tenpuFileSize": ${imageData.length},
  "tenpuFileData": $imageData
}
''';
      tenpuList.add(value);
    }


    // jsonの作成
    final json = '''
{
    "ShozokuId": $shozokuId,
    "studentKihonIdList": $students,
    "kizuki": "$str",
    "juyoFlg": $juyo,
    "karuteBunruiCode": $burui,
    "TenpuFileList": $tenpuList
}
''';

    final response = await _repository.save(json);
    final res = await _rep.fetch();
    if (opt != AwarenessOperationItem.add){
      final resp = await _repository.fetchAwarenessMeibo();
    }
    if (mounted) {
      state = response;
    }
  }

  // List<Map<String, dynamic>> tenpuListToJson(List<TenpuModel> tenpuList) {
  //   final tenpuListJson = <Map<String, dynamic>>[];
  //   for (final tenpu in tenpuList){
  //     final tenpuJson = tenpu.toJson() ;
  //     tenpuListJson.add(tenpuJson);
  //   }
  //   return tenpuListJson;
  // }
}
