import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kyoumutechou/feature/boxes.dart';
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
    await setTeacherValue(dantai.id ?? 0);

    state = const ApiState.loaded();
  }

  // 初期値を設定する
  Future<void> setTeacherValue(
    int dantaiId, {
    String? kyoinId1,
    String? kyoinId2,
    String? kyoinId3,
  }) async{
    final dantaiId = ref.read(dantaiProvider).id ?? 0;
    
    // 団体Idが空の場合は返す
    if (dantaiId == 0) {
      return ;
    }

    final box = Boxes.getTeachers();
    final teachers = <TeacherModel>[];

    try {
      // 取得したKeysにより、gakunenListを取得する
      final teacherList = box.values.toList();
      
      try {
        if (kyoinId1 != null || kyoinId2 != null || kyoinId3 != null) {
          for (final t in teacherList) {
            if (t.loginId == kyoinId1 ||
                t.loginId == kyoinId2 ||
                t.loginId == kyoinId3) {
              teachers.add(t);
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
