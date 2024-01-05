import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kyoumutechou/feature/common/provider/common_provider.dart';

final seatChartPageTypeProvider = StateProvider<PageType>((ref) {
  return PageType.list; // 初始值
});

// 座席表設定ID
final seatSettingIdProvider = StateProvider<int>((ref) {return 0;});

