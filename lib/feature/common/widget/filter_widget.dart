import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kyoumutechou/feature/common/provider/filter_provider.dart';
import 'package:kyoumutechou/feature/common/widget/clip_gakunen.dart';
import 'package:kyoumutechou/feature/common/widget/clip_shozoku.dart';
import 'package:kyoumutechou/feature/common/widget/clip_timed.dart';
import 'package:kyoumutechou/feature/common/widget/commom_widget.dart';
import 'package:kyoumutechou/feature/home/provider/home_provider.dart';
import 'package:kyoumutechou/helpers/widgets/my_spacing.dart';
import 'package:kyoumutechou/helpers/widgets/my_text.dart';
import 'package:kyoumutechou/shared/util/date_util.dart';

// ignore: must_be_immutable
class FilterWidget extends ConsumerWidget {
  FilterWidget({super.key, this.isPeriod = false});

  final bool? isPeriod;
  int selectedLocation = 0;
  int selectedDate = 2;
  int selectedTOD = 1;
  bool isKouryuGrade = false;

  Future _pickDateRange(BuildContext context, WidgetRef ref) async {
    final initialDateRange =
        DateTimeRange(start: DateTime.now(), end: DateTime.now());

    final newDateRange = await showDateRangePicker(
        context: context,
        initialDateRange: initialDateRange,
        firstDate: DateTime(2023, 4, 1),
        lastDate: DateTime(2024, 3, 31),
        locale: const Locale('ja', 'JP'),
        builder: (context, child) {
          return Column(
            children: [
              ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: 400,
                ),
                child: child,
              ),
            ],
          );
        },);

    if (newDateRange != null) {
      ref.read(beginDateProvider.notifier).state = newDateRange.start;
      ref.read(endDateProvider.notifier).state = newDateRange.end;
    } else {
      return;
    }
  }  

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final targetDate = ref.watch(targetDateProvider);
    final menuId = ref.watch(menuProvider);
    final themeData = Theme.of(context);

    final beginDate = ref.watch(beginDateProvider);
    final endDate = ref.watch(endDateProvider);

    return Container(
      width: 300,
      margin: MySpacing.y(16),
      padding: MySpacing.xy(24, 16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          bottomLeft: Radius.circular(16),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MyText.titleMedium('フィルター'),
                Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: themeData.colorScheme.primary.withAlpha(24),
                  ),
                  child: IconButton(
                    icon: FaIcon(
                      FontAwesomeIcons.circleCheck,
                      color: themeData.colorScheme.primary,
                    ),
                    onPressed: () {
                      ref
                          .read(filterProvider.notifier)
                          .update(targetDate: targetDate);
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
            //  -- 1 --
            MySpacing.height(8),
            MyText.bodyMedium('学年'),
            MySpacing.height(8),
            Container(
              padding: MySpacing.left(12),
              child: const ClipGakunen(),
            ),
            MySpacing.height(16),
            //  -- 2 --
            Row(
              children: [
                MyText.bodyMedium('クラス'),
                if (menuId != Menu.awareness)...[
                Checkbox(
                  activeColor: const Color(0xFF2D4E27),
                  value: ref.watch(kouryuProvider),
                  onChanged: (v) {
                    ref.read(kouryuProvider.notifier).state = v ?? false;
                  },
                ),
                MyText.bodyMedium('交流学級で表示'),
                ],
              ],
            ),
            MySpacing.height(8),
            Container(
              padding: MySpacing.left(12),
              child: const ClipShozoku(),
            ),
            MySpacing.height(16),
            // -- 3 --
            if (menuId != Menu.awareness) ...[
            MyText.bodyMedium('対象日'),
            MySpacing.height(8),
            Container(
              padding: MySpacing.left(12),
              child: InkWell(
                onTap: () {
                  pickDate(context, ref);
                },
                child: SingleIconChip(
                  isSelected: true,
                  text: DateUtil.getStringDate(targetDate),
                  iconData: Icons.calendar_month_outlined,
                ),
              ),
            ),
            ],
            // -- 4 --
            if (menuId == Menu.attendanceTimed) ...[
              MySpacing.height(16),
              MyText.bodyMedium('時限'),
              MySpacing.height(8),
              Container(
                padding: MySpacing.left(12),
                child: const ClipTimed(),
              ),
            ],

            if (isPeriod == true)...[
              MySpacing.height(16),
              MyText.bodyMedium('期間'),
              MySpacing.height(8),
              Padding(
                padding: const EdgeInsets.only(left: 12),
                child: InkWell(
                  onTap: () async {
                    await _pickDateRange(context, ref);
                  },
                  child: SingleIconChip(
                    isSelected: true,
                    text:
                          '${DateUtil.getJapaneseDate(beginDate)} ~ ${DateUtil.getJapaneseDate(endDate)}',
                      iconData: Icons.calendar_month_outlined,
                  ),
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }
}
