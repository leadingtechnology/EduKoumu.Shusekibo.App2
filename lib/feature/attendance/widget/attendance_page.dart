import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kyoumutechou/feature/attendance/model/attendance_meibo_model.dart';
import 'package:kyoumutechou/feature/attendance/provider/attendance_meibo_provider.dart';
import 'package:kyoumutechou/feature/attendance/provider/attendance_provider.dart';
import 'package:kyoumutechou/feature/attendance/widget/attendance_list_widget.dart';
import 'package:kyoumutechou/feature/attendance/widget/attendance_seat_widget.dart';
import 'package:kyoumutechou/feature/boxes.dart';
import 'package:kyoumutechou/feature/common/provider/common_provider.dart';
import 'package:kyoumutechou/feature/common/provider/tokobis_provider.dart';
import 'package:kyoumutechou/feature/common/widget/common_page.dart';
import 'package:kyoumutechou/feature/common/widget/no_data_widget.dart';
import 'package:kyoumutechou/feature/common/widget/save_button_widget.dart';
import 'package:kyoumutechou/feature/common/widget/toast_helper.dart';
import 'package:kyoumutechou/shared/http/app_exception.dart';

// 出欠（日）widget
class AttendancePage extends ConsumerWidget {
  AttendancePage({super.key});

// draw key
  final GlobalKey<ScaffoldState> _attendanceKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageType = ref.watch(attendancePageTypeProvider);
    //final isEditable = ref.watch(isTokobiProvider);
    final buttonEnable = ref.watch(buttonEnableProvider);

    return CommonPage(
      scaffoldKey: _attendanceKey,
      contentWidget: pageType == PageType.seat
          ? const Gridview() 
          : const ListView(), 
      onShift: () {
        ref.read(attendancePageTypeProvider.notifier).state =
            pageType == PageType.seat ? PageType.list : PageType.seat;
      },
      setBlank: () async {
        await ref.read(attendanceMeiboListProvider.notifier).updateByBlank();
        attendanceGlobalKey.currentState?.setBlank();
      },
      saveWidget: SaveButtonWidget(
        label: '保存',
        onPressed: !buttonEnable
            ? null
            : () {
                ref.read(attendanceMeiboListProvider.notifier).save();
                ToastHelper.showToast(context, '　保存しました　');
              },
      ),
      buttomName: pageType == PageType.seat ? '一覧' : 'テーブル',
      buttonIcon: pageType == PageType.seat ? Icons.list : Icons.grid_view,
    );
  }
}

// 出欠（日）テーブル
class Gridview extends ConsumerWidget {
  const Gridview({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(attendanceMeiboListProvider);

    return state.when(
      loading: () {
        return const Center(child: CircularProgressIndicator());
      },
      error: (AppException e) {return Text(e.toString());},
      loaded: () {
        return ValueListenableBuilder(
            valueListenable: Boxes.getAttendanceMeibo().listenable(),
            builder: (context, Box<AttendanceMeiboModel> box, _) {
              final meibos = box.values.toList();

              if (meibos.isEmpty) {
                return const NoDataWidget();
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
        return const Center(child: CircularProgressIndicator());
      },
      error: (AppException e) {
        return Center(child: Text(e.toString()));
      },
      loaded: () {
        return AttendanceListWidget(
          key: attendanceGlobalKey,
        );
      },
    );
  }
}
