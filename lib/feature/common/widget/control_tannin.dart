import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kyoumutechou/feature/boxes.dart';
import 'package:kyoumutechou/feature/common/provider/dantais_provider.dart';
import 'package:kyoumutechou/feature/common/provider/filter_provider.dart';
import 'package:kyoumutechou/feature/common/provider/tannin_provider.dart';
import 'package:kyoumutechou/shared/util/date_util.dart';


class ControlTannin extends ConsumerWidget {
  const ControlTannin({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(tanninListProvider);

    return state.when(
      loading: () {return const SizedBox();},
      error: (error) {return Text('$error');},
      loaded: () {
        final dantai = ref.watch(dantaiProvider);
        final filter = ref.watch(filterProvider);

        final target = filter.targetDate??DateTime.now();
        final strDate = DateUtil.getStringDate(target);
        var dantaiId = filter.dantaiId??0;
        // dantaiIdがnullまたは0の場合、dantai.idを使用する
        if(dantaiId == 0){
          dantaiId = dantai.id??0;
        }

        final box = Boxes.getTannin();
        final keys = box.keys.toList().where(
              (element) =>
                  element.toString().startsWith('$dantaiId-$strDate'),
            );
        if (keys.isEmpty) {
          return const SizedBox();
        }
        final tannin = box.get(keys.first);
        return Text(
          '${tannin!.gakunenCode}・${tannin.className}・${tannin.shozokuId}',);
      },
    );
  }
}
