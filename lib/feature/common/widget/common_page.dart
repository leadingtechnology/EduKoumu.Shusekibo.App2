import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kyoumutechou/feature/attendance/widget/attendance_stamp_reason_widget.dart';
import 'package:kyoumutechou/feature/common/widget/filter_widget.dart';
import 'package:kyoumutechou/feature/common/widget/search_bar_widget.dart';
import 'package:kyoumutechou/feature/health/widget/health_stamp_reason_widget.dart';
import 'package:kyoumutechou/feature/home/provider/home_provider.dart';
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
            MySpacing.height(8),
            if(menuId == Menu.health) 
              const HealthStampReasonWidget(),

            // スタンプバー
            MySpacing.height(8),
            if (menuId == Menu.attendance || menuId == Menu.attendanceTimed)
              const AttendanceStampReasonWidget(),

            // コンテンツ表示
            MySpacing.height(8),
            Expanded(
              child: Container(
                color: Colors.grey[100],
                padding: MySpacing.all(8),
                child: contentWidget,
              ),
            ),

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
                        onPressed: setBlank,
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
