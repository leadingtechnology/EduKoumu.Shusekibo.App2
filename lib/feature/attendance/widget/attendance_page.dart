
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kyoumutechou/feature/attendance/model/attendance_meibo_model.dart';
import 'package:kyoumutechou/feature/attendance/provider/attendance_meibo_provider.dart';
import 'package:kyoumutechou/feature/attendance/provider/attendance_provider.dart';
import 'package:kyoumutechou/feature/attendance/widget/attendance_list_widget.dart';
import 'package:kyoumutechou/feature/attendance/widget/attendance_seat_widget.dart';
import 'package:kyoumutechou/feature/boxes.dart';
import 'package:kyoumutechou/feature/common/provider/common.provider.dart';
import 'package:kyoumutechou/feature/common/widget/common_page.dart';
import 'package:kyoumutechou/shared/http/app_exception.dart';

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
          ? const Gridview() // 座位图组件
          : const ListView(), // 列表组件
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

// ShuketuSeat
class Gridview extends ConsumerWidget {
  const Gridview({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(attendanceMeiboListProvider);

    return state.when(
      loading: () {
        return const Center(child: CircularProgressIndicator());
      },
      error: (AppException e) {
        print('attendanceMeiboListProvider get error. $e');
        return Text(e.toString());
      },
      loaded: () {
        // Boxes.getHealthMeiboModelBox()
        return ValueListenableBuilder(
            valueListenable: Boxes.getAttendanceMeiboModelBox().listenable(),
            builder: (context, Box<AttendanceMeiboModel> box, _) {
              final meibos = box.values.toList();

              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 6,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                  childAspectRatio: 2,
                ),
                itemCount: meibos.length,
                itemBuilder: (BuildContext context, int index) {
                  return AttendanceSeatWidget(
                    index: index,
                    meibo: meibos[index],
                  );
                },
              );
            },);
      },
    );
  }
}

class ListView extends ConsumerWidget {
  const ListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(attendanceMeiboListProvider);

    return state.when(
      loading: () {
        return Container(); //Center(child: CircularProgressIndicator());
      },
      error: (AppException e) {
        print('attendanceMeiboListProvider get error. $e');
        return Text('$e');
      },
      loaded: () {
        // Boxes.getHealthMeiboModelBox()
        return AttendanceListWidget(
          key: attendanceGlobalKey,
        );
      },
    );
  }
}
