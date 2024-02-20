
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kyoumutechou/feature/common/provider/common_provider.dart';
import 'package:kyoumutechou/feature/common/widget/filter_widget.dart';
import 'package:kyoumutechou/feature/seat/provider/seat_chart_provider.dart';
import 'package:kyoumutechou/feature/seat/seat_chart_grid_widget.dart';
import 'package:kyoumutechou/feature/seat/seat_chart_list_widget.dart';
import 'package:kyoumutechou/helpers/theme/app_theme.dart';

// 座席表設定画面
class SeatChartPage extends ConsumerWidget {
  SeatChartPage({super.key});

  // draw key
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageType = ref.watch(seatChartPageTypeProvider);

    return Scaffold(
      key: scaffoldKey,
      endDrawer: FilterWidget(),
      body: Container(
        color: theme.colorScheme.surface,
        padding: const EdgeInsets.fromLTRB(12, 0, 12, 8),
        child: pageType == PageType.list
            ? SeatChartListWidget(scaffoldKey: scaffoldKey)
            : SeatChartGridWidget(scaffoldKey: scaffoldKey),
      ),
    );
  }
}
