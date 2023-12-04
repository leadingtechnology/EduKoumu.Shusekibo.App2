import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kyoumutechou/feature/common/provider/shozokus_provider.dart';


class ClipShozoku extends ConsumerWidget {
  const ClipShozoku({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final shozokuList = ref.watch(shozokusProvider);
    final shozoku = ref.watch(shozokuProvider);

    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: shozokuList.map((element) {
        return ChoiceChip(
          label: Text(
            '${element.className}',
          ),
          selected: element == shozoku,
          onSelected: (bool selected) {
            ref.read(shozokuProvider.notifier).state = element;
          },
          showCheckmark: false, 
        );
      }).toList(),
    );
  }
}
