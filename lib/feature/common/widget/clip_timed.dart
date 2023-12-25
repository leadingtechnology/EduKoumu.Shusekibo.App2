import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kyoumutechou/feature/boxes.dart';
import 'package:kyoumutechou/feature/common/provider/filter_provider.dart';
import 'package:kyoumutechou/feature/common/provider/shozokus_provider.dart';
import 'package:kyoumutechou/feature/common/provider/timeds_provider.dart';
import 'package:kyoumutechou/helpers/theme/app_theme.dart';
import 'package:kyoumutechou/shared/util/date_util.dart';

class ClipTimed extends ConsumerWidget {
  const ClipTimed({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(timedsProvider);

    return state.when(
      loading: () {return const SizedBox();},
      error: (error) {return Text('$error');},
      loaded: () {
        final shozokuId = ref.watch(shozokuProvider).id;
        final targetDate = ref.watch(targetDateProvider);
        
        final strDate = DateUtil.getStringDate(targetDate);
        final box = Boxes.getTimeds();
        final keys = box.keys.toList().where(
              (element) =>
                  element.toString().startsWith('$shozokuId-$strDate-'),
            ).toList();
        
        if (keys.isEmpty) {
          return const SizedBox();
        }

        final timedList = keys.map(box.get).toList();
        timedList.sort((a, b) => b?.jigenIdx ?? 0.compareTo(a?.jigenIdx ?? 0));
        //ref.read(timedProvider.notifier).state = timedList.first!;

        return Wrap(
          spacing: 10,
          runSpacing: 6,
          children: timedList.map((timed) {
            final isSelected = timed == ref.watch(timedProvider);
            return ChoiceChip(
              label: Text('${timed?.ryaku}',),
              labelStyle: TextStyle(
                color: isSelected
                    ? theme.colorScheme.onPrimary
                    : theme.colorScheme.primary,
              ),
              selected: isSelected,
              onSelected: (bool selected) {
                ref.read(timedProvider.notifier).state = timed!;
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
