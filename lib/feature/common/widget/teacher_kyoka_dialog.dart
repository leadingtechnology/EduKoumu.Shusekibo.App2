import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kyoumutechou/feature/boxes.dart';
import 'package:kyoumutechou/feature/common/model/kamoku_model.dart';
import 'package:kyoumutechou/feature/common/provider/filter_provider.dart';
import 'package:kyoumutechou/feature/common/provider/kamokus_provider.dart';
import 'package:kyoumutechou/feature/common/provider/teachers_provider.dart';
import 'package:kyoumutechou/helpers/theme/app_theme.dart';
import 'package:kyoumutechou/helpers/widgets/my_spacing.dart';
import 'package:kyoumutechou/shared/util/date_util.dart';

class TeacherKyokaDialog extends ConsumerWidget {
  const TeacherKyokaDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filter = ref.watch(filterProvider);

    // 教職員ボックスの取得
    final teacherBox = Boxes.getTeachers();
    // 教職員リストの取得
    final teacherList = teacherBox.values.toList();

    
    // 教科ボックスの取得
    final kamokuBox = Boxes.getKamokus();

    // 対象データの取得
    final kamokuKeys = kamokuBox.keys
        .toList()
        .where((e) => e
            .toString()
            .startsWith('${filter.dantaiId}-${filter.gakunenCode}-'),)
        .toList();
    
    // 教科リストの取得
    final kamokuList = kamokuKeys.map(kamokuBox.get).toList();

    if ((kamokuKeys.isEmpty || kamokuList.isEmpty) &&
        teacherList.isEmpty) {
      return const SizedBox();
    }

    // 担当教員と教科初期値の取得
    final tantoKyoinBox = Boxes.getTantoKyoins();
    final shozokuId = filter.classId;
    final strDate = DateUtil.getStringDate(filter.targetDate??DateTime.now());  

    // 対象データの取得
    // final tantoKyoinKeys = tantoKyoinBox.keys
    //     .toList()
    //     .where((e) => e.toString().startsWith('$shozokuId-$strDate-'))
    //     .toList();

    // final tantouKyoinList = tantoKyoinKeys.map(tantoKyoinBox.get).toList();
    // final tantouKyoin = tantouKyoinList
    //     .where((e) => e?.jigenIdx != null && e?.jigenIdx == filter.jigenIdx)
    //     .first;

    return AlertDialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 250),
      title: const Text('担当教科と教職員を設定'),
      surfaceTintColor: theme.colorScheme.surface,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Row(
            children: [
              Text(
                '教科',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          MySpacing.height(18),
          Wrap(
            spacing: 10,
            runSpacing: 6,
            children: kamokuList.map((kamoku) {
              final isSelected = kamoku == ref.watch(kamokuProvider);

              return ChoiceChip(
                label: Text(
                  '${kamoku?.kamokuNameRyakusho}',
                ),
                labelStyle: TextStyle(
                  color: isSelected
                      ? theme.colorScheme.onPrimary
                      : theme.colorScheme.primary,
                ),
                selected: isSelected,
                onSelected: (bool selected) async {
                  if (selected){
                    ref.read(kamokuProvider.notifier).state = kamoku!;
                  }else{
                    ref.read(kamokuProvider.notifier).state =
                        const KamokuModel();
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
            }).toList(),
          ),
          MySpacing.height(18),
          const Row(
            children: [
              Text(
                '担当教職員',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          MySpacing.height(18),
          Wrap(
            spacing: 10,
            runSpacing: 6,
            children: teacherList.map((teacher) {
              final tchlist = ref.watch(teacherListProvider);
              final isSelected = tchlist.contains(teacher);

              return ChoiceChip(
                label: Text(
                  '${teacher?.teacherTsushoName}',
                ),
                labelStyle: TextStyle(
                  color: isSelected
                      ? theme.colorScheme.onPrimary
                      : theme.colorScheme.primary,
                ),
                selected: isSelected,
                onSelected: (bool selected) async {
                  final list = ref.read(teacherListProvider);
                  if (selected){
                    if (list.length >= 3){
                      list.removeAt(0);
                    }
                    list.add(teacher!);
                    ref.read(teacherListProvider.notifier).state = list.toList();
                  }else{
                    list.remove(teacher);
                    ref.read(teacherListProvider.notifier).state = list.toList();
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
            }).toList(),
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          style: ButtonStyle(
            side: MaterialStateProperty.all<BorderSide>(
              BorderSide(
                color: theme.colorScheme.primary, 
                width: 1, 
              ),
            ),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ), // 確認ダイアログを閉じる
          child: const Text('　選択　'),
        ),
      ],
    );
  }
}
