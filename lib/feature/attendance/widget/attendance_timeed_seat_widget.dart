import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kyoumutechou/feature/attendance/model/attendance_timed_meibo_model.dart';
import 'package:kyoumutechou/feature/attendance/model/attendance_timed_status_model.dart';
import 'package:kyoumutechou/feature/attendance/provider/attendance_timed_meibo_provider.dart';
import 'package:kyoumutechou/feature/attendance/provider/attendance_timed_reason_provider.dart';
import 'package:kyoumutechou/feature/attendance/provider/attendance_timed_stamp_provider.dart';
import 'package:kyoumutechou/feature/common/provider/filter_provider.dart';
import 'package:kyoumutechou/feature/common/provider/tokobis_provider.dart';
import 'package:kyoumutechou/helpers/widgets/my_spacing.dart';

class AttendanceTimedSeatWidget extends ConsumerWidget {
  AttendanceTimedSeatWidget({
    required this.index, 
    required this.meibo, 
    super.key,
  });

  final int index;
  final AttendanceTimedMeiboModel meibo;
  final _baseUrl = dotenv.env['BASE_URL']!;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stamp = ref.watch(attendanceTimedStampProvider);
    final reason1 = ref.watch(attendanceTimedReason1Provider);
    final reason2 = ref.watch(attendanceTimedReason2Provider);
    final filter = ref.watch(filterProvider);
    final isEditable = ref.watch(isTokobiProvider);

    Color color;
    final url = '$_baseUrl${meibo.photoUrl}';
    final accessToken = Hive.box<String>('shusekibo').get('token').toString();

    late AttendanceTimedStatusModel jokyo;

    if (meibo.jokyoList != null && meibo.jokyoList!.isNotEmpty) {
      try {
        jokyo = meibo.jokyoList!
            .where((e) => e.jigenIdx == filter.jigenIdx)
            .toList()
            .first;
      } catch (ex) {
        jokyo = const AttendanceTimedStatusModel();
      }
    } else {
      jokyo = const AttendanceTimedStatusModel();
    }

    // 登校日の判定
    if (isEditable){
      if (jokyo.shukketsuKbn == '' || jokyo.shukketsuKbn == null) {
        color = Theme.of(context).colorScheme.errorContainer;
      } else if (jokyo.shukketsuKbn != '101') {
        color = Theme.of(context).colorScheme.primaryContainer;
      } else {
        color = Colors.grey.withAlpha(50);
      }
    }else{
      color = const Color(0xFFDDDDDD);
    }

    return GestureDetector(
      onTap: !isEditable ? null : () async {
        await ref.read(attendanceTimedMeiboListProvider.notifier).updateById(
              meibo,
              stamp,
              filter,
              reason1,
              reason2,
            );
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 5, 5),
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(6)),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                spreadRadius: 1,
                color: Colors.black26,
                blurRadius: 2,
                offset: Offset(2, 0),
              ),
            ],
          ),
          child: Column(
            children: [
              // User Information
              Expanded(
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 4, 8, 0),
                      child:ClipOval(child: Image.network(
                        url,
                        headers: {'Authorization': 'Bearer $accessToken'},
                      ),),
                    ),
                    Expanded(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          meibo.studentNumber ?? '',
                          style: const TextStyle(fontSize: 12),
                        ),
                        Text(
                          '${meibo.name}', 
                          style: const TextStyle(fontSize: 14),
                        ),
                      ],
                    ),),
                  ],
                ),
              ),

              // status bar
              MySpacing.height(4),
              Container(
                  height: 30,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(6),
                      bottomRight: Radius.circular(6),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(jokyo.ryaku ?? ''),
                      AutoSizeText(
                        (jokyo.jiyu1 ?? '').trim(),
                        maxLines: 1, 
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),),
            ],
          ),
        ),
      ),
    );
  }
}
