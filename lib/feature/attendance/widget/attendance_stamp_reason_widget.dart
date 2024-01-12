import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kyoumutechou/feature/attendance/provider/attendance_provider.dart';
import 'package:kyoumutechou/feature/attendance/widget/attendance_reason_widget.dart';
import 'package:kyoumutechou/feature/attendance/widget/attendance_stamp_regist_widget.dart';
import 'package:kyoumutechou/feature/attendance/widget/attendance_stamp_unregist_widget.dart';
import 'package:kyoumutechou/helpers/widgets/my_spacing.dart';


class AttendanceStampReasonWidget extends ConsumerStatefulWidget {
  const AttendanceStampReasonWidget({super.key});

  @override
  AttendanceStampReasonState createState() => AttendanceStampReasonState();
}

class AttendanceStampReasonState 
  extends ConsumerState<AttendanceStampReasonWidget> {
  

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isExpend = ref.watch(attendanceStampReasonExpend);

    return Column(
      children: [
        Row(
          children: [
            // 010:スタンプバー
            MySpacing.width(20),
            Transform.rotate(
              angle: pi / 4,
              child: const Icon(
                Icons.approval_outlined,
              ),
            ),
            SizedBox(
              width: 70,
              child: Container(
                padding: MySpacing.x(4),
                alignment: Alignment.topRight,
                child: const Text('出欠\n状況', textAlign: TextAlign.center),
              ),
            ),
            MySpacing.width(12),
            const AttendanceStampRegistWidget(),
            MySpacing.width(8),
            IconButton(
              onPressed: () {
                ref.read(attendanceStampReasonExpend.notifier).state =
                    !isExpend;
              },
              icon: isExpend
                  ? const Icon(Icons.expand_less)
                  : const Icon(Icons.expand_more),
            ),

            // 020:理由ドロップボックス
            Expanded(
              child: Container(),
            ),
            const AttendanceReasonWidget(),
          ],
        ),
        if (isExpend)
          const Row(
            children: [
              SizedBox(
                width: 126,
              ),
              AttendanceStampUnregistWidget(),
            ],
          ),
      ],
    );
  }
}
