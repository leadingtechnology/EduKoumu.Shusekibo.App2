import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kyoumutechou/feature/common/provider/timeds_provider.dart';


class ClipTimed extends ConsumerWidget {
  const ClipTimed({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timedList = ref.watch(timedsProvider);

    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: timedList.map((timed) {
        return ChoiceChip(
          label: Text(
            '${timed.ryaku}',
          ),
          selected: timed == ref.watch(timedProvider),
          onSelected: (bool selected) {
            ref.read(timedProvider.notifier).state = timed;
          },
          showCheckmark: false, 
        );
      }).toList(),
    );
  }
}
