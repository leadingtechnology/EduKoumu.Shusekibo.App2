import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kyoumutechou/feature/common/provider/common_provider.dart';
import 'package:kyoumutechou/feature/home/provider/home_provider.dart';
import 'package:kyoumutechou/feature/seat/provider/seat_chart_provider.dart';
import 'package:kyoumutechou/helpers/theme/app_theme.dart';

class SettingPage extends ConsumerWidget{
  const SettingPage({super.key});



  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final menuList = ref.watch(menuListProvider);
    final menuItem = ref.watch(menuProvider);
    
    var mIndex = 0;
    for (var i = 0; i < menuList.length; i++) {
      if (menuList[i].menuId == menuItem) {
        mIndex = i;
        break;
      }
    }

    final buttonList = <Widget>[];
    var menuSettingSeats = '1';
    if (dotenv.env['Menu_Setting_Seats'] != null) {
      menuSettingSeats = dotenv.env['Menu_Setting_Seats'] ?? '1';
    }
    if (menuSettingSeats == '1') {
      mIndex++;

      buttonList.add(
        _menuButton(
          context,
          Menu.seatChart,
          '座席表設定',
          Icons.app_registration_outlined,
          ref,
          mIndex,
        ),
      );
    }

    var menuSettingTemplate = '1';
    if (dotenv.env['Menu_Setting_Template'] != null) {
      menuSettingTemplate = dotenv.env['Menu_Setting_Template'] ?? '1';
    }
    if (menuSettingTemplate == '1') {
      mIndex++;

      buttonList.add(
        _menuButton(
          context,
          Menu.awarenessTemplate,
          '気づきテンプレート',
          Icons.lightbulb_outline,
          ref,
          mIndex,
        ),
      );
    }


    return Container(
      padding: const EdgeInsets.all(16),
      color: theme.colorScheme.surface,
      child: Column(
        children: [
          Row(
            children: buttonList,
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
    int index,
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
          side: BorderSide(
            color: Colors.green.shade200, // 枠線の色
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10), // 自定义按钮形状
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 20, width: 120),
            Icon(icon, size: 35,),
            const SizedBox(height: 20, width: 120),
            Text(title),
            const SizedBox(height: 20, width: 120),
          ],
        ),
      ),
    );
  }
}
