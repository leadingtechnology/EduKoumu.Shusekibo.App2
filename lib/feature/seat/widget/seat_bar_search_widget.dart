import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kyoumutechou/feature/boxes.dart';
import 'package:kyoumutechou/feature/common/provider/common_provider.dart';
import 'package:kyoumutechou/feature/common/provider/filter_provider.dart';
import 'package:kyoumutechou/feature/seat/provider/seat_chart_provider.dart';
import 'package:kyoumutechou/helpers/widgets/my_spacing.dart';
import 'package:kyoumutechou/helpers/widgets/my_text.dart';

class SeatSearchBarWidget extends ConsumerWidget {
  SeatSearchBarWidget({
    required this.len,
    super.key,
  });

  final int len;
  final seatSettingBox = Boxes.getSeatSetting();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final seatSettingId = ref.read(seatSettingIdProvider);
    final filter = ref.watch(filterProvider);
    final isExp = ref.watch(isSeatExpandedProvider);

    final setting = seatSettingBox.get(seatSettingId)!;
  
    return Padding(
      padding: const EdgeInsets.all(8),
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
                    MyText.bodyLarge(
                      '学年',
                      fontWeight: 700,
                    ),
                    MySpacing.width(5),
                    Container(
                      constraints: const BoxConstraints(minWidth: 50),
                      padding: MySpacing.x(4),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(3),
                      ),
                      child: Text(
                        filter.gakunenCode == '0'
                            ? ''
                            : filter.gakunenRyakusho ?? '',
                      ),
                    ),
                  ],
                ),
                //
                MySpacing.width(30), // 间隔
                // 1.2 クラスとクラスの表示、チェックボックス
                Row(
                  children: [
                    MyText.bodyLarge(
                      'クラス',
                      fontWeight: 700,
                    ),
                    MySpacing.width(5),
                    Container(
                      constraints: const BoxConstraints(minWidth: 50),
                      padding: MySpacing.x(4),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(3),
                      ),
                      child: Text(filter.className ?? ''),
                    ),
                    Row(
                      children: [
                        Checkbox(
                          value: filter.kouryuGakkyu ?? false,
                          onChanged: null,
                        ),
                        MyText.bodyLarge(
                          '交流学級で表示',
                          fontWeight: 700,
                        ),
                      ],
                    ),
                  ],
                ),
                MySpacing.width(30),

                Row(
                  children: [
                    MyText.bodyLarge(
                      'パターン',
                      fontWeight: 700,
                    ),
                    MySpacing.width(5),
                    Container(
                      constraints: const BoxConstraints(minWidth: 100),
                      padding: MySpacing.x(4),
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(3),
                      ),
                      child: Text(
                        setting.seatPatternName ?? '',
                      ),
                    ),
                  ],
                ),
                MySpacing.width(30),

                // IconButton(
                //   icon: const Icon(Icons.refresh),
                //   onPressed: () {
                //     ref.read(seatChartPageTypeProvider.notifier).state =
                //         PageType.seat;
                //   },
                // ),
                // InkWell(
                //   onTap: () {
                //     ref.read(seatChartPageTypeProvider.notifier).state =
                //         PageType.seat;
                //   },
                //   child: MyText.bodyLarge(
                //     '再検索',
                //     fontWeight: 700,
                //   ),
                // ),
              ],
            ),
          ),

          // 右側のアイコン
          Row(
            children: <Widget>[
              MyText('未設定人数:', fontSize: 16),
              MySpacing.width(8),
              MyText(' ${ref.watch(scMeibosListProvider).length} / $len ',
                  fontSize: 16),
              IconButton(
                icon: isExp
                    ? const Icon(Icons.expand_less)
                    : const Icon(Icons.expand_more),
                onPressed: () {
                  ref.read(isSeatExpandedProvider.notifier).state = !isExp;
                },
              ),
              MySpacing.width(15),
            ],
          ),
        ],
      ),
    );
  }

  void _refreash(WidgetRef ref) {
    final id = ref.read(seatSettingIdProvider);
    ref.read(seatChartListProvider.notifier).fetch(id);

    ref.refresh(seatChartListProvider);
    
  }
}
