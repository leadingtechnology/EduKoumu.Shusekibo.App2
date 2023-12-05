import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kyoumutechou/feature/common/provider/gakunens_provider.dart';
import 'package:kyoumutechou/helpers/widgets/my_text.dart';

class ClipGakunen extends ConsumerWidget {
  const ClipGakunen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gakunenList = ref.watch(gakunensProvider);

    return Wrap(
        spacing: 10,
        runSpacing: 10,
        children: gakunenList.map((gakunen) {
          return ChoiceChip(
            label: MyText.bodyMedium(
              '${gakunen.gakunenRyakusho}',
            ),
            selected: gakunen == ref.watch(gakunenProvider),
            onSelected: (bool selected) {
              ref.read(gakunenProvider.notifier).state = gakunen;
            },
            showCheckmark: false, 
          );
        }).toList(),
      );
  }
}
