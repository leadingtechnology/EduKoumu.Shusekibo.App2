import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kyoumutechou/feature/awareness/model/kizuki_comment_model.dart';
import 'package:kyoumutechou/feature/awareness/repsitory/awareness_kizuki_repository.dart';
import 'package:kyoumutechou/feature/awareness/repsitory/kizuki_comment_repository.dart';
import 'package:kyoumutechou/feature/common/state/api_state.dart';

final kizukiCommentListProvider =
    StateNotifierProvider<KizukiCommentListProvider, ApiState>((ref) {

  return KizukiCommentListProvider(ref);
});

final kizukiCommentProvider = StateProvider<KizukiCommentModel>(
  (ref) => const KizukiCommentModel(),
);


class KizukiCommentListProvider extends StateNotifier<ApiState> {
  KizukiCommentListProvider(
    this.ref,
  ) : super(const ApiState.loading()) {
    //_init();
  }

  final Ref ref;
  late final _repository = ref.read(kizukiCommentRepositoryProvider);
  late final listRep = ref.read(awarenessKizukiRepositoryProvider);

  // Future<void> _init() async {
  //   await _fetch();
  // }

  // Future<void> _fetch() async {
  //   final response = await _repository.fetch();
  //   if (mounted) {
  //     state = response;
  //   }
  // }

  // Future<void> get(int kizukiId) async {
  //   final response = await _repository.get(kizukiId);
  //   if (mounted) {
  //     state = response;
  //   }
  // }

  Future<void> post(
    int kizukiId, 
    int originCommentId, 
    String text,
    bool juyo,
  ) async {

    var json = "";

    if (originCommentId != 0) {
      json = '''
{
    "KizukiId": $kizukiId,
    "OriginCommentId": $originCommentId,
    "Commentbun": "$text",
    "HasAttachment": false,
    "AttachmentList": null,
    "juyoFlg": ${juyo ? 'true' : 'false'}
}
''';
    }else{
      json = '''
{
    "KizukiId": $kizukiId,
    "Commentbun": "$text",
    "HasAttachment": false,
    "AttachmentList": null,
    "juyoFlg": ${juyo ? 'true' : 'false'}
}
''';

    }

    final response = await _repository.post(json);
    if (mounted) {
      state = response;
    }

    await listRep.fetch();
  }

  Future<void> patch(
    int id,
    String text,
    bool juyo,
    String timestamp,
  ) async {

    final json = '''
{
    "Commentbun": "$text",
    "JuyoFlg": ${juyo ? 'true' : 'false'},
    "TimeStamp": "$timestamp"
}
''';

    

    final response = await _repository.patch(id, json);

    if (mounted) {
      state = response;
    }

    await listRep.fetch();
  }

  Future<void> delete(int kizukiId, String timestamp) async {
    final response = await _repository.delete(kizukiId, timestamp);

    if (mounted) {
      state = response;
    }

    await listRep.fetch();
  }
  
}
