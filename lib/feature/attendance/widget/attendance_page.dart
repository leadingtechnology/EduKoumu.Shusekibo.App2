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
import 'package:kyoumutechou/feature/common/widget/common_page.dart';
import 'package:kyoumutechou/feature/common/widget/save_button_widget.dart';
import 'package:kyoumutechou/feature/common/widget/toast_helper.dart';
import 'package:kyoumutechou/feature/seat/provider/seat_chart_provider.dart';
import 'package:kyoumutechou/feature/seat/provider/seat_setting_provider.dart';
import 'package:kyoumutechou/feature/seat/widget/blank_seat_widget.dart';
import 'package:kyoumutechou/shared/http/app_exception.dart';

// 出欠（日）widget
class AttendancePage extends ConsumerWidget {
  AttendancePage({super.key});

// draw key
  final GlobalKey<ScaffoldState> _attendanceKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageType = ref.watch(attendancePageTypeProvider);
    final buttonEnable = ref.watch(buttonEnableProvider);

    return CommonPage(
      scaffoldKey: _attendanceKey,
      contentWidget:
          pageType == PageType.seat ? const Gridview() : const ListView(),
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
class Gridview extends ConsumerStatefulWidget {
  const Gridview({super.key});

  @override
  ConsumerState<Gridview> createState() => _GridviewState();
}

class _GridviewState extends ConsumerState<Gridview> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final list = Boxes.getAttendanceMeibo().values.toList();
      if (list.isEmpty) {
        ToastHelper.showToast(context, '　該当データがありません　');
      }
      final isHogo = list.where((e) {
        try {
          final jokyo = e.jokyoList!.first;
          if (jokyo.isEditable == false) {
            return true;
          } else {
            return false;
          }
        } catch (ex) {
          return false;
        }
      }).toList();

      if (isHogo.isNotEmpty && isHogo.length == list.length) {
        ToastHelper.showToast(context, '　既に保護されているため、編集・保存することができません。　');
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(attendanceMeiboListProvider);
    final lp = ref.watch(lecternPositionProvider);
    
    return state.when(
      loading: () {
        return const Center(child: CircularProgressIndicator());
      },
      error: (AppException e) {
        return Text(e.toString());
      },
      loaded: () {
        setState(() {});
        return ValueListenableBuilder(
          valueListenable: Boxes.getAttendanceMeibo().listenable(),
          builder: (context, Box<AttendanceMeiboModel> box, _) {
            final meibos = box.values.toList();
            final newMeibos = <AttendanceMeiboModel>[];
            
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
            final seats = Boxes.getSeatChart().values.toList();
            if (seats.isNotEmpty) {
              seats.sort((a, b) => a.seatIndex!.compareTo(b.seatIndex!));

              final setting = ref.watch(seatSettingProvider);
              final m = setting.row!;
              final n = setting.column!;
              gridColumnCount = n;

              // 座席ごとにデータを設定する
              for (var i = 0; i < m * n; i++) {
                
                var meibo = const AttendanceMeiboModel(
                  studentKihonId: 0,
                  studentSeq: '0',
                );

                try{
                  final seatData = seats.firstWhere((e) => e.seatIndex == i);

                  // 席無し情報の設定
                  if (seatData.seatNumber == 0) {
                    meibo = const AttendanceMeiboModel(
                      studentKihonId: -1,
                      studentSeq: '-1',
                    ); 
                  }

                  // 生徒情報の設定
                  if (seatData.seitoSeq != '0' && seatData.seitoSeq != null){
                    meibo = meibos
                        .firstWhere((e) => e.studentSeq == seatData.seitoSeq);
                  }
                }catch(e){
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
                    child: AttendanceSeatWidget(
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
