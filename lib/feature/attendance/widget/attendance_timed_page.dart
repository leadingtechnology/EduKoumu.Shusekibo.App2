import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kyoumutechou/feature/attendance/model/attendance_timed_meibo_model.dart';
import 'package:kyoumutechou/feature/attendance/provider/attendance_provider.dart';
import 'package:kyoumutechou/feature/attendance/provider/attendance_timed_meibo_provider.dart';
import 'package:kyoumutechou/feature/attendance/widget/attendance_timed_list_widget.dart';
import 'package:kyoumutechou/feature/attendance/widget/attendance_timeed_seat_widget.dart';
import 'package:kyoumutechou/feature/boxes.dart';
import 'package:kyoumutechou/feature/common/provider/common.provider.dart';
import 'package:kyoumutechou/feature/common/provider/filter_provider.dart';
import 'package:kyoumutechou/feature/common/widget/common_page.dart';
import 'package:kyoumutechou/shared/http/app_exception.dart';

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
          ? SeatsWidget() // 座位图组件
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

// ShuketuSeat
class SeatsWidget extends ConsumerWidget {
  const SeatsWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(attendanceTimedMeiboListProvider);
    final filter = ref.watch(filterProvider);

    return state.when(
      loading: () {return Container();},
      error: (AppException e) {return Text(e.toString());},
      loaded: () {
        // Boxes.getHealthMeiboModelBox()
        return ValueListenableBuilder(
            valueListenable:Boxes.getAttendanceTimedMeiboModelBox().listenable(),
            builder: (context, Box<AttendanceTimedMeiboModel> box, _) {
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
                  return AttendanceTimedSeatWidget(
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

class AttendanceTimedListView extends ConsumerWidget {
  const AttendanceTimedListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(attendanceTimedMeiboListProvider);
    final filter = ref.watch(filterProvider);

    return state.when(
      loading: () {return Container();},
      error: (AppException e) {return Text(e.toString());},
      loaded: () {
        return const AttendanceTimedListWidget();
      },
    );
  }
}
