import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kyoumutechou/feature/common/provider/common_provider.dart';
import 'package:kyoumutechou/feature/home/provider/home_provider.dart';
import 'package:kyoumutechou/feature/seat/provider/seat_chart_provider.dart';
import 'package:kyoumutechou/helpers/theme/app_theme.dart';

class SettingPage extends ConsumerWidget{
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: theme.colorScheme.surface,
      child: Column(
        children: [
          Row(
            children: [
              _menuButton(
                context,
                Menu.seatChart,
                '座席表設定',
                Icons.view_comfy_outlined,
                ref,
              ),
              _menuButton(
                context,
                Menu.awarenessTemplate,
                '気づきテンプレート',
                Icons.lightbulb_outline,
                ref,
              ),
              // _menuButton(
              //   context,
              //   'キャッシュクリア',
              //   Icons.delete_outline,
              //   '/clearCache',
              // ),
            ],
          ),
        ],
      ),
    );
  }


  Widget _menuButton(
    BuildContext context, 
    Menu menuId,
    String title, 
    IconData icon, 
    WidgetRef ref,
  ) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: ElevatedButton(
        onPressed: () {
          if (menuId == Menu.seatChart) {
            ref.read(seatChartPageTypeProvider.notifier).state = PageType.list;
          }
          ref.read(menuProvider.notifier).state = menuId;
        },
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10), // 自定义按钮形状
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 20, width: 120),
            Icon(icon),
            const SizedBox(height: 20, width: 120),
            Text(title),
            const SizedBox(height: 20, width: 120),
          ],
        ),
      ),
    );
  }
}
