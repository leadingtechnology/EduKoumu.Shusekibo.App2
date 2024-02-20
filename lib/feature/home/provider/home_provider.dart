import 'package:flutter_riverpod/flutter_riverpod.dart';

enum Menu { 
  dashboard, 
  health, 
  attendance, 
  attendanceTimed, 
  awareness, 
  setting,
  seatChart,
  awarenessTemplate,
  modoru,
}

enum ScreenAction {
  add, // 追加
  edit, // 編集
  copy, // 複製
  delete, // 削除
  detail, // 詳細
}

final menuProvider = StateProvider<Menu>((ref) {return Menu.setting;});

enum DashboardTab {health, attendance,absentee,}
final dashboardTabProvider = StateProvider<DashboardTab>((ref) {
  return DashboardTab.health; // 初始值
});

enum AwarenessTab {situation, awareness,}
final awarenessTabProvider = StateProvider<AwarenessTab>((ref) {
  return AwarenessTab.situation; // 初始值
});
