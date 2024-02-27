import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kyoumutechou/feature/attendance/widget/attendance_stamp_reason_widget.dart';
import 'package:kyoumutechou/feature/common/provider/common_provider.dart';
import 'package:kyoumutechou/feature/common/provider/tokobis_provider.dart';
import 'package:kyoumutechou/feature/common/widget/filter_widget.dart';
import 'package:kyoumutechou/feature/common/widget/search_bar_widget.dart';
import 'package:kyoumutechou/feature/common/widget/seat_chart_pattern_widget.dart';
import 'package:kyoumutechou/feature/health/widget/health_stamp_reason_widget.dart';
import 'package:kyoumutechou/feature/home/provider/home_provider.dart';
import 'package:kyoumutechou/feature/linkage/widget/lectern_widget.dart';
import 'package:kyoumutechou/feature/seat/provider/seat_chart_provider.dart';
import 'package:kyoumutechou/helpers/theme/app_theme.dart';
import 'package:kyoumutechou/helpers/widgets/my_spacing.dart';

class CommonPage extends ConsumerWidget {
  const CommonPage({
    required this.scaffoldKey,
    required this.contentWidget,
    required this.onShift,
    this.setBlank,
    required this.saveWidget,
    required this.buttomName,
    required this.buttonIcon,
    super.key,
  });

  final GlobalKey<ScaffoldState> scaffoldKey;
  final Widget contentWidget; // コンテンツ表示用のウィジェット
  final VoidCallback onShift; // ボタン1の処理
  final VoidCallback? setBlank; // ボタン2の処理
  final Widget saveWidget; // 保存ボタン
  final String buttomName;
  final IconData buttonIcon;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final menuId = ref.watch(menuProvider);
    final isTokobi = ref.watch(isTokobiProvider);
    final lecternPosition = ref.watch(lecternPositionProvider);

    return Scaffold(
      key: scaffoldKey,
      endDrawer: FilterWidget(),
      body: ColoredBox(
        color: theme.colorScheme.background,
        child: Column(
          children: [
            // １行目：検索条件の表示
            SearchBarWidget(scaffoldKey),

            // 健康観察スタンプバー
            if(menuId == Menu.health) ...[
              MySpacing.height(8),
              const HealthStampReasonWidget(),
            ],
              
            // スタンプバー
            if (menuId == Menu.attendance || menuId == Menu.attendanceTimed) ...[
              MySpacing.height(8),
              const AttendanceStampReasonWidget(),
            ],

            // コンテンツ表示
            if (lecternPosition == LecternPosition.top && buttomName == '一覧'
            ) ...[
              MySpacing.height(8),
              const SizedBox(height: 8, child: LecternWidget(title: '')),
            ],
            
            Expanded(
              child: Container(
                color: Colors.grey[100],
                padding: MySpacing.all(8),
                child: contentWidget,
              ),
            ),
            if (lecternPosition == LecternPosition.bottom &&
                buttomName == '一覧'
            ) ...[
              const SizedBox(height: 8, child: LecternWidget(title: '')),
            ],

            // 底辺ボタン表示
            Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      ElevatedButton.icon(
                        onPressed: onShift,
                        icon: Icon(
                          buttonIcon,
                          color: Colors.black,
                        ),
                        label: Text(
                          buttomName,
                          style: const TextStyle(color: Colors.black),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            side: const BorderSide(),
                          ),
                        ),
                      ),
                      MySpacing.width(12),
                      ElevatedButton(
                        onPressed: !isTokobi || ref.watch(buttonEnableProvider)? setBlank : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            side: const BorderSide(),
                          ),
                        ),
                        child: const Text(
                          '空白のみ全出',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                  Expanded(child: Container()),
                  if (buttomName == '一覧') ...[
                    const SeatChartPatternWidget(),
                    MySpacing.width(8),
                    ElevatedButton.icon(
                      onPressed: () {
                        ref.read(lecternPositionProvider.notifier).state =
                            ref.read(lecternPositionProvider) ==
                                    LecternPosition.top
                                ? LecternPosition.bottom
                                : LecternPosition.top;
                      },
                      icon: const Icon(Icons.swap_vert_outlined),
                      label: const Text('表示回転'),
                      style: ElevatedButton.styleFrom(
                        side: BorderSide(
                          color: Colors.green.shade200, // 枠線の色
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ],
                  MySpacing.width(30),
                  saveWidget,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
