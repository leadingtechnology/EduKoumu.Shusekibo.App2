import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kyoumutechou/feature/boxes.dart';
import 'package:kyoumutechou/feature/health/model/health_reason_model.dart';
import 'package:kyoumutechou/feature/health/provider/health_reason_provider.dart';
import 'package:kyoumutechou/feature/health/provider/health_stamp_provider.dart';
import 'package:kyoumutechou/helpers/widgets/my_spacing.dart';
import 'package:kyoumutechou/shared/http/app_exception.dart';

class HealthReasonWidget extends ConsumerWidget {
  const HealthReasonWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(healthReasonListProvider);
    final stamp = ref.watch(healthStampProvider);

    return state.when(
      loading: () {return Container();},
      error: (AppException error) { return Text('$error'); },
      loaded: () {
        // 1) get reason's key by jukyoCd
        final reason1Keys = Boxes.getHealthReason1()
            .keys
            .where((e) => e.startsWith('${stamp.jokyoCd}-') as bool)
            .toList();
        
        // 2) create drowdown item
        final reason1Items = <DropdownMenuItem<HealthReasonModel>>[];
        
        for (final k in reason1Keys) {
          final r = Boxes.getHealthReason1().get(k);
          reason1Items.add(DropdownMenuItem<HealthReasonModel>(
            value: r,
            child: Text('${r?.jiyuNmSeishiki}'),
          ),);
        }

        if (reason1Items.length <= 1) {
          return Container();
        }

        // 3) get reason's key by jukyoCd
        final reason2Keys = Boxes.getHealthReason2()
            .keys
            .where((e) => e.startsWith('${stamp.jokyoCd}-') as bool)
            .toList();

        // 4) create drowdown item
        final reason2Items = <DropdownMenuItem<HealthReasonModel>>[]; 
        for (final k in reason2Keys) {
          final r = Boxes.getHealthReason2().get(k);
          reason2Items.add(
            DropdownMenuItem<HealthReasonModel>(
              value: r,
              child: Text('${r?.jiyuNmSeishiki}'),
            ),
          );
        }    

        // 5) return dropdown widget
        return Row(
          children: [
            const Text('事由'),
            MySpacing.width(8),
            Container(
              height: 35,
              padding: MySpacing.left(4),
              decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(4),),
              child: SizedBox(
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<HealthReasonModel>(
                    value: ref.watch(healthReason1Provider),
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontFamily: 'NotoSansJP',
                    ),
                    dropdownColor: Colors.white,
                    onChanged: (HealthReasonModel? newValue) {
                      ref.read(healthReason1Provider.notifier).state =
                          newValue!;
                    },
                    items: reason1Items.toSet().toList(),
                  ),
                ),
              )
              
              ,
            ),
            MySpacing.width(4),
            if (reason2Items.length > 1 ) Container(
              height: 35,
              padding: MySpacing.left(4),
              decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(4),
              ),
              child: SizedBox(
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<HealthReasonModel>(
                    value: ref.watch(healthReason2Provider),
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontFamily: 'NotoSansJP',
                    ),
                    dropdownColor: Colors.white,
                    onChanged: (HealthReasonModel? newValue) {
                      ref.read(healthReason2Provider.notifier).state =
                          newValue!;
                    },
                    items: reason2Items.toSet().toList(),
                  ),
                ),
              ),
            ),
          ],
        );
        
      },
    );
  }
}
