import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kyoumutechou/feature/boxes.dart';
import 'package:kyoumutechou/feature/common/model/dantai_model.dart';
import 'package:kyoumutechou/feature/common/model/teacher_model.dart';
import 'package:kyoumutechou/feature/common/provider/dantais_provider.dart';
import 'package:kyoumutechou/feature/common/state/api_state.dart';

// final teacherProvider = StateProvider<TeacherModel>(
//   (ref) => const TeacherModel(),
// );
final teacherListProvider = StateProvider<List<TeacherModel>>(
  (ref) => [],
);

final teachersProvider = 
    StateNotifierProvider<TeacherNotifier, ApiState>((ref) {

  return TeacherNotifier(ref: ref);
});

class TeacherNotifier extends StateNotifier<ApiState> {
  TeacherNotifier({
    required this.ref,
  }) : super(const ApiState.loading()) {
    _fetch();
  }

  final Ref ref;

  Future<void> init() async {
    state = const ApiState.loading();
    await _fetch();
  }

  Future<void> _fetch() async {
    final dantai = ref.read(dantaiProvider);
    setTeacherValue(dantai.id ?? 0);

    state = const ApiState.loaded();
  }

  Future<void> setTeacherValue(
    int dantaiId, {
    String? KyoinId1,
    String? KyoinId2,
    String? KyoinId3,
  }) async{
    final dantaiId = ref.read(dantaiProvider).id ?? 0;
    
    // 団体Idが空の場合は返す
    if (dantaiId == 0) {
      return ;
    }

    final box = Boxes.getTeachers();
    final teachers = <TeacherModel>[];

    try {
      // 初期値の設定
      final keys = box.keys
          .toList()
          .where((e) => e.toString().startsWith('$dantaiId-'))
          .toList();

      if (keys.isEmpty) {
        return;
      } 
      
      // 取得したKeysにより、gakunenListを取得する
      final teacherList = keys.map(box.get).toList();
      
      try {
        if (KyoinId1 != null || KyoinId2 != null || KyoinId3 != null) {
          for (final t in teacherList) {
            if (t != null) {
              if (t.loginId == KyoinId1 ||
                  t.loginId == KyoinId2 ||
                  t.loginId == KyoinId3) {
                teachers.add(t);
              }
            }
          }
          
        }
      } catch (e) {
        //
      }
    } catch (e) {
      //
    }

    ref.read(teacherListProvider.notifier).state = teachers;
    return;
  }
}
