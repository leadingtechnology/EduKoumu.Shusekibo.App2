import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:kyoumutechou/feature/attendance/model/attendance_meibo_model.dart';
import 'package:kyoumutechou/feature/seat/provider/seat_chart_provider.dart';
import 'package:kyoumutechou/feature/seat/widget/seat_chart_seito_widget.dart';

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

  void _removeItem(int index) {
    setState(() {
      meibos.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    meibos = ref.watch(scMeiboListProvider);

    return SizedBox(
      height: 80,
      child: Row(
        children: [
          GestureDetector(
            onTap: () => ref.read(seatChartListFocusProvider.notifier).state = -1,
            child: getNoChair(isStack: false, seatNumber: -1),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: () => ref.read(seatChartListFocusProvider.notifier).state = 0,
            child: getBlankChair(isStack: false, seatNumber: -1),
          ),
          Container(
            margin: const EdgeInsets.only(left: 8, right: 8),
            color: Colors.grey,
            height: 100,
            child: const VerticalDivider(width: 1),
          ),
          Expanded(
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                const SizedBox(width: 8),
                for (var i = 0; i < meibos.length; i++) ...[
                  GestureDetector(
                    onDoubleTap: () => _removeItem(i),
                    onTap: () => ref.read(seatChartListFocusProvider.notifier).state = meibos[i].studentKihonId!,
                    child: SeatChartSeitoWidget(
                      meibo: meibos[i],
                      isStack: false,
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
