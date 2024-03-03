import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kyoumutechou/feature/health/provider/health_provider.dart';
import 'package:kyoumutechou/feature/health/widget/health_reason_widget.dart';
import 'package:kyoumutechou/feature/health/widget/health_stamp_regist_widget.dart';
import 'package:kyoumutechou/feature/health/widget/health_stamp_unregist_widget.dart';
import 'package:kyoumutechou/helpers/widgets/my_spacing.dart';

class HealthStampReasonWidget extends ConsumerStatefulWidget {
  const HealthStampReasonWidget({super.key});

  @override
  HealthStampReasonState createState() => HealthStampReasonState();
}

class HealthStampReasonState extends ConsumerState<HealthStampReasonWidget> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isExpend = ref.watch(healthStampReasonExpend);
    
    return Column(
      children: [
        Row(
          children: [
            // 010:スタンプバー
            MySpacing.width(20),
            Transform.rotate(
              angle: pi / 4,
              child: const Icon(
                Icons.approval_outlined,
              ),
            ),
            SizedBox(
              width: 70,
              child: Container(
                padding: MySpacing.x(4),
                alignment: Alignment.topRight,
                child: const Text('健康観察\n状況', textAlign: TextAlign.center),
              ),
            ),
            MySpacing.width(12),
            const HealthStampRegistWidget(),
            MySpacing.width(8),
            IconButton(
              onPressed: () {
                ref.read(healthStampReasonExpend.notifier).state = !isExpend;
              },
              icon: isExpend
                  ? const Icon(Icons.expand_less)
                  : const Icon(Icons.expand_more),
            ),

            // 020:事由ドロップボックス
            Expanded(
              child: Container(),
            ),
            const HealthReasonWidget(),
          ],
        ),
        if (isExpend)
          const Row(
            children: [
              SizedBox(
                width: 126,
              ),
              HealthStampUnregistWidget(),
            ],
          ),
      ],
    );    
    
  }
}
