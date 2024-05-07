import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kyoumutechou/feature/common/model/kamoku_model.dart';
import 'package:kyoumutechou/feature/common/provider/kamokus_provider.dart';
import 'package:kyoumutechou/feature/common/provider/teachers_provider.dart';
import 'package:kyoumutechou/feature/common/widget/teacher_kyoka_dialog.dart';
import 'package:kyoumutechou/helpers/theme/app_theme.dart';
import 'package:kyoumutechou/helpers/widgets/my_spacing.dart';

class TeacherKamokuBarWidget extends ConsumerWidget {
  const TeacherKamokuBarWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final kamoku = ref.watch(kamokuProvider);
    final teacherList = ref.watch(teacherListProvider);

    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 20, 8, 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          // 左側の検索条件
          Expanded(
            child: Row(
              children: [
                // 1.1 学年と学年の表示
                Row(
                  children: [
                    const Text(
                      '教科',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    MySpacing.width(12),
                    InputChip(
                      label: Text(
                        kamoku.kamokuNameRyakusho ?? '(未設定)',
                      ),
                      selected: true,
                      showCheckmark: false,
                      onSelected: (bool isSelected) {
                        handleSelection(context);
                      },
                      onDeleted: kamoku.kamokuNameRyakusho == null ? null : () {
                        ref.read(kamokuProvider.notifier).state =
                                  const KamokuModel();
                      },
                      selectedColor: theme.colorScheme.primaryContainer, 
                    ),
                  ],
                ),
                //
                MySpacing.width(30), // 间隔
                // 1.2 クラスとクラスの表示、チェックボックス
                Row(
                  children: [
                    const Text(
                      '担当教職員',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    MySpacing.width(12),
                    if (teacherList.isNotEmpty)
                    ...teacherList.map((teacher) {
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(0,0, 12,0),
                        child: InputChip(
                          label: Text(
                            teacher.teacherTsushoName ?? '',
                          ),
                          selected: true,
                          showCheckmark: false,
                          onSelected: (bool isSelected) {
                            handleSelection(context);
                          },
                          onDeleted: () {
                              teacherList.remove(teacher);
                              ref.read(teacherListProvider.notifier).state =
                                  teacherList.toList();
                          },
                          selectedColor: theme.colorScheme.primaryContainer,
                        ),
                      );
                    }),
                    if (teacherList.isEmpty)
                      InputChip(
                        label: const Text(
                          '(未設定)',
                        ),
                        selected: true,
                        showCheckmark: false,
                        onSelected: (bool isSelected) {
                          handleSelection(context);
                        },
                        selectedColor: theme.colorScheme.primaryContainer,
                      ),
                  ],
                ),

              ],
            ),
          ),

        ],
      ),
    );
  }

  Future<void> handleSelection(
    BuildContext context,
  ) async {
    // ignore: inference_failure_on_function_invocation
    await showDialog(
      context: context,
      builder: (context) {
        return const TeacherKyokaDialog();
      },
    );
  }

  Future<void> handleDeletion(
    BuildContext context,
  ) async {
    // ignore: inference_failure_on_function_invocation
    await showDialog(
      context: context,
      builder: (context) {
        return const TeacherKyokaDialog();
      },
    );
  }

}
