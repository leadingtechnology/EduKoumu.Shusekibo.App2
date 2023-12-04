
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kyoumutechou/feature/attendance/provider/attendance_provider.dart';
import 'package:kyoumutechou/feature/attendance/widget/attendance_list_widget.dart';
import 'package:kyoumutechou/feature/attendance/widget/attendance_seat_widget.dart';
import 'package:kyoumutechou/feature/common/provider/common.provider.dart';
import 'package:kyoumutechou/feature/common/widget/common_page.dart';

// 出欠（日）widget
class AttendancePage extends ConsumerWidget {
  AttendancePage({super.key});

// draw key
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageType = ref.watch(attendancePageTypeProvider);

    return CommonPage(
      scaffoldKey: _scaffoldKey,
      contentWidget: pageType == PageType.seat
          ? AttendanceSeatWidget() // 座位图组件
          : AttendanceListWidget(), // 列表组件
      onShift: () {
        ref.read(attendancePageTypeProvider.notifier).state =
            pageType == PageType.seat
                ? PageType.list
                : PageType.seat;
      },
      setBlank: () {},
      onSavePressed: () {},
    );
  }
}
