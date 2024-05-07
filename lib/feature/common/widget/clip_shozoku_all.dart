import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kyoumutechou/feature/common/provider/shozokus_provider.dart';
import 'package:kyoumutechou/feature/linkage/widget/contact_shozoku_dialog.dart';
import 'package:kyoumutechou/helpers/theme/app_theme.dart';
import 'package:kyoumutechou/helpers/widgets/my_spacing.dart';

class ClipShozokuAll extends ConsumerWidget {
  ClipShozokuAll({super.key});

  final textWidget = Container(
    width: 150,
    height: 32,
    alignment: Alignment.centerLeft,
    child: const Text(
      'クラスで絞り込み',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 14,
      ),
    ),
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    
    var isAll = ref.watch(shozokuAllProvider);
    final shozokuList = ref.watch(shozokuListProvider);
    
    if (shozokuList.isEmpty || shozokuList.isEmpty) {
      isAll = true;
    }

    shozokuList.sort((a, b) {
      final nameCompare = '${a.classCode}'.compareTo('${b.classCode}');

      if (nameCompare != 0) return nameCompare;

      final hyojijunSort = a.hyojijun ?? 0.compareTo(b.hyojijun ?? 0);
      if (hyojijunSort != 0) return hyojijunSort;

      return a.id ?? 0.compareTo(b.id ?? 0);
    });

    final shozokuWidget = Row(
      children: [
        textWidget,
        MySpacing.width(28),
        ChoiceChip(
          label: const Text(
            '全て',
          ),
          labelStyle: TextStyle(
            color: theme.colorScheme.onPrimary,
          ),
          selected: true,
          onSelected: (bool selected) async {
            //選択用Dialogを表示する
            // ignore: inference_failure_on_function_invocation
            await showDialog(
              context: context,
              builder: (context) {
                return const ContactShozokuDialog();
              },
            );
          },
          side: BorderSide(
            width: 0,
            color: theme.colorScheme.primary,
          ),
          backgroundColor: theme.colorScheme.background,
          selectedColor: theme.colorScheme.primary,
          showCheckmark: false,
        ),
      ],
    );

    if (isAll) {
      return shozokuWidget;
    }

    return Wrap(
      spacing: 10,
      runSpacing: 6,
      alignment: WrapAlignment.center,
      children: [
        textWidget,
        MySpacing.width(10),
        if (shozokuList.isNotEmpty)
          ...shozokuList.map((element) {
            return ChoiceChip(
              label: Text(
                '${element.className}',
              ),
              labelStyle: TextStyle(
                color: theme.colorScheme.onPrimary,
              ),
              selected: true,
              onSelected: (bool selected) async {
                //選択用Dialogを表示する
                // ignore: inference_failure_on_function_invocation
                await showDialog(
                  context: context,
                  builder: (context) {
                    return const ContactShozokuDialog();
                  },  
                );
                
              },
              side: BorderSide(
                width: 0,
                color: theme.colorScheme.primary,
              ),
              backgroundColor: theme.colorScheme.background,
              selectedColor: theme.colorScheme.primary,
              showCheckmark: false,
            );
          }),
        if (shozokuList.isEmpty)
          const SizedBox(),
      ],
    );
  }


}
