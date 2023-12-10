import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kyoumutechou/feature/common/provider/common_provider.dart';

final healthPageTypeProvider = StateProvider<PageType>((ref) {
  return PageType.seat; // 初始值
});

final healthStampReasonExpend = StateProvider<bool>((ref) {
  return false; // 初始值
},);
