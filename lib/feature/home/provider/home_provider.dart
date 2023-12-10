import 'package:flutter_riverpod/flutter_riverpod.dart';

enum Menu { 
  dashboard, 
  health, 
  attendance, 
  attendanceTimed, 
  awareness, 
  setting, 
}
final menuProvider = StateProvider<Menu>((ref) {return Menu.dashboard; });

enum DashboardTab {health, attendance,absentee,}
final dashboardTabProvider = StateProvider<DashboardTab>((ref) {
  return DashboardTab.health; // 初始值
});

enum AwarenessTab {situation, awareness,}
final awarenessTabProvider = StateProvider<AwarenessTab>((ref) {
  return AwarenessTab.situation; // 初始值
});
