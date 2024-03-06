import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kyoumutechou/feature/attendance/model/attendance_meibo_model.dart';
import 'package:kyoumutechou/feature/seat/provider/seat_chart_provider.dart';
import 'package:kyoumutechou/feature/seat/widget/no_seat_widget.dart';

class SeatChartSeitoForStackWidget extends ConsumerWidget {
  SeatChartSeitoForStackWidget({
    required this.seatIndex,
    required this.seatNumber,
    required this.meibo,
    super.key,
  });

  final int seatIndex;
  final int seatNumber;
  final AttendanceMeiboModel meibo;
  final _baseUrl = dotenv.env['BASE_URL']!;
  final accessToken = Hive.box<String>('shusekibo').get('token').toString();

  String get url => '$_baseUrl${meibo.photoUrl}';

  Text getText(String text, int maxLines) {
    return Text(
      text,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      softWrap: false,
      style: const TextStyle(
        fontSize: 12,
        color: Colors.black,
        decoration: TextDecoration.none,
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stackNo = ref.watch(seatChartStackFocusProvider);
    final isOn = stackNo == seatIndex;

    if (meibo.studentKihonId! < 0) {
      return Container(
        decoration: BoxDecoration(
          color: isOn 
              ?Colors.green.withOpacity(0.3)
              :Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: const NoSeatWidget(
          width: 150,
          height: 70,
        ),
      );
    }

    return DragTarget<int>(
      onAccept: (index) {
        ref.read(seatChartListProvider.notifier).changeStackSeatWithId(
              fromSeatIndex: index,
              toSeatIndex: seatIndex,
            );
      },
      builder: (context, candidateData, rejectedData) {
        return Draggable<int>(
          data: seatIndex,
          feedback: buildContainer(isOn: isOn),
          childWhenDragging: Container(),
          child: buildContainer(isOn: isOn),
        );
      },
    );
  }

  Widget buildContainer({required bool isOn}) {
    return Container(
      width: 142,
      height: 62,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: isOn  
                ? Colors.green.withOpacity(0.5)
                : Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
        border: isOn
            ? Border.all(color: Colors.green, width: 2)
            : Border.all(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          if (meibo.studentKihonId! > 0) ...[
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(
                    url,
                    headers: {'Authorization': 'Bearer $accessToken'},
                  ),
                  backgroundColor: Colors.white,
                  radius: 20,
                ),
                Expanded(
                  child: Column(
                    children: [
                      Center(
                        child: getText(meibo.studentNumber ?? '', 1),
                      ),
                      getText(meibo.name ?? '', 2),
                    ],
                  ),
                ),
              ],
            ),
            Center(
              child: getText('$seatNumber', 1),
            ),
          ],
          if (meibo.studentKihonId! == 0) ...[
            Icon(
              Icons.chair_alt_outlined,
              color: Colors.grey[600],
              size: 30,
            ),
            if (seatNumber >= 0)
              getText('$seatNumber', 1),
          ],
        ],
      ),
    );
  }
}

SeatChartSeitoForStackWidget getStackNoChair({
  required int index,
  required int seatNumber,
}) {
  // Add your code here
  return SeatChartSeitoForStackWidget(
    seatIndex: index,
    seatNumber: seatNumber,
    //
    key: ValueKey(index),
    meibo: const AttendanceMeiboModel(
      studentKihonId: -1,
      studentSeq: '-1',
      name: '席無し',
    ),
  );
}

SeatChartSeitoForStackWidget getStackClearChair({
  required int index,
  required int seatNumber,
}) {
  // Add your code here
  return SeatChartSeitoForStackWidget(
    seatIndex: index,
    seatNumber: seatNumber,
    //
    key: ValueKey(index),
    meibo: const AttendanceMeiboModel(
      studentKihonId: 0,
      studentSeq: '0',
      name: '空席',
    ),
  );
}
