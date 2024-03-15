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
import 'package:kyoumutechou/feature/common/provider/seat_chart_pattern_provider.dart';
import 'package:kyoumutechou/feature/common/provider/tokobis_provider.dart';
import 'package:kyoumutechou/feature/common/state/api_state.dart';
import 'package:kyoumutechou/feature/common/widget/common_page.dart';
import 'package:kyoumutechou/feature/common/widget/save_button_widget.dart';
import 'package:kyoumutechou/feature/common/widget/toast_helper.dart';
import 'package:kyoumutechou/feature/seat/provider/seat_chart_provider.dart';
import 'package:kyoumutechou/feature/seat/widget/blank_seat_widget.dart';
import 'package:kyoumutechou/shared/http/app_exception.dart';

// 出欠（時限）widget
class AttendanceTimedPage extends ConsumerWidget {
  AttendanceTimedPage({super.key});

  // draw key
  final GlobalKey<ScaffoldState> _timedKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageType = ref.watch(attendanceTimedPageTypeProvider);
    final buttonEnable = ref.watch(buttonEnableProvider);

    return CommonPage(
      scaffoldKey: _timedKey,
      contentWidget: pageType == PageType.seat
          ? const SeatsWidget() // 座位图组件
          : const ListView(), // 列表组件
      onShift: () {
        ref.read(attendanceTimedPageTypeProvider.notifier).state =
            pageType == PageType.seat ? PageType.list : PageType.seat;
      },
      setBlank: () async {
        await ref
            .read(attendanceTimedMeiboListProvider.notifier)
            .updateByBlank();
        attendanceTimedGlobalKey.currentState?.setBlank();
      },
      saveWidget: SaveButtonWidget(
        label: '保存',
        onPressed: !buttonEnable
            ? null
            : () {
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
class SeatsWidget extends ConsumerStatefulWidget {
  const SeatsWidget({super.key});

  @override
  ConsumerState<SeatsWidget> createState() => _SeatsWidgetState();
}

class _SeatsWidgetState extends ConsumerState<SeatsWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(seatSettingTimedProvider);
    final lp = ref.watch(lecternPositionProvider);
    final isLocked = ref.watch(isLockedProvider);

    ref.listen<ApiState>(attendanceTimedMeiboListProvider, (previous, next) {
      if (next == const ApiState.loaded()) {
        final list = Boxes.getAttendanceTimedMeibo().values.toList();
        if (list.isEmpty) {
          return;
        }

        if (isLocked) {
          ToastHelper.showToast(context, '　既に保護されているため、編集・保存することができません。　');
        }
      }
    });

    return state.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Text(error.toString()),
      data: (data) {
        setState(() {});
        return ValueListenableBuilder(
          valueListenable: Boxes.getAttendanceTimedMeibo().listenable(),
          builder: (context, Box<AttendanceTimedMeiboModel> box, _) {
            final meibos = box.values.toList();
            final newMeibos = <AttendanceTimedMeiboModel>[];
            
            var rotate = 0.0;
            switch (lp) {
              case LecternPosition.top:
                rotate = 0.0;
              case LecternPosition.bottom:
                rotate = 180.0;
              // ignore: no_default_cases
              default: // Add a default case
                rotate = 0.0;
            }

            var gridColumnCount = 6; 

            if (meibos.isEmpty) {
              return Container();
            }

            // 座席表設定情報取得
            final setting = ref.watch(seatSettingPatternProvider);
            final seats = Boxes.getSeatChart().values.toList();
            if (seats.isNotEmpty && setting.id != null && setting.id != 0) {
              seats.sort((a, b) => a.seatIndex!.compareTo(b.seatIndex!));

              final m = setting.row!;
              final n = setting.column!;
              gridColumnCount = n;

              // 座席ごとにデータを設定する
              for (var i = 0; i < m * n; i++) {

                var meibo = const AttendanceTimedMeiboModel(
                  studentKihonId: 0,
                  studentSeq: '0',
                );

                try {
                  final seatData = seats.firstWhere((e) => e.seatIndex == i);

                  // 席無し情報の設定
                  if (seatData.seatNumber == 0) {
                    meibo = const AttendanceTimedMeiboModel(
                      studentKihonId: -1,
                      studentSeq: '-1',
                    );
                  }

                  // 生徒情報の設定
                  if (seatData.seatNumber != 0) {
                    meibo = meibos
                        .firstWhere((e) => e.studentSeq == seatData.seitoSeq);
                  }

                } catch (ex) {
                  //
                }

                newMeibos.add(meibo);
              }
            }

            if (newMeibos.isEmpty) {
              newMeibos.addAll(meibos);
            }

            return Transform.rotate(
              angle: rotate == 0.0 ? 0.0 : 3.14159265358979323846,
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: gridColumnCount,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 2,
                ),
                itemCount: newMeibos.length,
                itemBuilder: (BuildContext context, int index) {
                  final meibo = newMeibos[index];
              
                  if (meibo.studentKihonId == 0) {
                    // 空席
                    return const BlankSeatWidget(
                      width: 150,
                      height: 70,
                    );
                  }
              
                  if (meibo.studentKihonId == -1) {
                    return Container();
                    // return const NoSeatWidget(
                    //   width: 150,
                    //   height: 70,
                    // );
                  }
              
                  return Transform.rotate(
                    angle: rotate == 0.0 ? 0.0 : 3.14159265358979323846,
                    child: AttendanceTimedSeatWidget(
                      index: index,
                      meibo: newMeibos[index],
                    ),
                  );
                },
              ),
            );
          },
        );
      },
    );
  }
}

class ListView extends ConsumerWidget {
  const ListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(attendanceTimedMeiboListProvider);
    final isLocked = ref.watch(isLockedProvider);

    ref.listen<ApiState>(attendanceTimedMeiboListProvider, (previous, next) {
      if (next == const ApiState.loaded()) {
        final list = Boxes.getAttendanceTimedMeibo().values.toList();
        if (list.isEmpty) {
          return;
        }

        if (isLocked) {
          ToastHelper.showToast(context, '　既に保護されているため、編集・保存することができません。　');
        }
      }
    });

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
