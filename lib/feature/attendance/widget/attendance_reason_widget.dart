import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kyoumutechou/feature/attendance/model/attendance_reason_model.dart';
import 'package:kyoumutechou/feature/attendance/provider/attendance_reason_provider.dart';
import 'package:kyoumutechou/feature/attendance/provider/attendance_stamp_provider.dart';
import 'package:kyoumutechou/feature/boxes.dart';
import 'package:kyoumutechou/helpers/widgets/my_spacing.dart';
import 'package:kyoumutechou/shared/http/app_exception.dart';


class AttendanceReasonWidget extends ConsumerWidget {
  const AttendanceReasonWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(attendanceReasonListProvider);
    final stamp = ref.watch(attendanceStampProvider);

    return state.when(
      loading: () {
        return Container();
      },
      error: (AppException error) {
        return Text('$error');
      },
      loaded: () {
        // 1) get reason's key by jukyoCd
        final reason1Keys = Boxes.getAttendanceReason1()
            .keys
            .where((e) => e.startsWith('${stamp.shukketsuJokyoCd}-') as bool)
            .toList();

        // 2) create drowdown item
        final reason1Items = <DropdownMenuItem<AttendanceReasonModel>>[];

        for (final k in reason1Keys) {
          final r = Boxes.getAttendanceReason1().get(k);
          reason1Items.add(
            DropdownMenuItem<AttendanceReasonModel>(
              value: r,
              child: Text('${r?.shukketsuJiyuNmSeishiki}'),
            ),
          );
        }

        if(reason1Items.length <= 1) {
          return Container();
        }

        // 3) get reason's key by jukyoCd
        final reason2Keys = Boxes.getAttendanceReason2()
            .keys
            .where((e) => e.startsWith('${stamp.shukketsuJokyoCd}-') as bool)
            .toList();

        // 4) create drowdown item
        final reason2Items = <DropdownMenuItem<AttendanceReasonModel>>[];
        for (final k in reason2Keys) {
          final r = Boxes.getAttendanceReason2().get(k);
          reason2Items.add(
            DropdownMenuItem<AttendanceReasonModel>(
              value: r,
              child: Text('${r?.shukketsuJiyuNmSeishiki}'),
            ),
          );
        }

        // 5) return dropdown widget
        return Row(
          children: [
            const Text('理由'),
            MySpacing.width(8),
            Container(
              height: 35,
              padding: MySpacing.left(4),
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(4),
              ),
              child: SizedBox(
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<AttendanceReasonModel>(
                    value: ref.watch(attendanceReason1Provider),
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontFamily: 'NotoSansJP',
                    ),
                    dropdownColor: Colors.white,
                    onChanged: (AttendanceReasonModel? newValue) {
                      ref.read(attendanceReason1Provider.notifier).state =
                          newValue!;
                    },
                    items: reason1Items.toSet().toList(),
                  ),
                ),
              ),
            ),
            MySpacing.width(4),
            if (reason2Items.length > 1 ) Container(
              height: 35,
              padding: MySpacing.left(4),
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(4),
              ),
              child: SizedBox(
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<AttendanceReasonModel>(
                    value: ref.watch(attendanceReason2Provider),
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontFamily: 'NotoSansJP',
                    ),
                    dropdownColor: Colors.white,
                    onChanged: (AttendanceReasonModel? newValue) {
                      ref.read(attendanceReason2Provider.notifier).state =
                          newValue!;
                    },
                    items: reason2Items.toSet().toList(),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
