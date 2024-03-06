import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kyoumutechou/feature/attendance/model/attendance_meibo_model.dart';
import 'package:kyoumutechou/feature/seat/provider/seat_chart_provider.dart';

class SeatChartSeitoForListWidget extends ConsumerWidget {
  SeatChartSeitoForListWidget({
    required this.seatNumber,
    required this.meibo,
    super.key,
  });

  final int seatNumber;
  final AttendanceMeiboModel meibo;
  final _baseUrl = dotenv.env['BASE_URL']!;
  final accessToken = Hive.box<String>('shusekibo').get('token').toString();

  String get url => '$_baseUrl${meibo.photoUrl}';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Widgetの場所により、選択状態の取得方法が異なる
    final kihonId = ref.watch(seatChartListFocusProvider);
    final seatNo = ref.watch(seatChartStackFocusProvider);

    bool isOn = kihonId == meibo.studentKihonId;

    return buildContainer(isOn: isOn);
    // return Draggable<AttendanceMeiboModel>(
    //   data: meibo,
    //   feedback: buildContainer(isOn: isOn),
    //   //childWhenDragging: buildContainer(isOn: isOn),
    //   childWhenDragging: meibo.studentKihonId != -1
    //       ? const BlankSeatWidget(
    //           width: 110,
    //           height: 80,
    //         )
    //       : buildContainer(isOn: isOn),
    //   child: buildContainer(isOn: isOn),
    // );
  }

  Widget buildContainer({required bool isOn}) {
    return Container(
      width: 110,
      height: 80,
      padding: const EdgeInsets.fromLTRB(4, 4, 4, 4),
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
            : Border.all(color: Colors.grey.shade500),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // 生徒widget
          if (meibo.studentKihonId! > 0) ...[
            CircleAvatar(
              backgroundImage: NetworkImage(
                url,
                headers: {'Authorization': 'Bearer $accessToken'},
              ),
              backgroundColor: Colors.white,
              radius: 20,
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const SizedBox(width: 8),
                  showText(meibo.studentNumber),
                  const SizedBox(width: 8),
                  Expanded(
                    child: showText(meibo.name),
                  ),
                ],
              ),
            ),
          ],

          // 空席widget
          if (meibo.studentKihonId! == 0) ...[
            Icon(
              Icons.chair_alt_outlined,
              color: Colors.grey[600],
              size: 30,
            ),
            if (seatNumber >= 0)
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

          // 席なしwidget
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

  Text showText(String? text) {
    return Text(
      text ?? '',
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
      softWrap: false,
      style: const TextStyle(
        fontSize: 12,
        color: Colors.black,
        decoration: TextDecoration.none,
      ),
    );
  }
}

SeatChartSeitoForListWidget getNoChair({
  required bool isStack,
  required int seatNumber,
}) {
  // Add your code here
  return SeatChartSeitoForListWidget(
    meibo: const AttendanceMeiboModel(
      studentKihonId: -1,
      studentSeq: '-1',
      name: '席無し',
    ),
    seatNumber: seatNumber,
    key: const ValueKey(-1),
  );
}

SeatChartSeitoForListWidget getBlankChair({
  required bool isStack,
  required int seatNumber,
}) {
  // Add your code here
  return SeatChartSeitoForListWidget(
    meibo: const AttendanceMeiboModel(
      studentKihonId: 0,
      studentSeq: '0',
      name: '空席',
    ),
    seatNumber: seatNumber,
    key: const ValueKey(0),
  );
}
