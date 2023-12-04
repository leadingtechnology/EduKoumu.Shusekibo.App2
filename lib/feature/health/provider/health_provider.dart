import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kyoumutechou/feature/common/provider/common.provider.dart';

final healthPageTypeProvider = StateProvider<PageType>((ref) {
  return PageType.seat; // 初始值
});
