import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kyoumutechou/feature/awareness/model/awareness_common.dart';
import 'package:kyoumutechou/feature/awareness/model/awareness_kizuki_model.dart';
import 'package:kyoumutechou/feature/awareness/provider/awareness_kizuki_provider.dart';
import 'package:kyoumutechou/feature/awareness/provider/awareness_meibo_provider.dart';
import 'package:kyoumutechou/feature/awareness/provider/tenpu_provider.dart';
import 'package:kyoumutechou/feature/awareness/weidget/awareness_list_page.dart';
import 'package:kyoumutechou/feature/awareness/weidget/awareness_seat_page.dart';
import 'package:kyoumutechou/feature/awareness/weidget/dialog/awareness_regist_dialog.dart';
import 'package:kyoumutechou/feature/boxes.dart';
import 'package:kyoumutechou/feature/common/provider/filter_provider.dart';
import 'package:kyoumutechou/feature/common/widget/dialog_util.dart';
import 'package:kyoumutechou/feature/common/widget/filter_widget.dart';
import 'package:kyoumutechou/feature/common/widget/seat_chart_pattern_widget.dart';
import 'package:kyoumutechou/feature/common/widget/toast_helper.dart';
import 'package:kyoumutechou/helpers/theme/app_theme.dart';
import 'package:kyoumutechou/helpers/widgets/my_spacing.dart';

// 気づきwidget
class AwarenessPage extends ConsumerStatefulWidget {
  const AwarenessPage({super.key});

  @override
  AwarenessPageState createState() => AwarenessPageState();
}

class AwarenessPageState extends ConsumerState<AwarenessPage> 
    with SingleTickerProviderStateMixin {
  
  late ThemeData theme;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();


  int currentIndex = 0;
  TabController? tabController;

  @override
  void initState() {
    super.initState();

    theme = AppTheme.theme;
    tabController = TabController(length: 2, vsync: this);

    tabController?.addListener(_handleTabChange);
  }

  void _handleTabChange() {
    if (tabController!.indexIsChanging) {
      setState(() {
        currentIndex = tabController!.index;
      });
      ref.read(awarenessTabIndexProvider.notifier).state = currentIndex;

      if (ref.watch(isStudentIdProvider) == true) {
        ref.read(isStudentIdProvider.notifier).state = false;

        // 生徒Widgetからの場合、開始終了日が当日に設定する
        ref.read(beginDateProvider.notifier).state = DateTime.now();
        ref.read(endDateProvider.notifier).state = DateTime.now();

        // 検索条件も更新する
        ref.read(filterProvider.notifier).updateAwarenessFilter(
              beginDate: DateTime.now(),
            );
      }else{
        ref.read(studentIdProvider.notifier).state = 0;

        // 生徒Widgetからの場合、開始終了日が7日間に設定する
        ref.read(beginDateProvider.notifier).state =
            DateTime.now().subtract(const Duration(days: 7));
        ref.read(endDateProvider.notifier).state = DateTime.now();

        // 検索条件も更新する
        ref.read(filterProvider.notifier).updateAwarenessFilter();
      }
    }
  }

  @override
  void dispose() {
    tabController?.removeListener(_handleTabChange);
    tabController!.dispose();
    super.dispose();
  }  

  @override
  Widget build(BuildContext context) {
    final count = ref.watch(awarenessCountProvider);

    return Scaffold(
      key: _scaffoldKey,
      endDrawer: FilterWidget(isPeriod: true),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          bottom: TabBar(
            controller: tabController,
            isScrollable: true,
            labelColor: theme.colorScheme.primary,
            labelStyle: const TextStyle(fontWeight: FontWeight.bold),
            unselectedLabelColor: Colors.grey,
            indicatorColor: theme.colorScheme.primary,
            tabs: const <Widget>[
              Tab(
                child: Text(
                  '本日の様子',
                  style: TextStyle(fontFamily: 'NotoSansJP'),
                ),
              ),
              Tab(
                child: Text(
                  '最近の気づき',
                  style: TextStyle(fontFamily: 'NotoSansJP'),
                ),
              ),
            ],
          ),
        ),
      ),
      body: ColoredBox(
        color: theme.colorScheme.surface,
        child: Column(
          children: [
            Expanded(
              child: ColoredBox(
                //padding: MySpacing.all(8),
                color: theme.colorScheme.background,
                child: TabBarView(
                  controller: tabController,
                  children: <Widget>[
                    AwarenessSeatPage(_scaffoldKey, tabController!),
                    AwarenessListPage(_scaffoldKey),
                  ],
                ),
              ),
            ),
        
            // ここから下は、タブバーの下に表示するwidget
            MySpacing.height(8),
            if (currentIndex == 0 ) 
            ColoredBox(
              color: theme.colorScheme.surface,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: Container()),
                  const SeatChartPatternWidget(),
                  MySpacing.width(30),
                  OutlinedButton.icon(
                    onPressed: count <= 0
                        ? null
                        : () async {
                            await _handlePressActionButton(context);
                          },
                    label: const Text(' 気づきの登録 '),
                    icon: const Icon(Icons.add),
                    style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.black,
                          backgroundColor: Colors.white,
                          fixedSize: const Size(180, 36),
                          side: const BorderSide(
                              color: Colors.black87,),
                          shape: const StadiumBorder(),
                          elevation: 8,),
              
                  ),
                ],
              ),
            ),
            if (currentIndex == 1 ) 
              ColoredBox(
                color: theme.colorScheme.surface,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: Container()),
                    OutlinedButton.icon(
                      onPressed: () async {
                              await _handlePressActionButton2(context);
                            },
                      label: const Text(' 気づきの登録 '),
                      icon: const Icon(Icons.add),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.black,
                        backgroundColor: Colors.white,
                        fixedSize: const Size(180, 36),
                        side: const BorderSide(
                          color: Colors.black87,
                        ),
                        shape: const StadiumBorder(),
                        elevation: 8,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Future<void> _handlePressActionButton(BuildContext context) async {
    ref.read(tenpuListProvider.notifier).init();  

    ref.read(awarenessJuyoProvider.notifier).state = false;

    final length = Boxes.getAwarenessMeiboBox()
        .values
        .toList()
        .where(
          (e) => e.selectFlag ?? false,
        )
        .toList()
        .length;

    if (length <= 0) {
      ToastHelper.showToast(context, '　生徒を選択してください　');
      ref.read(awarenessCountProvider.notifier).state = 0;
      return;
    }

    await DialogUtil.show(
      context: context,
      builder: (BuildContext context) {
        return AwarenessRegistDialog(
            kizuki: const AwarenessKizukiModel(
          id: 0,
        ),);
      },
    );
  }  

  Future<void> _handlePressActionButton2(BuildContext context) async {
    ref.read(tenpuListProvider.notifier).init();
    ref.read(awarenessJuyoProvider.notifier).state = false;

    await DialogUtil.show(
      context: context,
      builder: (BuildContext context) {
        return AwarenessRegistDialog(
          kizuki: const AwarenessKizukiModel(
            id: 0,
          ),
          opt: AwarenessOperationItem.addNoUser,
        );
      },
    );
  }  
}
