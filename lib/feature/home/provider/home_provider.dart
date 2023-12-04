import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kyoumutechou/feature/home/state/home_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_provider.g.dart';

enum Menu { 
  dashboard, 
  health, 
  attendance, 
  attendanceTimed, 
  awareness, 
  setting, 
}

final menuProvider = StateProvider<Menu>((ref) {
  return Menu.health; // 初始值
});

@riverpod
class HomeNotifier extends _$HomeNotifier {
  @override
  HomeState build() {
    return const HomeState.loading();
  }
}
