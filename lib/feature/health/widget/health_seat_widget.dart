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
    required this.meibo, 
    super.key,
  });

  final int index;
  final HealthMeiboModel meibo;
  final String _baseUrl = dotenv.env['BASE_URL']!;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stamp = ref.watch(healthStampProvider);
    final reason1 = ref.watch(healthReason1Provider);
    final reason2 = ref.watch(healthReason2Provider);
    var isEditable = ref.watch(isTokobiProvider);

    Color bkColor, textColor;
    final url = '$_baseUrl${meibo.photoUrl}';
    final accessToken = Hive.box<String>('shusekibo').get('token').toString();

    late HealthStatusModel jokyo;
    
    if (meibo.jokyoList != null && meibo.jokyoList!.isNotEmpty){
      jokyo = meibo.jokyoList?.first ?? const HealthStatusModel();
      
      // 保護される場合、編集不可にする
      if (jokyo.isEditable == false) {
        isEditable = false;
      }

    }else{
      jokyo = const HealthStatusModel();
    }
    
    // 登校日の判定
    if (isEditable){
      if (jokyo.jokyoCode == '' || jokyo.jokyoCode == null) {
        bkColor = Theme.of(context).colorScheme.errorContainer;
      } else if (jokyo.jokyoCode != '100') {
        bkColor = Theme.of(context).colorScheme.primaryContainer;
      } else {
        bkColor = Colors.grey.withAlpha(50);
      }
    }else{
      bkColor = const Color(0xFFDDDDDD);
    }

    // 文字色の設定
    textColor = Colors.black;
    if (meibo.tenshutsuYoteiFlg! == true) {
      textColor = Colors.blue;
    }
    if (meibo.tenshutsuSumiFlg! == true) {
      textColor = Colors.grey;
    }

    return GestureDetector(
      onTap: !isEditable ? null : () async{
        await ref.read(healthMeiboListProvider.notifier).updateById(
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
                      child: ClipOval(child: Image.network(
                          url,
                          headers: {'Authorization': 'Bearer $accessToken'},
                        ),),
                      ),
                    Expanded(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.fromLTRB(0, 0, 18, 0),
                          child: Text(
                            meibo.studentNumber ?? '',
                            style: const TextStyle(fontSize: 12),
                          ),
                        ),
                        Text(
                          '${meibo.name}',
                          style: TextStyle(
                            color: textColor,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),),
                  ],
                ),
              ),
    
              // status bar
              MySpacing.height(4),
              Container(
                  height: 22,
                  decoration: BoxDecoration(
                    color: bkColor,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(6),
                      bottomRight: Radius.circular(6),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const SizedBox(width: 10,),
                      Text(jokyo.ryaku ?? ''),
                      Expanded(
                        child: AutoSizeText(
                          (jokyo.jiyu1 ?? '').trim(), 
                          maxLines: 1, 
                          overflow: TextOverflow.ellipsis,
                        ),
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
