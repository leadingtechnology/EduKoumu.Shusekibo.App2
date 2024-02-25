import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:kyoumutechou/feature/attendance/model/attendance_meibo_model.dart';
import 'package:kyoumutechou/feature/seat/provider/seat_chart_provider.dart';
import 'package:kyoumutechou/feature/seat/widget/seat_chart_seito_for_List_widget.dart';
import 'package:kyoumutechou/feature/seat/widget/seat_chart_seito_for_stack_widget.dart';

class SeatChartMeiboListWidget extends ConsumerStatefulWidget {
  const SeatChartMeiboListWidget({super.key});

  @override
  ConsumerState<SeatChartMeiboListWidget> createState() 
  => _SeatChartMeiboListWidgetState();
}

class _SeatChartMeiboListWidgetState 
extends ConsumerState<SeatChartMeiboListWidget> {

  final accessToken = Hive.box<String>('shusekibo').get('token').toString();
  late List<AttendanceMeiboModel> meibos;

  @override
  void initState() {
    super.initState();
  }
  
  // Future<void> _clearChair() async{
  //   final seatSettingId = ref.read(seatSettingIdProvider);
  //   ref.read(seatChartListFocusProvider.notifier).state = -1;

  //   await ref.read(seatChartListProvider.notifier).setStackSeat(
  //     seatSettingId,
  //     0,
  //   );
  //   //meibos = ref.watch(scMeibosListProvider);
  // }

  // Future<void> _setStackSeat(int index) async {
  //   final seatSettingId = ref.read(seatSettingIdProvider);
    
  //   await ref.read(seatChartListProvider.notifier).setStackSeat(
  //     seatSettingId,
  //     meibos[index].studentKihonId ?? 0,
  //   );
  // }


  
  void _removeItem(int index) {
    final meibo = meibos[index];

    // stack 設定index
    final no = ref.read(seatChartStackFocusProvider);
    // stack 座席表
    final scMeibos = ref.read(scMeibosStackProvider);

    final newScMeibos = <SeatChartSeitoForStackWidget>[];
    SeatChartSeitoForStackWidget? scMeibo;
    for (var i = 0; i < scMeibos.length; i++) {
      if (scMeibos[i].seatIndex != no) {
        newScMeibos.add(scMeibos[i]);
      }else{
        scMeibo = scMeibos[i];
        newScMeibos.add(
          SeatChartSeitoForStackWidget(
            seatIndex: no,
            seatNumber: scMeibos[i].seatNumber,
            meibo: meibo,
          ),
        );
      }
    }
    ref.read(scMeibosStackProvider.notifier).state = newScMeibos;

    // stack フォーカスの設定
    if (scMeibo != null) {
      scMeibos.sort((a, b) => a.seatNumber.compareTo(b.seatNumber));
      for (var i = 0; i < scMeibos.length; i++) {
        if (scMeibos[i].seatNumber > scMeibo.seatNumber &&
            scMeibos[i].meibo.studentSeq == '0') {

          ref.read(seatChartStackFocusProvider.notifier).state = scMeibos[i].seatIndex;
          break;
        }
      }
    }

    setState(() {
      meibos.removeAt(index);
    });

  }

  @override
  Widget build(BuildContext context) {
    meibos = ref.watch(scMeibosListProvider);

    return SizedBox(
      height: 80,
      child: Row(
        children: [
          GestureDetector(
            onTap: () => ref.read(seatChartListFocusProvider.notifier).state=-1,
            onDoubleTap: () async{
              await ref
                  .read(seatChartListProvider.notifier)
                  .setStackSeatWithNoSeat();
            },
            child: getNoChair(isStack: false, seatNumber: -1),
          ),
          // const SizedBox(width: 8),
          // GestureDetector(
          //   onTap: () => ref.read(seatChartListFocusProvider.notifier).state = 0,
          //   child: getBlankChair(isStack: false, seatNumber: -1),
          // ),
          // 間隔線
          Container(
            margin: const EdgeInsets.only(left: 8, right: 8),
            color: Colors.grey,
            height: 100,
            child: const VerticalDivider(width: 1),
          ),
          // 選択可能な生徒リスト
          Expanded(
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                const SizedBox(width: 8),
                for (var i = 0; i < meibos.length; i++) ...[
                  GestureDetector(
                    onDoubleTap: () async{
                      await ref
                          .read(seatChartListProvider.notifier)
                          .setStackSeatWithMeibo(meibo: meibos[i]);
                    },
                    onTap: () {
                      ref.read(seatChartListFocusProvider.notifier).state = 
                      meibos[i].studentKihonId!;
                    } ,
                    child: SeatChartSeitoForListWidget(
                      meibo: meibos[i],
                      seatNumber: -1,
                      key: ValueKey(meibos[i].studentKihonId),
                    ),
                  ),
                  const SizedBox(width: 8),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
