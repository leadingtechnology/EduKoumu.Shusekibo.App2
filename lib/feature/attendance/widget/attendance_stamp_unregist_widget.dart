import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kyoumutechou/feature/attendance/model/attendance_reason_model.dart';
import 'package:kyoumutechou/feature/attendance/provider/attendance_reason_provider.dart';
import 'package:kyoumutechou/feature/attendance/provider/attendance_stamp_provider.dart';
import 'package:kyoumutechou/feature/boxes.dart';
import 'package:kyoumutechou/helpers/theme/app_theme.dart';

class AttendanceStampUnregistWidget extends ConsumerWidget {
  const AttendanceStampUnregistWidget({ super.key });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedStamp = ref.watch(attendanceStampProvider);
    final stamps = Boxes.getUnregistAttendanceStamp().values.toList();
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
            
            ref.read(attendanceReason1Provider.notifier).state =
                const AttendanceReasonModel();

            ref.read(attendanceReason2Provider.notifier).state =
                const AttendanceReasonModel();

          },
          borderColor: theme.colorScheme.outlineVariant,
          selectedBorderColor: theme.colorScheme.primary,
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
