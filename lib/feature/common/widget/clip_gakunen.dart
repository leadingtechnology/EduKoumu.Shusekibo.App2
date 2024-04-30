import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kyoumutechou/feature/boxes.dart';
import 'package:kyoumutechou/feature/common/provider/dantais_provider.dart';
import 'package:kyoumutechou/feature/common/provider/gakunens_provider.dart';
import 'package:kyoumutechou/feature/common/provider/shozokus_provider.dart';
import 'package:kyoumutechou/feature/common/provider/timeds_provider.dart';
import 'package:kyoumutechou/helpers/theme/app_theme.dart';

class ClipGakunen extends ConsumerWidget {
  const ClipGakunen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final organizationKbn = ref.watch(dantaiProvider).organizationKbn;
    final box = Boxes.getGakunens();

    final keys = box.keys.toList().where(
          (element) => element.toString().startsWith('$organizationKbn-'),
        );

    if (keys.isEmpty) {
      return const SizedBox();
    }

    final gakunenList = keys.map(box.get).toList();
    //ref.read(gakunenProvider.notifier).state = gakunenList.first!;
    
    //　ソートする
    gakunenList.sort(
      (a, b) => '${a?.kateiKbn}-${a?.gakunenCode}'
          .compareTo('${b?.kateiKbn}-${b?.gakunenCode}'),
    );

    return Wrap(
      spacing: 10,
      runSpacing: 6,
      children: gakunenList.map((gakunen) {
        final isSelected = gakunen == ref.watch(gakunenProvider);

        return ChoiceChip(
          label: Text(
            '${gakunen?.gakunenRyakusho}',
          ),
          labelStyle: TextStyle(
            color: isSelected
                ? theme.colorScheme.onPrimary
                : theme.colorScheme.primary,
          ),
          selected: isSelected,
          onSelected: (bool selected) async{
            ref.read(gakunenProvider.notifier).state = gakunen!;

            // 所属情報の初期値を設定する
            final shozoku =
                await ref.read(shozokusProvider.notifier).setShozokuValue(
                      gakunen,
                    );

            ref.read(shozokuProvider.notifier).state = shozoku;

            // 時限情報の初期値を設定する
                        // 時限情報の初期値を設定する
            final timed = await ref.read(timedsProvider.notifier).setTimedValue();
            ref.read(timedProvider.notifier).state = timed;

            ref.read(timedUpdateProvider.notifier).state ++ ;
          },
          side: BorderSide(
            width: 0,
            color: isSelected
                ? theme.colorScheme.primary
                : theme.colorScheme.outline,
          ),
          backgroundColor: theme.colorScheme.background,
          selectedColor: theme.colorScheme.primary,
          showCheckmark: false,
        );
      }).toList(),
    );


  }
}
