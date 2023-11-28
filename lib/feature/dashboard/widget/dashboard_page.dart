import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kyoumutechou/feature/dashboard/widget/attendance_summary_widget.dart';
import 'package:kyoumutechou/feature/dashboard/widget/health_summary_widget.dart';
import 'package:kyoumutechou/helpers/theme/app_theme.dart';
import 'package:kyoumutechou/helpers/utils/my_shadow.dart';
import 'package:kyoumutechou/helpers/widgets/my_card.dart';
import 'package:kyoumutechou/helpers/widgets/my_spacing.dart';

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
        preferredSize: Size.fromHeight(50.0),
        child: AppBar(
          bottom: TabBar(
            controller: tabController,
            isScrollable: true,
            labelColor: Theme.of(context).colorScheme.primary,
            labelStyle: const TextStyle(fontWeight: FontWeight.bold),
            unselectedLabelColor: Colors.grey,
            indicatorColor: Theme.of(context).colorScheme.primary,
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
              // Tab(child:Text(
              //   '欠席者一覧',
              //   style: TextStyle(fontFamily: 'NotoSansJP'),
              // ),),
            ],
          ),
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: const <Widget>[
          HealthSummary(),
          AttendanceSummaryWidget(),
          MyCard(
            child: Column(
              children: [
                Row(
                  children: [
                    Text('欠席者一覧'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
