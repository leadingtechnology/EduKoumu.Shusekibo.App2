import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kyoumutechou/feature/common/provider/common_provider.dart';
import 'package:kyoumutechou/feature/common/provider/filter_provider.dart';
import 'package:kyoumutechou/feature/common/widget/control_tokobi.dart';
import 'package:kyoumutechou/feature/common/widget/control_tokobi2.dart';
import 'package:kyoumutechou/feature/home/provider/home_provider.dart';
import 'package:kyoumutechou/feature/seat/provider/seat_chart_provider.dart';
import 'package:kyoumutechou/helpers/widgets/my_spacing.dart';
import 'package:kyoumutechou/helpers/widgets/my_text.dart';
import 'package:kyoumutechou/shared/util/date_util.dart';

class SearchBarWidget extends ConsumerWidget {
  const SearchBarWidget(this._scaffoldKey, {this.isPeriod, super.key});

  final GlobalKey<ScaffoldState> _scaffoldKey;
  final bool? isPeriod;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final menuId = ref.watch(menuProvider);
    final filter = ref.watch(filterProvider);

    final strBeginDate = DateUtil.getJapaneseDate(filter.beginDate ?? DateTime.now());
    final strEndDate = DateUtil.getJapaneseDate(filter.endDate ?? DateTime.now());
    
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
                    InkWell(
                      onTap: () {
                        _scaffoldKey.currentState?.openEndDrawer();
                      },
                      child: Container(
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
                    InkWell(
                      onTap: () {
                        _scaffoldKey.currentState?.openEndDrawer();
                      },
                      child: Container(
                        constraints: const BoxConstraints(minWidth: 50),
                        padding: MySpacing.x(4),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(3),
                        ),
                        child: Text(filter.className ?? ''),
                      ),
                    ),
                    if (menuId != Menu.awareness)
                      InkWell(
                        onTap: () {
                          _scaffoldKey.currentState?.openEndDrawer();
                        },
                        child: Row(
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
                      ),
                  ],
                ),
                MySpacing.width(30),

                if (
                    menuId == Menu.attendance ||
                    menuId == Menu.attendanceTimed ||
                    menuId == Menu.health
                ) ...[
                  // 1.3 対象日
                  Row(
                    children: [
                      MyText.bodyLarge(
                        '対象日',
                        fontWeight: 700,
                      ),
                      MySpacing.width(5),
                      InkWell(
                        onTap: () {
                          _scaffoldKey.currentState?.openEndDrawer();
                        },
                        child: Container(
                          constraints: const BoxConstraints(minWidth: 100),
                          padding: MySpacing.x(4),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(3),
                          ),
                          child: Text(
                            filter.className == '' ? 
                            '' :  filter.japanDate ?? '',
                          ),
                        ),
                      ),
                      const ControlTokobi(),
                      const ControlTokobi2(),
                    ],
                  ),

                  if (menuId == Menu.attendanceTimed)...[
                    MySpacing.width(30),
                    // 1.5 時限
                    Row(
                      children:[
                        MyText.bodyLarge(
                          '時限',
                          fontWeight: 700,
                        ),
                        MySpacing.width(5),
                        InkWell(
                          onTap: () {
                            _scaffoldKey.currentState?.openEndDrawer();
                          },
                          child: Container(
                            width: 45,
                            padding: MySpacing.x(4),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              border: Border.all(),
                              borderRadius: BorderRadius.circular(3),
                            ),
                            child: Text(filter.jigenRyaku ?? ''),
                          ),
                        ),
                      ],
                    ),
                  ],
                ]
                // menuId.state == Menu.awareness の場合のみ表示
                else if (isPeriod??false) ...[
                  // 1.5 期間の表示
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MyText.bodyLarge(
                        '期間',
                        fontWeight: 700,
                      ),
                      MySpacing.width(5),
                      InkWell(
                        onTap: () {
                          _scaffoldKey.currentState?.openEndDrawer();
                        },
                        child: Container(
                          width: 80,
                          padding: MySpacing.x(4),
                          decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(3),
                          ),
                          child: Text(strBeginDate),
                        ),
                      ),
                      MyText.bodyLarge(
                        ' ～ ',
                        fontWeight: 700,
                      ),
                      InkWell(
                        onTap: () {
                          _scaffoldKey.currentState?.openEndDrawer();
                        },
                        child: Container(
                          width: 80,
                          padding: MySpacing.x(4),
                          decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(3),
                          ),
                          child: Text(strEndDate),
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),

          // 右側のアイコン
          Row(
            children: <Widget>[
              IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: () {
                  ref.read(filterProvider.notifier).refresh();
                },
              ),
              MySpacing.width(15),
              if (menuId != Menu.setting &&
                  ref.watch(seatChartPageTypeProvider) != PageType.seat)
                IconButton(
                  icon: const Icon(Icons.tune),
                  onPressed: () {
                    _scaffoldKey.currentState?.openEndDrawer();
                  },
                ),

              MySpacing.width(10),
            ],
          ),
        ],
      ),
    );
  }
}
