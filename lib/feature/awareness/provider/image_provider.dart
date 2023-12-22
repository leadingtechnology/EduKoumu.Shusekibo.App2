import 'package:flutter_riverpod/flutter_riverpod.dart';

final imageListProvider =
    StateNotifierProvider<ImageListProvider, List<String>>((ref) {

  return ImageListProvider();
});

class ImageListProvider extends StateNotifier<List<String>> {
  ImageListProvider() : super([]) {
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
