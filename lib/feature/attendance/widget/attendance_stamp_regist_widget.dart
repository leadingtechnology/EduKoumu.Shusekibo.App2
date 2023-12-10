import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kyoumutechou/feature/attendance/provider/attendance_stamp_provider.dart';
import 'package:kyoumutechou/feature/boxes.dart';

class AttendanceStampRegistWidget extends ConsumerWidget {
  const AttendanceStampRegistWidget({ super.key });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedStamp = ref.watch(attendanceStampProvider);
    final stamps = Boxes.getRegistAttendanceStamp().values.toList();

    final isSelected = stamps
        .map(
          (e) => e.shukketsuJokyoCd == selectedStamp.shukketsuJokyoCd,
        )
        .toList();
    return Row(
      children: [
        ToggleButtons(
          constraints: const BoxConstraints.expand(width: 50),
          fillColor: Theme.of(context).colorScheme.secondaryContainer,
          onPressed: (int index) {
            ref.read(attendanceStampProvider.notifier).state = stamps[index];
          },
          isSelected: isSelected,
          children: stamps.map((e) {
            var fontSize = 15.0;
            if (e.shukketsuJokyoCd == '001' || e.shukketsuJokyoCd == '999') {
              fontSize = 13.0;
            }
            return SizedBox(
              height: 40,
              width: 100,
              child: Tooltip(
                message: '${e.shukketsuJokyoNmTsu}',
                preferBelow: false,
                child: Center(
                  child: Text(
                    '${e.shukketsuJokyoNmRyaku}',
                    style: TextStyle(fontSize: fontSize),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );        

  }  
}
