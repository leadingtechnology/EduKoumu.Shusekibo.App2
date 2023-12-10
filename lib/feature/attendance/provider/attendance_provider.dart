import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kyoumutechou/feature/common/provider/common_provider.dart';

final attendancePageTypeProvider = StateProvider<PageType>((ref) {
  return PageType.seat; // 初始值
});


final attendanceTimedPageTypeProvider = StateProvider<PageType>((ref) {
  return PageType.seat; // 初始值
});

final attendanceStampReasonExpend = StateProvider<bool>((ref) {
  return false; // 初始值
},);
