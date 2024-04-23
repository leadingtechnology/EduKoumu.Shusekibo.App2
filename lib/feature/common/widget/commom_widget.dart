import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kyoumutechou/feature/common/provider/filter_provider.dart';
import 'package:kyoumutechou/feature/common/provider/timeds_provider.dart';
import 'package:kyoumutechou/helpers/theme/app_theme.dart';
import 'package:kyoumutechou/helpers/widgets/my_spacing.dart';
import 'package:kyoumutechou/helpers/widgets/my_text.dart';
import 'package:kyoumutechou/shared/util/date_util.dart';


Widget SingleIconChip({
  IconData? iconData,
  String? text,
  bool? isSelected,
}) {
  if (iconData != null) {
    return Chip(
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      backgroundColor: isSelected!
          ? theme.colorScheme.primary
          : theme.colorScheme.primary.withAlpha(24),
      avatar: Icon(iconData,
          size: 16,
          color: isSelected
              ? theme.colorScheme.onPrimary
              : theme.colorScheme.primary,),
      label: MyText.bodySmall(text!,
          fontSize: 12.5,
          color: isSelected
              ? theme.colorScheme.onPrimary
              : theme.colorScheme.primary,
          letterSpacing: 0,
          fontWeight: 500,),
      padding: MySpacing.fromLTRB(12, 6, 12, 6),
    );
  }

  return Chip(
    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    backgroundColor: isSelected!
        ? theme.colorScheme.primary
        : theme.colorScheme.primary.withAlpha(24),
    label: MyText.bodySmall(text!,
        color: isSelected
            ? theme.colorScheme.onPrimary
            : theme.colorScheme.primary,
        letterSpacing: 0,
        fontWeight: 500,),
    padding: MySpacing.fromLTRB(12, 6, 12, 6),
  );
}

Future<void> pickDate(
  BuildContext context, 
  WidgetRef ref, 
  {DateTime? iniDate,
}) async {
  iniDate ??= DateTime.now();
  
  final dates = DateUtil.calculateFiscalYear(DateTime.now());

  final selected = await showDatePicker(
    context: context,
    initialDate: iniDate,
    firstDate: dates.item1,
    lastDate: DateTime.now(),
    locale: const Locale('ja', 'JP'),
    
  );
  if (selected != null) {
    ref.read(targetDateProvider.notifier).state = selected;

    // 時限情報の初期値を設定する
    final timed = await ref.read(timedsProvider.notifier).setTimedValue();
    ref.read(timedProvider.notifier).state = timed;

    ref.read(timedUpdateProvider.notifier).state++;
  }
}
