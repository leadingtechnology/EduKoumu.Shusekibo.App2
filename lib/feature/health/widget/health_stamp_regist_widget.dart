import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kyoumutechou/feature/boxes.dart';
import 'package:kyoumutechou/feature/health/model/health_reason_model.dart';
import 'package:kyoumutechou/feature/health/provider/health_reason_provider.dart';
import 'package:kyoumutechou/feature/health/provider/health_stamp_provider.dart';
import 'package:kyoumutechou/helpers/theme/app_theme.dart';

class HealthStampRegistWidget extends ConsumerWidget {
  const HealthStampRegistWidget({ super.key });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedStamp = ref.watch(healthStampProvider);

    final stamps = Boxes.getRegistHealthStamp().values.toList();
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
          onPressed: (int index) {
            if (stamps[index].jokyoCd == selectedStamp.jokyoCd) {
              return;
            }
            
            ref.read(healthStampProvider.notifier).state =
                stamps[index];

            ref.read(healthReason1Provider.notifier).state =
                const HealthReasonModel();

            ref.read(healthReason2Provider.notifier).state =
                const HealthReasonModel();

          },
          isSelected: isSelected,
          borderColor:theme.colorScheme.outlineVariant,
          selectedBorderColor: theme.colorScheme.primary,
          children: stamps.map((e) {
            var fontSize = 15.0;
            if (e.jokyoCd == '001' || e.jokyoCd == '999') {
              fontSize = 13.0;
            }

            return SizedBox(
              height: 40,
              width: 100,
              child: Tooltip(
                message: '${e.jokyoNmTsu}',
                preferBelow: false,
                child: Center(
                  child: Text('${e.jokyoNmRyaku}',
                      style: TextStyle(fontSize: fontSize),),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );    
  }  

}
