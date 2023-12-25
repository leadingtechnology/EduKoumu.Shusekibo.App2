import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kyoumutechou/feature/boxes.dart';
import 'package:kyoumutechou/feature/common/provider/dantais_provider.dart';
import 'package:kyoumutechou/feature/common/provider/filter_provider.dart';
import 'package:kyoumutechou/feature/common/provider/gakunens_provider.dart';
import 'package:kyoumutechou/feature/common/provider/shozokus_provider.dart';
import 'package:kyoumutechou/feature/common/provider/timeds_provider.dart';
import 'package:kyoumutechou/helpers/theme/app_theme.dart';
import 'package:kyoumutechou/shared/util/date_util.dart';


class ClipShozoku extends ConsumerWidget {
  const ClipShozoku({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(shozokusProvider);
    final shozoku = ref.watch(shozokuProvider);
    final targetDate = ref.watch(targetDateProvider);

    return state.when(
      loading: () {return const SizedBox();},
      error: (error) {return Text('$error');},
      loaded: () {
        final dantaiId = ref.watch(dantaiProvider).id;
        final gakunenCode = ref.watch(gakunenProvider).gakunenCode;
        final box = Boxes.getShozokus();
        final keys = box.keys.toList().where(
              (element) =>
                  element.toString().startsWith('$dantaiId-'),
            );  
        
        if (keys.isEmpty) {
          return const SizedBox();
        } 

        final shozokuList = keys.map(box.get).toList().where(
          (e) => e?.gakunenCode == gakunenCode,
        ).toList();
        //ref.read(shozokuProvider.notifier).state = shozokuList.first!;

        return Wrap(
          spacing: 10,
          runSpacing: 6,
          children: shozokuList.map((element) {
            final isSelected = element == shozoku;
            return ChoiceChip(
              label: Text('${element?.className}',),
              labelStyle: TextStyle(
                color: isSelected
                    ? theme.colorScheme.onPrimary
                    : theme.colorScheme.primary,
              ),
              selected: isSelected,
              onSelected: (bool selected) {
                ref.read(shozokuProvider.notifier).state = element!;
                setTimedValue(
                  ref as Ref<Object?>,
                  shozokuId: element.id,
                  strDate: DateUtil.getStringDate(targetDate),
                );
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
      },
    );
  }
}
