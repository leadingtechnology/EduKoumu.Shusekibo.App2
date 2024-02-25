import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:kyoumutechou/feature/attendance/model/attendance_meibo_model.dart';
import 'package:kyoumutechou/feature/seat/provider/seat_chart_provider.dart';
import 'package:kyoumutechou/feature/seat/widget/seat_chart_seito_for_List_widget.dart';

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
  
  @override
  Widget build(BuildContext context) {
    meibos = ref.watch(scMeibosListProvider);
    meibos.sort((AttendanceMeiboModel a, AttendanceMeiboModel b) {
      var inta = 0;
      try {
        inta = int.parse('${a.studentNumber!}');
      } catch (e) {
        inta = 0;
      }

      if (inta == 0) {
        return -1;
      }
      
      var intb = 0;
      try {
        intb = int.parse(b.studentNumber!);
      } catch (e) {
        intb = 0;
      }
      
      return inta.compareTo(intb);
    });

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
