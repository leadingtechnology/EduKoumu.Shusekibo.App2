import 'package:flutter_riverpod/flutter_riverpod.dart';

final tenpuListProvider =
    StateNotifierProvider<TenpuListProvider, List<String>>((ref) {

  return TenpuListProvider();
});

class TenpuListProvider extends StateNotifier<List<String>> {
  TenpuListProvider() : super([]) {
    init();
  }

  void init() {
    state = [];
  }

  // 画像を削除する
  void remove(String path) {
    state.remove(path);
    state = [...state];
  }

  void add(String path) {
    state.add(path);
    state = [...state];
  }
}
