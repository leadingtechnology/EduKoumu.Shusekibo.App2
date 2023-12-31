import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kyoumutechou/feature/common/provider/tokobis_provider.dart';
import 'package:kyoumutechou/feature/health/model/health_meibo_model.dart';
import 'package:kyoumutechou/feature/health/model/health_status_model.dart';
import 'package:kyoumutechou/feature/health/provider/health_meibo_provider.dart';
import 'package:kyoumutechou/feature/health/provider/health_reason_provider.dart';
import 'package:kyoumutechou/feature/health/provider/health_stamp_provider.dart';
import 'package:kyoumutechou/helpers/widgets/my_spacing.dart';


class HealthSeatWidget extends ConsumerWidget {
  HealthSeatWidget({
    required this.index, 
    required this.healthMeibo, 
    super.key,
  });

  final int index;
  final HealthMeiboModel healthMeibo;
  final String _baseUrl = dotenv.env['BASE_URL']!;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stamp = ref.watch(healthStampProvider);
    final reason1 = ref.watch(healthReason1Provider);
    final reason2 = ref.watch(healthReason2Provider);
    final isEditable = ref.watch(isTokobiProvider);

    Color color;
    final url = '$_baseUrl${healthMeibo.photoUrl}';
    final accessToken = Hive.box<String>('shusekibo').get('token').toString();

    late HealthStatusModel jokyo;
    
    if (healthMeibo.jokyoList != null && healthMeibo.jokyoList!.isNotEmpty){
      jokyo = healthMeibo.jokyoList?.first ?? const HealthStatusModel();
    }else{
      jokyo = const HealthStatusModel();
    }
    
    if (isEditable){
      if (jokyo.jokyoCode == '' || jokyo.jokyoCode == null) {
        color = Theme.of(context).colorScheme.errorContainer;
      } else if (jokyo.jokyoCode != '100') {
        color = Theme.of(context).colorScheme.primaryContainer;
      } else {
        color = Colors.grey.withAlpha(50);
      }
    }else{
      color = const Color(0xFFDDDDDD);
    }

    return GestureDetector(
      onTap: !isEditable ? null : () async{
        await ref.read(healthMeiboListProvider.notifier).updateById(
          healthMeibo, 
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
                      child: ClipOval(child: Image.network(
                          url,
                          headers: {'Authorization': 'Bearer $accessToken'},
                        ),),
                      ),
                    Expanded(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          healthMeibo.studentNumber ?? '',
                          style: const TextStyle(fontSize: 12),
                        ),
                        Text(
                          '${healthMeibo.name}',
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
