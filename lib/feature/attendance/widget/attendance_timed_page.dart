import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kyoumutechou/feature/attendance/provider/attendance_provider.dart';
import 'package:kyoumutechou/feature/attendance/widget/attendance_timed_list_widget.dart';
import 'package:kyoumutechou/feature/attendance/widget/attendance_timeed_seat_widget.dart';
import 'package:kyoumutechou/feature/common/provider/common.provider.dart';
import 'package:kyoumutechou/feature/common/widget/common_page.dart';

// 出欠（時限）widget
class AttendanceTimedPage extends ConsumerWidget {
  AttendanceTimedPage({super.key});

// draw key
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageType = ref.watch(attendanceTimedPageTypeProvider);

    return CommonPage(
      scaffoldKey: _scaffoldKey,
      contentWidget: pageType == PageType.seat
          ? AttendanceTimedSeatWidget() // 座位图组件
          : AttendanceTimedListWidget(), // 列表组件
      onShift: () {
        ref.read(attendanceTimedPageTypeProvider.notifier).state =
            pageType == PageType.seat ? PageType.list : PageType.seat;
      },
      setBlank: () {},
      onSavePressed: () {},
    );
  }
}
