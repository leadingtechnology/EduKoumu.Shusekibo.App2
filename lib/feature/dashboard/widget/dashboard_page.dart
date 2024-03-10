import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kyoumutechou/feature/common/provider/tokobis_provider.dart';
import 'package:kyoumutechou/feature/dashboard/widget/absence_summary_widget.dart';
import 'package:kyoumutechou/feature/dashboard/widget/attendance_summary_widget.dart';
import 'package:kyoumutechou/feature/dashboard/widget/health_summary_widget.dart';
import 'package:kyoumutechou/helpers/theme/app_theme.dart';
import 'package:kyoumutechou/helpers/widgets/my_spacing.dart';
import 'package:kyoumutechou/shared/util/date_util.dart';

// ダッシュボードwidget
class DashboardPage extends ConsumerStatefulWidget {
  const DashboardPage({super.key});
  @override
  DashboardPageState createState() => DashboardPageState();
}

class DashboardPageState extends ConsumerState<DashboardPage>
    with SingleTickerProviderStateMixin {
  late ThemeData theme;

  int currentIndex = 0;
  TabController? tabController;

  @override
  void initState() {
    super.initState();

    theme = AppTheme.theme;
    tabController = TabController(length: 3, vsync: this);
  }

  void onTapped(int value) {
    setState(() {
      currentIndex = value;
    });
  }

  @override
  void dispose() {
    super.dispose();
    tabController!.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: AppBar(
          title: Column(
            children: [
              MySpacing.height(10),
              Row(
                children: [
                  Text(
                    '${DateUtil.getJpMonthDayWeek(DateTime.now())}の出欠人数等（クラス別）',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold, 
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ],
          ),
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
                  '健康観察簿',
                  style: TextStyle(fontFamily: 'NotoSansJP'),
                ),
              ),
              Tab(
                child: Text(
                  '出席簿',
                  style: TextStyle(fontFamily: 'NotoSansJP'),
                ),
              ),
              Tab(child:Text(
                '欠席者一覧',
                style: TextStyle(fontFamily: 'NotoSansJP'),
              ),),
            ],
          ),
        ),
      ),
      body: ColoredBox(
        color: theme.colorScheme.background,
        child: TabBarView(
          controller: tabController,
          children: const <Widget>[
            HealthSummaryWidget(),
            AttendanceSummaryWidget(),
            AbsenceSummaryWidget(),
          ],
        ),
      ),
    );
  }
}
