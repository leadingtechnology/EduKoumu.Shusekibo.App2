import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kyoumutechou/feature/attendance/model/attendance_meibo_model.dart';
import 'package:kyoumutechou/feature/seat/provider/seat_chart_provider.dart';

class SeatChartSeitoForStackWidget extends ConsumerWidget {
  SeatChartSeitoForStackWidget({
    required this.seatIndex,
    required this.seatNumber,
    required this.meibo,
    super.key,
  });

  final int seatIndex;
  int seatNumber;
  final AttendanceMeiboModel meibo;
  final _baseUrl = dotenv.env['BASE_URL']!;
  final accessToken = Hive.box<String>('shusekibo').get('token').toString();

  String get url => '$_baseUrl${meibo.photoUrl}';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    
    final stackNo = ref.watch(seatChartStackFocusProvider);
    final isOn = stackNo == seatIndex;

    return Draggable<AttendanceMeiboModel>(
      data: meibo,
      feedback: buildContainer(isOn : isOn),
      childWhenDragging: Container(), 
      child: buildContainer(isOn: isOn),
    );
  }

  Widget buildContainer({required bool isOn}) {
    return Container(
      width: 150,
      height: 70,
      padding: const EdgeInsets.fromLTRB(4, 4, 4, 4),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
        border: isOn
            ? Border.all(color: Colors.green, width: 3)
            : Border.all(color: Colors.green.shade200),
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
                  radius: 20,
                ),
                Expanded(child: Column(children: [
                    Center(
                      child: Text('${meibo.studentNumber}'),
                    ),
                  Text(
                meibo.name ?? '',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                softWrap: false,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.black,
                  decoration: TextDecoration.none,
                ),
              ),
                ],),),
              ],
            ),
            Expanded(
              child: Text(
                meibo.name ?? '',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                softWrap: false,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.black,
                  decoration: TextDecoration.none,
                ),
              ),
            ),
            Center(child: Text('$seatNumber'),),
          ],
          if (meibo.studentKihonId! == 0) ...[
            Icon(
              Icons.chair_alt_outlined,
              color: Colors.grey[600],
              size: 30,
            ),
            if (seatNumber >=  0)
              Text(
                  '$seatNumber',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.black,
                  decoration: TextDecoration.none,
                ),
              ),
          ],
          if (meibo.studentKihonId! < 0) ...[
            const Center(
              child: Text(
                '(席無し)',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.black,
                  decoration: TextDecoration.none,
                ),
              ),
            ),
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
