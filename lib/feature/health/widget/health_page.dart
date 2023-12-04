import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kyoumutechou/feature/common/provider/common.provider.dart';
import 'package:kyoumutechou/feature/common/widget/common_page.dart';
import 'package:kyoumutechou/feature/health/provider/health_provider.dart';
import 'package:kyoumutechou/feature/health/widget/health_list_widget.dart';
import 'package:kyoumutechou/feature/health/widget/health_seat_widget.dart';

// 健康観察widget
class HealthPage extends ConsumerWidget {
  HealthPage({super.key});

  // draw key
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageType = ref.watch(healthPageTypeProvider);

    return CommonPage(
      scaffoldKey: _scaffoldKey,
      contentWidget: pageType == PageType.seat
          ? HealthSeatWidget() // 座位图组件
          : HealthListWidget(), // 列表组件, // 列表组件
      onShift: () {
        ref.read(healthPageTypeProvider.notifier).state =
            pageType == PageType.seat
                ? PageType.list
                : PageType.seat;
      },
      setBlank: () {},
      onSavePressed: () {},
    );

  }
}
