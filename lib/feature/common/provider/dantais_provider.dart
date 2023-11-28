import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kyoumutechou/feature/common/model/dantai_model.dart';
import 'package:kyoumutechou/feature/common/repository/dantais_repository.dart';


final dantaiProvider = StateProvider<DantaiModel>((ref) => const DantaiModel());
final dantaisProvider = StateNotifierProvider<DantaiNotifier, List<DantaiModel>>((ref) {
  return DantaiNotifier(ref: ref);
});



class DantaiNotifier extends StateNotifier<List<DantaiModel>> {
  DantaiNotifier({required this.ref}) : super([]) {
    _fetchDantai();
  }
  
  final Ref ref;
  late final DantaisRepository _rep = ref.watch(dantaisRepositoryProvider);
 


  Future<void> _fetchDantai() async {
    final result = await _rep.fetch();
    result.when(
      error: (e) {
        print(e);
        state = [];
      },
      loading: () {
        print('loading');
        state = [];
      },
      loaded: (dantaiList) {
        if (dantaiList.isNotEmpty) {
          ref.read(dantaiProvider.notifier).state = dantaiList.first;
        }
        state =  dantaiList;
      },
    );
  }
}
