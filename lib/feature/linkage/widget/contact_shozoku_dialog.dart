import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kyoumutechou/feature/boxes.dart';
import 'package:kyoumutechou/feature/common/model/shozoku_model.dart';
import 'package:kyoumutechou/feature/common/provider/dantais_provider.dart';
import 'package:kyoumutechou/feature/common/provider/shozokus_provider.dart';
import 'package:kyoumutechou/helpers/theme/app_theme.dart';
import 'package:kyoumutechou/helpers/widgets/my_spacing.dart';

class ContactShozokuDialog extends ConsumerWidget {
  const ContactShozokuDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dantai = ref.watch(dantaiProvider);
    final shozokuCnt = ref.watch(shozokuListProvider).length;

    final box = Boxes.getShozokus();

    // 団体キーリストの取得
    // 初期値の設定
    final keys = box.keys
        .toList()
        .where((e) => e.toString().startsWith('${dantai.id}-'))
        .toList();

    // 団体リストの取得
    final shozokuList = keys.map(box.get).toList();
    if (keys.isEmpty || shozokuList.isEmpty) {
      return const SizedBox();
    }

    // GakunenCodeが'０'の場合、表示対象外にする。
    shozokuList..removeWhere((element) => element?.isGakuseki == false)

    ..sort((a, b) {
      final nameCompare = '${a?.classCode}'.compareTo('${b?.classCode}');

      if (nameCompare != 0) return nameCompare;

      final hyojijunSort = a?.hyojijun ?? 0.compareTo(b?.hyojijun ?? 0);
      if (hyojijunSort != 0) return hyojijunSort;

      return a?.id ?? 0.compareTo(b?.id ?? 0);
    });

    
    return AlertDialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 250),
      title: const Text('確認ダイアログ'),
      surfaceTintColor: theme.colorScheme.surface,
      content: Wrap(
        spacing: 10,
        runSpacing: 6,
        children: [
          const Text(
            'クラスで絞り込み',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          MySpacing.width(10),
          if (shozokuList.length > 1)
            ...shozokuList.map((ShozokuModel? element) {
              final elementList = ref.watch(shozokuListProvider);
              final isSelected = elementList.contains(element);
              
              return ChoiceChip(
                label: Text(
                  '${element?.className}',
                ),
                labelStyle: TextStyle(
                  color: isSelected
                      ? theme.colorScheme.onPrimary
                      : theme.colorScheme.primary,
                ),
                selected: isSelected,
                onSelected: (bool selected) async {
                  final selectedElements =  ref.read(shozokuListProvider);

                  if (selected && element != null) {
                    selectedElements.add(element);
                    ref.read(shozokuListProvider.notifier).state =
                        selectedElements.toList();
                  } else {
                    selectedElements.remove(element);
                    ref.read(shozokuListProvider.notifier).state =
                        selectedElements.toList();
                  }
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

            }),
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            ref.read(shozokuAllProvider.notifier).state = true;
            ref.read(shozokuListProvider.notifier).state = [];
            Navigator.of(context).pop();
          }, // 確認ダイアログを閉じる
          child: const Text('すべて選択'),
        ),
        TextButton(
          onPressed: shozokuCnt ==0 ? null : () {
            final selectedElements = ref.watch(shozokuListProvider);
            if (selectedElements.length == shozokuList.length){
              ref.read(shozokuAllProvider.notifier).state = true;
            } else {
              ref.read(shozokuAllProvider.notifier).state = false;
            }

            Navigator.of(context).pop();
          }, // 確認ダイアログを閉じる
          child: const Text('選択'),
        ),
      ],
    );
  }
}
