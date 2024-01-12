import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kyoumutechou/feature/attendance/widget/attendance_page.dart';
import 'package:kyoumutechou/feature/attendance/widget/attendance_timed_page.dart';
import 'package:kyoumutechou/feature/auth/provider/auth_provider.dart';
import 'package:kyoumutechou/feature/awareness/weidget/awareness_page.dart';
import 'package:kyoumutechou/feature/common/provider/dantais_provider.dart';
import 'package:kyoumutechou/feature/common/widget/control_dantai_change.dart';
import 'package:kyoumutechou/feature/common/widget/control_tannin.dart';
import 'package:kyoumutechou/feature/common/widget/dantai_dropdown_widget.dart';
import 'package:kyoumutechou/feature/dashboard/widget/dashboard_page.dart';
import 'package:kyoumutechou/feature/health/widget/health_page.dart';
import 'package:kyoumutechou/feature/home/provider/home_provider.dart';
import 'package:kyoumutechou/feature/seat/seat_chart_page.dart';
import 'package:kyoumutechou/feature/setting/widget/awareness_template_page.dart';
import 'package:kyoumutechou/helpers/theme/app_theme.dart';
import 'package:kyoumutechou/helpers/widgets/my_text.dart';
import 'package:kyoumutechou/shared/http/app_exception.dart';
import 'package:kyoumutechou/shared/util/date_util.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends ConsumerState<HomePage> {
  final _isShowMenu = true;
  String dropdownValue = 'One';

  late ThemeData theme;

  @override
  void initState() {
    super.initState();
    theme = AppTheme.lightTheme;
  }

  void _onItemTapped(int index) {
    ref.read(menuProvider.notifier).state = navItems[index].menuId;
  }

  // ナビゲーションバーのアイテム
  final List<NavItem> navItems = [
    NavItem(
      Menu.dashboard,
      'ホーム',
      const DashboardPage(),
      const Icon(Icons.home),
      const Icon(Icons.home_outlined),
    ),
    NavItem(
      Menu.health,
      '健康観察',
      HealthPage(),
      const FaIcon(FontAwesomeIcons.stethoscope,),
      const FaIcon(FontAwesomeIcons.stethoscope,),
    ),
    NavItem(
      Menu.attendance,
      '出欠(日)',
      AttendancePage(),
      const Icon(Icons.content_paste),
      const Icon(Icons.content_paste_outlined),
    ),
    NavItem(
      Menu.attendanceTimed,
      '出欠(時限)',
      AttendanceTimedPage(),
      const Icon(Icons.content_paste),
      const Icon(Icons.content_paste_outlined),
    ),
    NavItem(
      Menu.awareness,
      '気づき',
      const AwarenessPage(),
      const Icon(Icons.lightbulb),
      const Icon(Icons.lightbulb_outlined),
    ),
    // NavItem(
    //   Menu.setting,
    //   '設定',
    //   const SettingPage(),
    //   const Icon(Icons.settings),
    //   const Icon(Icons.settings_outlined),
    // ),
  ];

  final List<NavItem> settingItems = [
    NavItem(
      Menu.modoru,
      '戻る',
      const DashboardPage(),
      const Icon(Icons.arrow_back),
      const Icon(Icons.arrow_back_outlined),
    ),
    NavItem(
      Menu.seatChart,
      '座席表設定',
      SeatChartPage(),
      const Icon(Icons.grid_4x4),
      const Icon(Icons.grid_4x4_outlined),
    ),
    NavItem(
      Menu.awarenessTemplate,
      '気づきテンプレート',
      AwarenessTemplatePage(),
      const Icon(Icons.lightbulb),
      const Icon(Icons.lightbulb_outlined),
    ),
  ];


  void handleLogout() {
    try {
      ref.read(authNotifierProvider.notifier).logout();
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(dantaisProvider);

    return state.when(
      loading: () {
        return const Column(
          //mainAxisAlignment: MainAxisAlignment.start,
          children: [
            LinearProgressIndicator(),
          ],
        );
      },
      error: (AppException error) {
        return Text('$error');
      },
      loaded: () {
        return switchToPage(context);
      },
    );
  }

  Widget switchToPage(BuildContext context) {
    final selectedIndex = ref.watch(menuProvider).index;

    return Scaffold(
      body: Row(
        children: [
          if (!_isShowMenu) // メニューを非表示の場合は空のコンテナを表示
            Container()
          else
            ColoredBox(
              color: theme.colorScheme.surface,
              child: Column(
                children: [
                  // 左１）アプリアイコンの表示
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                    child: SizedBox(
                      width: 80,
                      child: Image.asset(
                        'assets/icons/default_pkg_icon.png',
                        width: 60,
                        height: 80,
                        color: theme.primaryColor,
                      ),
                    ),
                  ),

                  // 左２）ナビゲーションバー
                  Expanded(
                    child: NavigationRail(
                      selectedIndex: selectedIndex > 5 ? 5: selectedIndex,
                      onDestinationSelected: _onItemTapped,
                      labelType: NavigationRailLabelType.all,
                      destinations: navItems.map((NavItem navItem) {
                        return NavigationRailDestination(
                          icon: navItem.icon,
                          selectedIcon: navItem.selectedIcon,
                          label: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                            child: Text(navItem.title),
                          ),
                        );
                      }).toList(),
                    ),
                  ),

                  // 左３）ログアウトボタン
                  GestureDetector(
                    onTap: handleLogout,
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(8, 10, 8, 25),
                      child: Column(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.exit_to_app),
                            onPressed: handleLogout,
                          ),
                          MyText.bodySmall('ログアウト', fontWeight: 600),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          // 左右の区切り線
          const VerticalDivider(thickness: 1, width: 1),
          // 右）メインコンテンツ
          Expanded(
            child: ColoredBox(
              color: theme.colorScheme.surface,
              child: Column(
                children: [
                  // ヘッダー
                  Container(
                    height: 50,
                    color: theme.colorScheme.surface,
                    padding: const EdgeInsets.fromLTRB(16, 0, 20, 0),
                    child: Row(
                      children: [
                        // 団体DropdownButton
                        const DantaiDropdownWidget(),
                        const ControlTannin(),
                        const ControlDantaiChange(),
                        // IconButton(
                        //   icon: const Icon(Icons.menu),
                        //   onPressed: _setMenu,
                        // ),
                        Expanded(
                          child: Container(
                            alignment: Alignment.center,
                            child: MyText.bodyLarge('', fontWeight: 800),
                          ),
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                        //   child: IconButton(
                        //     icon: const Icon(Icons.campaign_outlined),
                        //     onPressed: () {},
                        //   ),
                        // ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(DateUtil.getJapaneseDate(DateTime.now())),
                            const SizedBox(
                              width: 4,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                const Icon(Icons.person_outlined, size: 16),
                                const SizedBox(
                                  width: 10,
                                ),
                                MyText.bodyMedium(
                                  '${Hive.box<String>('shusekibo').get('user')}',
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // メインコンテンツ
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: selectedIndex > 5 
                      ? settingItems[selectedIndex -5].page 
                      : navItems[selectedIndex].page,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// 定义一个表示导航项的类
class NavItem {
  NavItem(this.menuId, this.title, this.page, this.icon, this.selectedIcon,);
  final Menu menuId;
  final String title;
  final Widget page;
  final Widget icon;
  final Widget selectedIcon;
}
