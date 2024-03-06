import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kyoumutechou/feature/boxes.dart';
import 'package:kyoumutechou/feature/health/model/health_reason_model.dart';
import 'package:kyoumutechou/feature/health/model/health_stamp_model.dart';
import 'package:kyoumutechou/feature/health/provider/health_reason_provider.dart';
import 'package:kyoumutechou/feature/health/provider/health_stamp_provider.dart';
import 'package:kyoumutechou/helpers/theme/app_theme.dart';

class HealthStampUnregistWidget extends ConsumerWidget {
  const HealthStampUnregistWidget({ super.key });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedStamp = ref.watch(healthStampProvider);
    final stamps = Boxes.getUnregistHealthStamp().values.toList();
    final isSelected = stamps
        .map(
          (e) => e.jokyoCd == selectedStamp.jokyoCd,
        )
        .toList();    

    return Row(
      children: [
        ToggleButtons(
          constraints: const BoxConstraints.expand(width: 50),
          fillColor: Theme.of(context).colorScheme.secondaryContainer,
          borderColor: theme.colorScheme.outlineVariant,
          selectedBorderColor: theme.colorScheme.primary,
          onPressed: (int index) {
            ref.read(healthStampProvider.notifier).state = stamps[index];

            ref.read(healthReason1Provider.notifier).state =
                const HealthReasonModel();

            ref.read(healthReason2Provider.notifier).state =
                const HealthReasonModel();
          },
          isSelected: isSelected,
          children: stamps
              .map(
                (e) => Tooltip(
                  message: '${e.jokyoNmTsu}',
                  child: SizedBox(
                    height: 40,
                    width: 100,
                    child: Center(
                      child: Text(
                        '${e.jokyoNmRyaku}',
                        style: const TextStyle(fontSize: 15),
                      ),
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );    
  }  
}
