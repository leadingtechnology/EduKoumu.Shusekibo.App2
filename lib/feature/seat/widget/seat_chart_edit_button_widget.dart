import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kyoumutechou/feature/boxes.dart';
import 'package:kyoumutechou/feature/common/provider/common_provider.dart';
import 'package:kyoumutechou/feature/common/provider/filter_provider.dart';
import 'package:kyoumutechou/feature/seat/provider/seat_chart_provider.dart';
import 'package:kyoumutechou/feature/seat/widget/seat_chart_seito_for_stack_widget.dart';

// 座席表編集ボタン
class SeatChartEditButtonWidget extends ConsumerStatefulWidget {
  const SeatChartEditButtonWidget({
    required this.id,
    required this.targetDate,
    super.key,
  });

  final int id;
  final DateTime targetDate;

  @override
  ConsumerState<SeatChartEditButtonWidget> createState() =>
      _SeatChartEditButtonWidgetState();
}

class _SeatChartEditButtonWidgetState
    extends ConsumerState<SeatChartEditButtonWidget> {

  final seatChartBox = Boxes.getSeatChart();
  final seatSettingBox = Boxes.getSeatSetting();

  bool _isButtonEnabled = true; // ボタン有効フラグ

  @override
  void initState() {
    super.initState();
  }

  // 座席表詳細設定画面データの初期化
  Future<void> _doAsyncTask() async {
    // ボタン無効化
    setState(() {
      _isButtonEnabled = false;
    });
    
    ref.read(seatSettingIdProvider.notifier).state = widget.id;

    // 1) 名簿取得 -- 開始日により在籍の生徒を取得する。
    final meibos = await ref.read(seatChartListProvider.notifier).getMeibos(
          ref.read(filterProvider),
          widget.targetDate,
        );

    // 2) 座席設定IDにより、座席表の詳細設定を取得する(hive box)
    await ref.read(seatChartListProvider.notifier).fetch(widget.id);
    final seatCharts = seatChartBox.values.toList();

    // 3) 座席表の詳細設定により、座席表の初期化を行う。
    final scMeibos = <SeatChartSeitoForStackWidget>[];
    for (var i = 0; i < seatCharts.length; i++) {
      final sc = seatCharts[i];

      // 席無しの追加
      if (sc.seatNumber == 0 || sc.seitoSeq == '-1') {
        scMeibos.add(
          getStackNoChair(
            index: i,
            seatNumber: 0,
          ),
        );
      }else if(sc.seitoSeq == '0'){
        // 空席の追加
        scMeibos.add(
          getStackClearChair(
            index: i,
            seatNumber: sc.seatNumber ?? 0,
          ),
        );
      }else{
        // 生徒情報の追加
        final meibo = meibos.firstWhere(
          (e) => e.studentSeq == sc.seitoSeq,
        );
        scMeibos.add(
          SeatChartSeitoForStackWidget(
            seatIndex: i,
            seatNumber: sc.seatNumber ?? 0,
            meibo: meibo,
          ),
        );
      }
    }

    final newScMeibos =
        await ref.read(seatChartListProvider.notifier).resetSeatNumber(
              widget.id,
              scMeibos,
            );

    // 6) 設定用座席表の設定
    ref.read(scMeibosStackProvider.notifier).state = newScMeibos;
    
    // 7) 初期フォーカスの設定
    newScMeibos.sort((a, b) => a.seatNumber.compareTo(b.seatNumber));
    for (final m in newScMeibos) {
      if (m.meibo.studentSeq == '0') {
        ref.read(seatChartStackFocusProvider.notifier).state = m.seatIndex;
        break;
      }
    }

    // 8) meibosからseatChartsに存在する生徒を削除
    for (final seatChart in seatCharts) {
      meibos.removeWhere((meibo) => meibo.studentSeq == seatChart.seitoSeq);
    }

    // 8) 選択可能な生徒リストの設定
    ref.read(scMeibosListProvider.notifier).state = meibos;
    // リスト座席のフォーカス設定
    if (meibos.isNotEmpty) {
      ref.read(seatChartListFocusProvider.notifier).state =
          meibos[0].studentKihonId!;
    } else {
      ref.read(seatChartListFocusProvider.notifier).state = -1;
    }

    // 画面遷移
    ref.read(seatChartPageTypeProvider.notifier).state = PageType.seat;
    
    // ボタン有効化
    setState(() {
      _isButtonEnabled = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: _isButtonEnabled ? _doAsyncTask : null,
      icon: const Icon(Icons.edit),
      label: const Text('座席表編集'),
      style: ElevatedButton.styleFrom(
        side: BorderSide(
          color: Colors.green.shade200, // 枠線の色
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
