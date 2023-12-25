import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kyoumutechou/feature/boxes.dart';
import 'package:kyoumutechou/feature/common/provider/common_provider.dart';
import 'package:kyoumutechou/feature/common/provider/tokobis_provider.dart';
import 'package:kyoumutechou/feature/common/widget/common_page.dart';
import 'package:kyoumutechou/feature/common/widget/save_button_widget.dart';
import 'package:kyoumutechou/feature/common/widget/toast_helper.dart';
import 'package:kyoumutechou/feature/health/model/health_meibo_model.dart';
import 'package:kyoumutechou/feature/health/provider/health_meibo_provider.dart';
import 'package:kyoumutechou/feature/health/provider/health_provider.dart';
import 'package:kyoumutechou/feature/health/widget/health_list_widget.dart';
import 'package:kyoumutechou/feature/health/widget/health_seat_widget.dart';
import 'package:kyoumutechou/shared/http/app_exception.dart';

// 健康観察widget
class HealthPage extends ConsumerWidget {
  HealthPage({super.key});

  // draw key
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageType = ref.watch(healthPageTypeProvider);
    final isEditable = ref.watch(isTokobiProvider);

    return CommonPage(
      scaffoldKey: _scaffoldKey,
      contentWidget: pageType == PageType.seat
          ? const SeatWidget() // 座位图组件
          : const ListWidget(), // 列表组件, // 列表组件
      onShift: () {
        ref.read(healthPageTypeProvider.notifier).state =
            pageType == PageType.seat
                ? PageType.list
                : PageType.seat;
      },
      setBlank: !isEditable ? null :  () {
        ref.read(healthMeiboListProvider.notifier).updateByBlank();
        helthGlobalKey.currentState?.setBlank();
      },
      saveWidget: ValueListenableBuilder(
        valueListenable: Boxes.getHealthMeiboBox().listenable(),
        builder: (context, Box<HealthMeiboModel> box, _) {

          return SaveButtonWidget(
            label: '保存',
            onPressed: !isEditable ? null :(){
              ref.read(healthMeiboListProvider.notifier).save();
              ToastHelper.showToast(context, '　保存しました　');
            },
          );
        },
      ),
      buttomName: pageType == PageType.seat ? '一覧' : 'テーブル',
      buttonIcon: pageType == PageType.seat ? Icons.list : Icons.grid_view,
    );
  }
}

// 健康観察テーブル
class SeatWidget extends ConsumerWidget {
  const SeatWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(healthMeiboListProvider);

    return state.when(
      loading: (){
        return const Center(child: CircularProgressIndicator());
      }, 
      error: (AppException e){ return Text(e.toString()); },
      loaded: (){
        return ValueListenableBuilder(
          valueListenable: Boxes.getHealthMeiboBox().listenable(), 
          builder: (context, Box<HealthMeiboModel> box, _){
            final meibos = box.values.toList();

            if (meibos.isEmpty) {
              return const Center(child: Text('該当データありません'));
            }

            return GridView.builder(
                    gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 6,
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 15,
                      childAspectRatio: 2,
                    ),
                    itemCount: meibos.length, 
                    itemBuilder: (BuildContext context, int index) {
                      return HealthSeatWidget(
                        index: index, 
                        healthMeibo: meibos[index],
                      );
                    },
            );
          },
        );
      }, 
    );
  }
}

class ListWidget extends ConsumerWidget {
  const ListWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(healthMeiboListProvider);

    return state.when(
      loading: () {
        return const Center(child: CircularProgressIndicator());
      },
      error: (AppException e) {
        return Center(child: Text(e.toString()));
      },
      loaded: () {
        return HealthListWidget(
          key: helthGlobalKey,
        );
      },
    );
  }
}
