import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:kyoumutechou/feature/attendance/model/attendance_meibo_model.dart';
import 'package:kyoumutechou/feature/boxes.dart';
import 'package:kyoumutechou/feature/seat/model/seat_chart_model.dart';
import 'package:kyoumutechou/feature/seat/model/seat_setting_model.dart';
import 'package:kyoumutechou/feature/seat/provider/seat_chart_provider.dart';
import 'package:kyoumutechou/feature/seat/widget/seat_chart_seito_widget.dart';

class SeatChartMeiboStackWidget extends ConsumerStatefulWidget {
  const SeatChartMeiboStackWidget({super.key});

  @override
  ConsumerState<SeatChartMeiboStackWidget> createState() =>
      _SeatChartMeiboStackWidgetState();
}

class _SeatChartMeiboStackWidgetState
    extends ConsumerState<SeatChartMeiboStackWidget> {
  final accessToken = Hive.box<String>('shusekibo').get('token').toString();

  final meiboBox = Boxes.getAttendanceMeibo();
  final seatSettingBox = Boxes.getSeatSetting();
  final seatChartBox = Boxes.getSeatChart();

  late List<AttendanceMeiboModel> meibos;
  late List<SeatChartModel> seatCharts;
  late SeatSettingModel seatSetting;

  List<SeatChartSeitoWidget> chairs = [];
  late int cols;
  late int rows;

  final double boxWidth = 90;
  final double boxHeight = 70;

  @override
  void initState() {
    super.initState();

    // 名簿リストの取得
    meibos = meiboBox.values.toList();

    // 座席表リストの取得
    seatCharts = seatChartBox.values.toList();

    // 座席表設定情報の取得
    final id = ref.read(seatSettingIdProvider);
    seatSetting = seatSettingBox.values.firstWhere(
      (element) => element.id == id,
    );

    rows = seatSetting.row ?? 1;
    cols = seatSetting.column ?? 1;

    for (var i = 0; i < rows * cols; i++) {
      // 席番号の指定
      final seatNumber = i + 1;

      // 座席表リストから席番号が一致する席情報を取得
      if (seatCharts.isEmpty) {
        // 010.席情報がない場合、空席として表示する
        chairs.add(
          getBlankChair(
            isStack: true,
            seatNumber: seatNumber,
          ),
        );
        continue;
      } else {
        final seatChart = seatCharts.firstWhere(
          (element) => element.seatNumber == seatNumber,
        );

        // 020.席情報がない場合、空席として表示する
        if (seatChart == null) {
          chairs.add(
            getBlankChair(
              isStack: true,
              seatNumber: seatNumber,
            ),
          );
          continue;
        }

        // 030.生徒情報がない場合、空席として表示する
        if (seatChart.seitoSeq == 0) {
          chairs.add(
            getBlankChair(
              isStack: true,
              seatNumber: seatNumber,
            ),
          );
          continue;
        }

        // 040.席がない場合、空白として表示する
        if (seatChart.seitoSeq == -1) {
          chairs.add(
            getNoChair(
              isStack: true,
              seatNumber: seatNumber,
            ),
          );
          continue;
        }

        // 席情報の生徒シーケンス番号が>0の場合、生徒情報を表示する
        final meibo = meibos.firstWhere(
          (e) => e.studentKihonId == seatChart.seitoSeq,
        );
        chairs.add(
          SeatChartSeitoWidget(
            meibo: meibo,
            isStack: true,
            seatNumber: seatNumber,
            key: ValueKey(seatNumber),
          ),
        );
      }
    }
  }

  void removeItem(int i) {
    // Widgetの場所により、選択状態の取得方法が異なる
    final kihonId = ref.watch(seatChartListFocusProvider);
    final oldKihonId = chairs[i].meibo.studentKihonId ?? 0;
    var newKihonId = 0;

    setState(() {
      var isDelete = false;

      // 座席の設定
      if (kihonId == -1) {
        chairs[i] = getNoChair(
          isStack: true,
          seatNumber: i + 1,
        );
      } else if (kihonId == 0) {
        chairs[i] = getBlankChair(
          isStack: true,
          seatNumber: i + 1,
        );
      } else {
        final meibo = meibos.firstWhere(
          (e) => e.studentKihonId == kihonId,
        );
        chairs[i] = SeatChartSeitoWidget(
          meibo: meibo,
          isStack: true,
          seatNumber: i + 1,
          key: ValueKey(i + 1),
        );

        isDelete = true;
      }

      // 生徒リストの更新
      if (oldKihonId > 0 || isDelete) {
        // リストを更新する
        final currentList = ref.read(scMeiboListProvider.notifier).state;

        var newList = currentList;
        if (isDelete) {
          // 削除対象インデックス
          final index = currentList.indexWhere(
            (e) => e.studentKihonId == kihonId,
          );

          if (index >= currentList.length - 1) {
            if (index == 0) {
              newKihonId = 0;
            } else {
              newKihonId = currentList[index - 1].studentKihonId!;
            }
          } else {
            newKihonId = currentList[index + 1].studentKihonId!;
          }

          newList = currentList
              .where(
                (e) => e.studentKihonId != kihonId,
              )
              .toList();
        }

        if (oldKihonId > 0) {
          newList.add(
            meibos.firstWhere(
              (e) => e.studentKihonId == oldKihonId,
            ),
          );
        }
        ref.read(scMeiboListProvider.notifier).state = newList;

        if (oldKihonId > 0) {
          ref.read(seatChartListFocusProvider.notifier).state = oldKihonId;
        } else {
          ref.read(seatChartListFocusProvider.notifier).state = newKihonId;
        }
      }
    });
  }

  void setSeito(int i, AttendanceMeiboModel meibo) {
    setState(() {
      chairs[i] = SeatChartSeitoWidget(
        key: ValueKey(i),
        isStack: true,
        seatNumber: i + 1,
        meibo: meibo,
      );
    });
  }

  void setChair(int i) {
    setState(() {
      chairs[i] = getNoChair(
        isStack: true,
        seatNumber: i + 1,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final cellWidth = (constraints.maxWidth) ~/ cols;
        final cellHeight = (constraints.maxHeight - 8) ~/ rows;

        var p = 1.0;
        if (cellWidth < boxWidth || cellHeight < boxHeight) {
          if (cellWidth < boxWidth) {
            p = cellWidth / boxWidth;
          }
          if (cellHeight < boxHeight && (cellHeight / boxHeight < p)) {
            p = cellHeight / boxHeight;
          }
        }

        p = (p * 100).truncateToDouble() / 100;

        final xoffset = (cellWidth - boxWidth * p) / 2;
        final yoffset = (cellHeight - boxHeight * p) / 2;

        // print('width: ${constraints.maxWidth}, hight: ${constraints.maxHeight}');
        // print('cellW: $cellWidth, cellH: $cellHeight');
        // print('boxWidth: ${cellWidth * p}, boxHeight: ${cellHeight * p}');
        // print('xoffset: $xoffset, yoffset: $yoffset');
        // print('p: $p ');

        return Stack(
          fit: StackFit.expand,
          children: List.generate(chairs.length, (i) {
            final row = i ~/ cols;
            final col = i % cols;

            var top = row * cellHeight * 1.0;
            var left = col * cellWidth * 1.0;

            return Positioned(
              top: top + yoffset,
              left: left + xoffset,
              child: DragTarget<AttendanceMeiboModel>(
                onWillAccept: (data) => true,
                onAccept: (data) {
                  setState(() {
                    final meibo = data as AttendanceMeiboModel;
                    final kihonId = meibo.studentKihonId ?? 0;

                    chairs[i] = SeatChartSeitoWidget(
                      key: ValueKey(i),
                      isStack: true,
                      seatNumber: i + 1,
                      meibo: meibo,
                    );
                    // データの交換
                    // int temp = chairs[data];
                    // items[data] = items[index];
                    // items[index] = temp;
                  });
                },
                builder: (context, candidateData, rejectedData) {
                  return GestureDetector(
                    onDoubleTap: () {
                      removeItem(i);
                    },
                    onTap: () {
                      ref.read(seatChartStackFocusProvider.notifier).state =
                          i + 1;
                    },
                    child: Transform.scale(
                      scale: p,
                      child: chairs[i],
                    ),
                  );
                },
              ),
            );
          }),
        );
      },
    );
  }
}
