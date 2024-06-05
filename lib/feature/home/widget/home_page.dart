import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kyoumutechou/feature/attendance/widget/attendance_page.dart';
import 'package:kyoumutechou/feature/attendance/widget/attendance_timed_page.dart';
import 'package:kyoumutechou/feature/auth/provider/auth_provider.dart';
import 'package:kyoumutechou/feature/awareness/weidget/awareness_page.dart';
import 'package:kyoumutechou/feature/common/provider/common_provider.dart';
import 'package:kyoumutechou/feature/common/provider/dantais_provider.dart';
import 'package:kyoumutechou/feature/common/widget/control_dantai_change.dart';
import 'package:kyoumutechou/feature/common/widget/control_tannin.dart';
import 'package:kyoumutechou/feature/common/widget/dantai_dropdown_widget.dart';
import 'package:kyoumutechou/feature/dashboard/widget/dashboard_page.dart';
import 'package:kyoumutechou/feature/health/widget/health_page.dart';
import 'package:kyoumutechou/feature/home/provider/home_provider.dart';
import 'package:kyoumutechou/feature/kizuki/widget/kizuki_template_page.dart';
import 'package:kyoumutechou/feature/linkage/widget/contact_linkage_widget.dart';
import 'package:kyoumutechou/feature/seat/seat_chart_page.dart';
import 'package:kyoumutechou/feature/setting/setting_page.dart';
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

  // メニュー関連
  final List<NavItem> navItems = [];
  final List<NavItem> settingItems = [
    NavItem(
      Menu.modoru,
      '戻る',
      const DashboardPage(),
      const Icon(Icons.arrow_back),
      const Icon(Icons.arrow_back_outlined),
    ),
  ];

  late String menuHome;
  late String menuHealth;
  late String menuAttendance;
  late String menuAttendanceTime;
  late String menuAwareness;
  late String menuSetting;
  late String menuSettingSeats;
  late String menuSettingTemplate;

  int settingIndex = 99;

  // ドラグアンドドロップ関連
  final dialogWidth = 550.0;
  final dialogHeight = 600.0;
  final _globalKey = GlobalKey();
  Offset dialogOffset = Offset.zero;

  @override
  void initState() {
    super.initState();
    theme = AppTheme.lightTheme;

    initialMenu();
  }

  void initialMenu() {
    //ホーム
    menuHome = '1';
    if (dotenv.env['Menu_Home'] != null) {
      menuHome = dotenv.env['Menu_Home'] ?? '1';
    }
    if (menuHome == '1') {
      // 0
      navItems.add(
        NavItem(
          Menu.dashboard,
          'ホーム',
          const DashboardPage(),
          const Icon(Icons.home),
          const Icon(Icons.home_outlined),
        ),
      );
    }

    //健康観察
    menuHealth = '1';
    if (dotenv.env['Menu_Health'] != null) {
      menuHealth = dotenv.env['Menu_Health'] ?? '1';
    }
    if (menuHealth == '1') {
      navItems.add(
        NavItem(
          Menu.health,
          '健康観察',
          HealthPage(),
          const FaIcon(
            FontAwesomeIcons.stethoscope,
          ),
          const FaIcon(
            FontAwesomeIcons.stethoscope,
          ),
        ),
      );
    }

    //出欠(日)
    menuAttendance = '1';
    if (dotenv.env['Menu_Attendance'] != null) {
      menuAttendance = dotenv.env['Menu_Attendance'] ?? '1';
    }
    if (menuAttendance == '1') {
      navItems.add(
        NavItem(
          Menu.attendance,
          '出欠(日)',
          AttendancePage(),
          const Icon(Icons.content_paste),
          const Icon(Icons.content_paste_outlined),
        ),
      );
    }

    //出欠(時限)
    menuAttendanceTime = '1';
    if (dotenv.env['Menu_Attendance_Time'] != null) {
      menuAttendanceTime = dotenv.env['Menu_Attendance_Time'] ?? '1';
    }
    if (menuAttendanceTime == '1') {
      navItems.add(
        NavItem(
          Menu.attendanceTimed,
          '出欠(時限)',
          AttendanceTimedPage(),
          const Icon(Icons.content_paste),
          const Icon(Icons.content_paste_outlined),
        ),
      );
    }

    //気づき
    menuAwareness = '1';
    if (dotenv.env['Menu_Awareness'] != null) {
      menuAwareness = dotenv.env['Menu_Awareness'] ?? '1';
    }
    if (menuAwareness == '1') {
      navItems.add(
        NavItem(
          Menu.awareness,
          '気づき',
          const AwarenessPage(),
          const Icon(Icons.lightbulb),
          const Icon(Icons.lightbulb_outlined),
        ),
      );
    }

    //設定
    menuSetting = '1';
    if (dotenv.env['Menu_Setting'] != null) {
      menuSetting = dotenv.env['Menu_Setting'] ?? '1';
    }
    if (menuSetting == '1') {
      navItems.add(
        NavItem(
          Menu.setting,
          '設定',
          const SettingPage(),
          const Icon(Icons.settings),
          const Icon(Icons.settings_outlined),
        ),
      );

      settingIndex = navItems.length - 1;
    }

    // メニュー数が＜２の場合、重複メニューを追加する。
    if (navItems.length == 1) {
      navItems.add(navItems[0]);
    }

    //座席表設定
    menuSettingSeats = '1';
    if (dotenv.env['Menu_Setting_Seats'] != null) {
      menuSettingSeats = dotenv.env['Menu_Setting_Seats'] ?? '1';
    }
    if (menuSettingSeats == '1') {
      settingItems.add(
        NavItem(
          Menu.seatChart,
          '座席表設定',
          SeatChartPage(),
          const Icon(Icons.grid_4x4),
          const Icon(Icons.grid_4x4_outlined),
        ),
      );
    }

    //気づきテンプレート
    menuSettingTemplate = '1';
    if (dotenv.env['Menu_Setting_Template'] != null) {
      menuSettingTemplate = dotenv.env['Menu_Setting_Template'] ?? '1';
    }
    if (menuSettingTemplate == '1') {
      settingItems.add(
        NavItem(
          Menu.awarenessTemplate,
          '気づきテンプレート',
          const KizukiTemplatePage(),
          const Icon(Icons.lightbulb),
          const Icon(Icons.lightbulb_outlined),
        ),
      );
    }

  }  

  void _onItemTapped(int index) {
    ref.read(menuIndexProvider.notifier).state = index;
    
    ref.read(menuProvider.notifier).state = navItems[index].menuId;
  }


  void handleLogout() {
    try {
      ref.read(authNotifierProvider.notifier).logout();
    } catch (error) {
      //print(error);
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
    final selectedIndex = ref.watch(menuIndexProvider);
    final isCA = ref.watch(isContactAllowedProvider);
    final isDialogVisible = ref.watch(isDialogVisibleProvider);
    final screenWidth = MediaQuery.of(context).size.width;
    if (!isDialogVisible){
      var w = screenWidth - dialogWidth - 10;
      if (w <0 ) w = 0;

      dialogOffset = Offset(w, 68);
    }

    return Scaffold(
      body: Stack(
        key: _globalKey,
        children: [
      Row(
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
                      selectedIndex: selectedIndex > settingIndex
                          ? settingIndex
                          : selectedIndex,
                      onDestinationSelected: _onItemTapped,
                      labelType: NavigationRailLabelType.all,
                      destinations: [
                        for (int i = 0; i < navItems.length; i++)
                          NavigationRailDestination(
                            icon: navItems[i].icon,
                            selectedIcon: navItems[i].selectedIcon,
                            label: Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                              child: Text(navItems[i].title),
                            ),
                          ),
                      ],
                      // navItems.map((NavItem navItem) {
                      //   return NavigationRailDestination(
                      //     icon: navItem.icon,
                      //     selectedIcon: navItem.selectedIcon,
                      //     label: Padding(
                      //       padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                      //       child: Text(navItem.title),
                      //     ),
                      //   );
                      // }).toList(),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                    child: Divider(
                      thickness: 1,
                      height: 1,
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
                        if (isCA)
                        // Padding(
                        //   padding: const EdgeInsets.fromLTRB(0, 10, 20, 0),
                        //   child: GestureDetector(
                        //     onTap: () {
                        //       ref
                        //           .read(isDialogVisibleProvider.notifier)
                        //           .state = !isDialogVisible;
                        //     },
                        //     child: Container(
                        //       padding: const EdgeInsets.all(10),
                        //       decoration: BoxDecoration(
                        //         color: isDialogVisible
                        //             ? Colors.blue[100]
                        //             : Colors.white,
                        //         shape: BoxShape.circle,
                        //         boxShadow: [
                        //           BoxShadow(
                        //             color: Colors.grey.withOpacity(0.5),
                        //             spreadRadius: 5,
                        //             blurRadius: 7,
                        //             offset: const Offset(0, 3), 
                        //           ),
                        //         ],
                        //       ),
                        //       child: Center(
                        //         child: Icon(
                        //           Icons.campaign_outlined,
                        //           color: isDialogVisible
                        //               ? Colors.blue
                        //               : Colors.black,
                        //           size: 30,
                        //         ),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 18, 0),
                          child: IconButton(
                            icon: const Icon(Icons.campaign_outlined),
                            iconSize: 30,
                            onPressed: () async{
                                  ref
                                      .read(isDialogVisibleProvider.notifier)
                                      .state = !isDialogVisible;
                            },
                          ),
                        ),
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
                                const Icon(Icons.person_outlined, size: 24),
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
                      child: selectedIndex > settingIndex
                          ? settingItems[selectedIndex - settingIndex].page
                          : navItems[selectedIndex].page,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      
      // 通知画面
      if (isDialogVisible)
        Positioned(
          left: dialogOffset.dx,
          top: dialogOffset.dy,
          child: GestureDetector(
            onTap: () {},
            child: Draggable(
              feedback: _buildBox(),
              childWhenDragging: Container(),
              child: LayoutBuilder(
                    builder: (context, constraints) {
                      return _buildDialog();
                    },
                  ),
              onDragEnd: (details) {
                    final renderBox = _globalKey.currentContext!
                        .findRenderObject()! as RenderBox;
                    var boxOffset = renderBox.globalToLocal(details.offset);
            
                    if(boxOffset.dx < 0){
                      boxOffset = Offset(0, boxOffset.dy);
                    }
                    if(boxOffset.dy < 0){
                      boxOffset = Offset(boxOffset.dx, 0);
                    }
                    if(boxOffset.dx > renderBox.size.width - dialogWidth){
                      boxOffset = Offset(renderBox.size.width - dialogWidth, boxOffset.dy);
                    }
                    if(boxOffset.dy > renderBox.size.height - dialogHeight){
                      boxOffset = Offset(boxOffset.dx, renderBox.size.height - dialogHeight);
                    }
                    
                setState(() {
                  dialogOffset = boxOffset;
                });
              },
            ),
          ),
        ),

    ],),
    );
  }

  Widget _buildBox() {
    // 枠線ありのコンテナ
    return Container(
      width: dialogWidth,
      height: dialogHeight,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey, // Border color
          width: 4, // Border width
        ),
      ),
      child: const Center(
        child: Text(''),
      ),
    );
  }

  Widget _buildDialog() {
    return Container(
      width: dialogWidth,
      height: dialogHeight,      
      margin: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top,
      ),
      child: const ContactLinkageWidget(),
    );
  }
}

// ナビゲーションバーのアイテム
class NavItem {
  NavItem(
    this.menuId,
    this.title,
    this.page,
    this.icon,
    this.selectedIcon,
  );
  final Menu menuId;
  final String title;
  final Widget page;
  final Widget icon;
  final Widget selectedIcon;
}

// Future<void> showCustomDialog(
//   BuildContext context, 
//   WidgetRef ref,
// ) async{

//   await showGeneralDialog(
//     context: context,
//     barrierDismissible: true, 
//     barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
//     transitionDuration: const Duration(milliseconds: 200),
//     pageBuilder: (
//       BuildContext buildContext, 
//       Animation animation,
//       Animation secondaryAnimation,
//     ) {

//       return ContactLinkageDialog();


//       // return SafeArea(
//       //   child: Align(
//       //     alignment: Alignment.topRight, 
//       //     child: Container(
//       //       margin: const EdgeInsets.only(top: 56, right: 16), 
//       //       width: 200, 
//       //       height: 100, 
//       //       decoration: BoxDecoration(
//       //         color: Colors.white,
//       //         borderRadius: BorderRadius.circular(4),
//       //       ),
//       //       child: const Material(
//       //         child: Column(
//       //           children: <Widget>[
//       //             Text('タイトル', style: TextStyle(fontSize: 24)),
//       //             Text('コンテンツ'),
//       //           ],
//       //         ),
//       //       ),
//       //     ),
//       //   ),
//       // );
//     },
//   );
// }

// Future<Object?> showDialog111(BuildContext context, WidgetRef ref) async {
//   final state = ref.watch(contactLinkageNotifierProvider);

//   return state.when(
//     loading: () {
//       return const Center(child: CircularProgressIndicator());
//     },
//     error: (AppException e) {
//       return Text(e.toString());
//     },
//     loaded: (list) {
//       showCustomDialog(context, ref);
//     },
//   );
// }
