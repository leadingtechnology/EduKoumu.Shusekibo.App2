import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kyoumutechou/feature/attendance/model/attendance_meibo_model.dart';
import 'package:kyoumutechou/feature/attendance/model/attendance_status_model.dart';
import 'package:kyoumutechou/feature/attendance/provider/attendance_meibo_provider.dart';
import 'package:kyoumutechou/feature/attendance/provider/attendance_reason_provider.dart';
import 'package:kyoumutechou/feature/attendance/provider/attendance_stamp_provider.dart';
import 'package:kyoumutechou/feature/common/provider/tokobis_provider.dart';
import 'package:kyoumutechou/helpers/widgets/my_spacing.dart';

class AttendanceSeatWidget extends ConsumerWidget {
  AttendanceSeatWidget({
    required this.index, 
    required this.meibo, 
    super.key,
  });

  final int index;
  final AttendanceMeiboModel meibo;
  final _baseUrl = dotenv.env['BASE_URL']!;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stamp = ref.watch(attendanceStampProvider);
    final reason1 = ref.watch(attendanceReason1Provider);
    final reason2 = ref.watch(attendanceReason2Provider);
    var isEditable = ref.watch(isTokobiProvider);

    Color color;
    final url = '$_baseUrl${meibo.photoUrl}';
    final accessToken = Hive.box<String>('shusekibo').get('token').toString();

    late AttendanceStatusModel jokyo;

    if (meibo.jokyoList != null && meibo.jokyoList!.isNotEmpty) {
      jokyo = meibo.jokyoList?.first ?? const AttendanceStatusModel();
      
      // 保護される場合、編集不可にする
      if (jokyo.isEditable == false){
        isEditable = false;
      }
    } else {
      jokyo = const AttendanceStatusModel();
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
        await ref.read(attendanceMeiboListProvider.notifier).updateById(
              meibo,
              stamp,
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
                          meibo.studentNumber??'',
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
