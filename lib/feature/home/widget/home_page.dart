import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kyoumutechou/feature/home/provider/books_provider.dart';
import 'package:kyoumutechou/feature/home/widget/row_book_widget.dart';
import 'package:kyoumutechou/helpers/theme/app_theme.dart';
import 'package:kyoumutechou/shared/http/app_exception.dart';


class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends ConsumerState<HomePage> {
  
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  late ThemeData theme;
  @override
  void initState() {
    super.initState();
    theme = AppTheme.lightTheme;

  }

  Widget _getPage(int index) {
    switch (index) {
      case 0:
        return Page1();
      case 1:
        return Page2();
      case 2:
        return Page3();
      case 3:
        return Page3();
      case 4:
        return Page3();
      case 5:
        return Page3();
      default:
        return const Center(child: Text('Page not found'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Container(
            color: theme.colorScheme.surface,
            child: Column(
              children: [
                // アイコンの表示
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
                Expanded(
                  child: NavigationRail(
                    selectedIndex: _selectedIndex,
                    onDestinationSelected: _onItemTapped,
                    labelType: NavigationRailLabelType.all,
                    destinations: const [
                      NavigationRailDestination(
                        //icon: Icon(FontAwesomeIcons.house),
                        //selectedIcon: Icon(FontAwesomeIcons.house, ),
                        icon: Icon(Icons.home),
                        selectedIcon: Icon(Icons.home_outlined),
                        label: Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                          child: Text('ホーム'),
                        ),
                      ),
            
                      NavigationRailDestination(
                        icon: Icon(Icons.medical_services),
                        selectedIcon: Icon(Icons.medical_services_outlined),
                        label: Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                          child: Text('健康観察'),
                        ),
                      ),
            
                      NavigationRailDestination(
                        icon: Icon(Icons.content_paste),
                        selectedIcon: Icon(Icons.content_paste_outlined),
                        label: Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                          child: Text('出欠(日)'),
                        ),
                      ),
            
                      NavigationRailDestination(
                        icon: Icon(Icons.content_paste),
                        selectedIcon: Icon(Icons.content_paste_outlined),
                        label: Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                          child: Text('出欠(時限)'),
                        ),
                      ),
            
                      NavigationRailDestination(
                        icon: Icon(Icons.lightbulb),
                        selectedIcon: Icon(Icons.lightbulb_outlined),
                        label: Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                          child: Text('気づき'),
                        ),
                      ),
            
                      // NavigationRailDestination(
                      //   icon: Icon(Icons.settings),
                      //   selectedIcon: Icon(Icons.settings_outlined),
                      //   label: Padding(
                      //     padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                      //     child: Text('設定'),
                      //   ),
                      // ),
            
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 10, 8, 25),
                  child: Column(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.exit_to_app),
                        onPressed: () {}, // 退出按钮逻辑
                      ),
                      const Text('ログアウト'),
                    ],
                  ),
                ),
              ],
            ),
          ),
          VerticalDivider(thickness: 1, width: 1),
          Expanded(
            child: _getPage(_selectedIndex),
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
            },);
      },
      error: (AppException error) {
        return _widgetLoading(context, ref);
      },
    );
  }
}

class Page1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Selected Page: 1',
        style: Theme.of(context).textTheme.headline4,
      ),
    );
  }
}
class Page2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Selected Page: 2',
        style: Theme.of(context).textTheme.headline4,
      ),
    );
  }
}

class Page3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Selected Page: 3',
        style: Theme.of(context).textTheme.headline4,
      ),
    );
  }
}
