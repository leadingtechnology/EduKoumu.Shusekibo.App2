import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kyoumutechou/feature/awareness/provider/awareness_meibo_provider.dart';
import 'package:kyoumutechou/helpers/widgets/my_spacing.dart';


class AwarenessBunrui extends ConsumerWidget {
  const AwarenessBunrui({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final int _gValue = ref.watch(awarenessBunruiProvider);
    
    return Row(
      children: [
        MySpacing.width(4),
        SizedBox(
          width: 160,
          child: RadioListTile(
            title: const Text('学習活動'),
            value: 10,
            groupValue: _gValue,
            onChanged: (value) {
              ref.read(awarenessBunruiProvider.notifier).state = 10;
            },
          ),
        ),
        SizedBox(
          width: 120,
          child: RadioListTile(
            title: const Text('生活'),
            value: 20,
            groupValue: _gValue,
            onChanged: (value) {
              ref.read(awarenessBunruiProvider.notifier).state = 20;
            },
          ),
        ),
        SizedBox(
          width: 160,
          child: RadioListTile(
            title: const Text('特別活動'),
            value: 30,
            groupValue: _gValue,
            onChanged: (value) {
              ref.read(awarenessBunruiProvider.notifier).state = 30;
            },
          ),
        ),
        MySpacing.width(8),
      ],
    );
  }
}

List<String> kizukiPerson = [
  'この調子で、がんばってほしいと思います。',
  'どの学習でも、やる気いっぱいで取り組んでいました。',
  'いつもフレッシュな気持ちで、学習に向かっていました。',
  '心身共に、ひと回りたくましくなりました。',
  '自立へのステップをふみながら、自信のある生活ぶりでした。',
];
