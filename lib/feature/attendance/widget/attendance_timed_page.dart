import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kyoumutechou/feature/attendance/model/attendance_timed_meibo_model.dart';
import 'package:kyoumutechou/feature/attendance/provider/attendance_provider.dart';
import 'package:kyoumutechou/feature/attendance/provider/attendance_timed_meibo_provider.dart';
import 'package:kyoumutechou/feature/attendance/widget/attendance_timed_list_widget.dart';
import 'package:kyoumutechou/feature/attendance/widget/attendance_timeed_seat_widget.dart';
import 'package:kyoumutechou/feature/boxes.dart';
import 'package:kyoumutechou/feature/common/provider/common_provider.dart';
import 'package:kyoumutechou/feature/common/provider/tokobis_provider.dart';
import 'package:kyoumutechou/feature/common/widget/common_page.dart';
import 'package:kyoumutechou/feature/common/widget/save_button_widget.dart';
import 'package:kyoumutechou/feature/common/widget/toast_helper.dart';
import 'package:kyoumutechou/shared/http/app_exception.dart';

// 出欠（時限）widget
class AttendanceTimedPage extends ConsumerWidget {
  AttendanceTimedPage({super.key});

// draw key
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageType = ref.watch(attendanceTimedPageTypeProvider);
    final isEditable = ref.watch(isTokobiProvider);

    return CommonPage(
      scaffoldKey: _scaffoldKey,
      contentWidget: pageType == PageType.seat
          ? const SeatsWidget() // 座位图组件
          : const AttendanceTimedListWidget(), // 列表组件
      onShift: () {
        ref.read(attendanceTimedPageTypeProvider.notifier).state =
            pageType == PageType.seat ? PageType.list : PageType.seat;
      },
      setBlank: !isEditable ? null :  () {
        ref.read(attendanceTimedMeiboListProvider.notifier).updateByBlank();
        attendanceTimedGlobalKey.currentState?.setBlank();
      },
      saveWidget: SaveButtonWidget(
            label: '保存',
            onPressed: !isEditable ? null : (){
              ref.read(attendanceTimedMeiboListProvider.notifier).save();
              ToastHelper.showToast(context, '　保存しました　');
            },
          ),
      buttomName: pageType == PageType.seat ? '一覧' : 'テーブル',
      buttonIcon: pageType == PageType.seat ? Icons.list : Icons.grid_view,
    );
  }
}

// 出欠（時限）テーブル
class SeatsWidget extends ConsumerWidget {
  const SeatsWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(attendanceTimedMeiboListProvider);

    return state.when(
      loading: () {
        return const Center(child: CircularProgressIndicator());
      },
      error: (AppException e) {return Text(e.toString());},
      loaded: () {
        return ValueListenableBuilder(
            valueListenable:Boxes.getAttendanceTimedMeiboModelBox().listenable(),
            builder: (context, Box<AttendanceTimedMeiboModel> box, _) {
              final meibos = box.values.toList();

              if (meibos.isEmpty) {
                return const Center(child: Text('該当データありません'));
              }

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
  const AttendanceTimedListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(attendanceTimedMeiboListProvider);

    return state.when(
      loading: () {
        return const Center(child: CircularProgressIndicator());
      },
      error: (AppException e) {
        return Center(child: Text(e.toString()));
      },
      loaded: () {
        return AttendanceTimedListWidget(
          key: attendanceTimedGlobalKey,
        );
      },
    );
  }
}
