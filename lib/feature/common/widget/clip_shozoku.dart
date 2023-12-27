import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kyoumutechou/feature/boxes.dart';
import 'package:kyoumutechou/feature/common/provider/dantais_provider.dart';
import 'package:kyoumutechou/feature/common/provider/gakunens_provider.dart';
import 'package:kyoumutechou/feature/common/provider/shozokus_provider.dart';
import 'package:kyoumutechou/feature/common/provider/timeds_provider.dart';
import 'package:kyoumutechou/helpers/theme/app_theme.dart';


class ClipShozoku extends ConsumerWidget {
  const ClipShozoku({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dantai = ref.watch(dantaiProvider);
    final gakunen = ref.watch(gakunenProvider);
    final shozoku = ref.watch(shozokuProvider);

    final box = Boxes.getShozokus();
    
    // 団体キーリストの取得
        // 初期値の設定
    final keys = box.keys
        .toList()
        .where((e) => e.toString().startsWith('${dantai.id}-${gakunen.gakunenCode}-'))
        .toList();
    
    // 団体リストの取得
    final shozokuList = keys.map(box.get).toList();
    shozokuList.sort((a, b) => a!.hyojijun!.compareTo(b!.hyojijun!));

    if (keys.isEmpty || shozokuList.isEmpty) {
      return const SizedBox();
    }

    return Wrap(
      spacing: 10,
      runSpacing: 6,
      children: shozokuList.map((element) {
        final isSelected = element == shozoku;
        return ChoiceChip(
          label: Text(
            '${element?.className}',
          ),
          labelStyle: TextStyle(
            color: isSelected
                ? theme.colorScheme.onPrimary
                : theme.colorScheme.primary,
          ),
          selected: isSelected,
          onSelected: (bool selected)  async{
            ref.read(shozokuProvider.notifier).state = element!;

            // 時限情報の初期値を設定する
            final timed = await ref.read(timedsProvider.notifier).setTimedValue();
            ref.read(timedProvider.notifier).state = timed;

            ref.read(timedUpdateProvider.notifier).state++;
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
