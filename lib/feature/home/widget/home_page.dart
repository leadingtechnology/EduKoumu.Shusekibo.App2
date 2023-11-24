import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kyoumutechou/feature/attendance/widget/attendance_page.dart';
import 'package:kyoumutechou/feature/attendance/widget/attendance_timed_page.dart';
import 'package:kyoumutechou/feature/auth/provider/auth_provider.dart';
import 'package:kyoumutechou/feature/awareness/weidget/awareness_page.dart';
import 'package:kyoumutechou/feature/dashboard/widget/dashboard_page.dart';
import 'package:kyoumutechou/feature/health/widget/health_page.dart';
import 'package:kyoumutechou/feature/home/provider/books_provider.dart';
import 'package:kyoumutechou/feature/home/widget/row_book_widget.dart';
import 'package:kyoumutechou/helpers/theme/app_theme.dart';
import 'package:kyoumutechou/helpers/widgets/my_text.dart';
import 'package:kyoumutechou/shared/http/app_exception.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends ConsumerState<HomePage> {
  int _selectedIndex = 0;
  bool _isShowMenu = true;
  String dropdownValue = 'One';

  late ThemeData theme;

  @override
  void initState() {
    super.initState();
    theme = AppTheme.lightTheme;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _setMenu() {
    setState(() {
      _isShowMenu = !_isShowMenu;
    });
  }

  // ナビゲーションバーのアイテム
  final List<NavItem> navItems = [
    NavItem(
      'ホーム', 
      const DashboardPage(), 
      Icons.home, 
      Icons.home_outlined,
    ),
    NavItem(
      '健康観察', 
      const HealthPage(), 
      Icons.medical_services, 
      Icons.medical_services_outlined,
    ),
    NavItem(
      '出欠(日)', 
      const AttendancePage(), 
      Icons.content_paste, 
      Icons.content_paste_outlined,
    ),
    NavItem(
      '出欠(時限)', 
      const AttendanceTimedPage(), 
      Icons.content_paste, 
      Icons.content_paste_outlined,
    ),
    NavItem(
      '気づき', 
      const AwarenessPage(), 
      Icons.lightbulb, 
      Icons.lightbulb_outlined,
    ),
    // NavItem(
    //   '設定', 
    //   Page2(), 
    //   Icons.settings, 
    //   Icons.settings_outlined,
    // ),
  ];

  // 在类的其他部分定义 handleLogout 方法
  void handleLogout() {
    try {
      ref.read(authNotifierProvider.notifier).logout();
      // 可以在这里添加其他逻辑，比如导航到登录页面
    } catch (error) {
      // 处理错误，比如显示错误信息
    }
  }

  @override
  Widget build(BuildContext context) {
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
                      selectedIndex: _selectedIndex,
                      onDestinationSelected: _onItemTapped,
                      labelType: NavigationRailLabelType.all,
                      destinations: navItems.map((NavItem navItem) {
                        return NavigationRailDestination(
                          icon: Icon(navItem.icon),
                          selectedIcon: Icon(navItem.selectedIcon),
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
            child: Column(
              children: [
                // ヘッダー
                Container(
                  height: 50,
                  color: theme.colorScheme.surface,
                  child: Row(
                    children: [
                      // 団体DropdownButton
                      DropdownButton<String>(
                        value: dropdownValue,
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdownValue = newValue!;
                          });
                        },
                        items: <String>['One', 'Two', 'Three', 'Four']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),

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
                      IconButton(
                        icon: const Icon(Icons.search),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: const Icon(Icons.notifications),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),

                // メインコンテンツ
                Expanded(
                  child: navItems[_selectedIndex].page,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // @override
  // Widget build(BuildContext context, WidgetRef ref) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       backgroundColor: Colors.blueGrey,
  //       title:   Text('home'.tr()),
  //       actions: <Widget>[
  //         IconButton(
  //           icon: const Icon(Icons.logout),
  //           onPressed: () {
  //             //ref.read(routerProvider).go(SignInRoute.path);
  //             ref.read(authNotifierProvider.notifier).logout();
  //           },
  //         ),
  //       ],
  //     ),
  //     body: _widgetContent(context, ref),
  //   );

  Widget _widgetLoading(BuildContext context, WidgetRef ref) {
    return Center(
      child: Text('loading'.tr()),
    );
  }

  Widget _widgetContent(BuildContext context, WidgetRef ref) {
    final state = ref.watch(booksNotifierProvider);

    return state.when(
      loading: () {
        return _widgetLoading(context, ref);
      },
      booksLoaded: (books) {
        return ListView.builder(
          itemCount: books.length,
          itemBuilder: (BuildContext context, int index) {
            return RowBookWidget(book: books[index]);
          },
        );
      },
      error: (AppException error) {
        return _widgetLoading(context, ref);
      },
    );
  }
}


// 定义一个表示导航项的类
class NavItem {
  NavItem(this.title, this.page,  this.icon, this.selectedIcon);
  
  final String title;
  final Widget page;
  final IconData icon;
  final IconData selectedIcon;
}
