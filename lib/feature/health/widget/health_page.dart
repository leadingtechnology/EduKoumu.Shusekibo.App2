import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kyoumutechou/feature/boxes.dart';
import 'package:kyoumutechou/feature/common/provider/common_provider.dart';
import 'package:kyoumutechou/feature/common/widget/common_page.dart';
import 'package:kyoumutechou/feature/common/widget/save_button_widget.dart';
import 'package:kyoumutechou/feature/common/widget/toast_helper.dart';
import 'package:kyoumutechou/feature/health/model/health_meibo_model.dart';
import 'package:kyoumutechou/feature/health/provider/health_meibo_provider.dart';
import 'package:kyoumutechou/feature/health/provider/health_provider.dart';
import 'package:kyoumutechou/feature/health/widget/health_list_widget.dart';
import 'package:kyoumutechou/feature/health/widget/health_seat_widget.dart';
import 'package:kyoumutechou/feature/seat/provider/seat_chart_provider.dart';
import 'package:kyoumutechou/feature/seat/provider/seat_setting_provider.dart';
import 'package:kyoumutechou/feature/seat/widget/blank_seat_widget.dart';
import 'package:kyoumutechou/shared/http/app_exception.dart';

// 健康観察widget
class HealthPage extends ConsumerWidget {
  HealthPage({super.key});

  // draw key
  final GlobalKey<ScaffoldState> _healthKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageType = ref.watch(healthPageTypeProvider);
    final buttonEnable = ref.watch(buttonEnableProvider);

    return CommonPage(
      scaffoldKey: _healthKey,
      contentWidget: pageType == PageType.seat
          ? const SeatWidget() // 座位图组件
          : const ListWidget(), // 列表组件, // 列表组件
      onShift: () {
        ref.read(healthPageTypeProvider.notifier).state =
            pageType == PageType.seat ? PageType.list : PageType.seat;
      },
      setBlank: () async {
        await ref.read(healthMeiboListProvider.notifier).updateByBlank();
        helthGlobalKey.currentState?.setBlank();
      },
      saveWidget: SaveButtonWidget(
        label: '保存',
        onPressed: !buttonEnable
            ? null
            : () {
                ref.read(healthMeiboListProvider.notifier).save();
                ToastHelper.showToast(context, '　保存しました　');
              },
      ),
      buttomName: pageType == PageType.seat ? '一覧' : 'テーブル',
      buttonIcon: pageType == PageType.seat ? Icons.list : Icons.grid_view,
    );
  }
}

// 健康観察テーブル
class SeatWidget extends ConsumerStatefulWidget {
  const SeatWidget({super.key});

  @override
  ConsumerState<SeatWidget> createState() => _SeatWidgetState();
}

class _SeatWidgetState extends ConsumerState<SeatWidget> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final list = Boxes.getHealthMeiboBox().values.toList();
      if (list.isEmpty) {
        ToastHelper.showToast(context, '　該当データがありません　');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(healthMeiboListProvider);
    final lp = ref.watch(lecternPositionProvider);

    return state.when(
      loading: () {
        return const Center(child: CircularProgressIndicator());
      },
      error: (AppException e) {
        return Text(e.toString());
      },
      loaded: () {
        return ValueListenableBuilder(
          valueListenable: Boxes.getHealthMeiboBox().listenable(),
          builder: (context, Box<HealthMeiboModel> box, _) {
            final meibos = box.values.toList();
            final newMeibos = <HealthMeiboModel>[];
            
            var rotate = 0.0;
            switch (lp) {
              case LecternPosition.top:
                rotate = 0.0;
              case LecternPosition.bottom:
                rotate = 180.0;
              // ignore: no_default_cases
              default: // Add a default case
                rotate = 0.0;
            }

            var gridColumnCount = 6; 

            if (meibos.isEmpty) {
              return Container();
            }

            // 座席表設定情報取得
            final seats = Boxes.getSeatChart().values.toList();
            if (seats.isNotEmpty) {
              seats.sort((a, b) => a.seatIndex!.compareTo(b.seatIndex!));

              final seatSetting = ref.watch(seatSettingProvider);
              final m = seatSetting.row!;
              final n = seatSetting.column!;
              gridColumnCount = n;

              // 座席ごとにデータを設定する
              for (var i = 0; i < m * n; i++) {
                var meibo = const HealthMeiboModel(
                  studentKihonId: 0,
                  studentSeq: '0',
                );

                try {
                  final seatData = seats.firstWhere((e) => e.seatIndex == i);

                  // 席無し情報の設定
                  if (seatData.seatNumber == 0) {
                    meibo = const HealthMeiboModel(
                      studentKihonId: -1,
                      studentSeq: '-1',
                    );
                  }

                  // 生徒情報の設定
                  if (seatData.seatNumber != 0 && seatData.seitoSeq != '0') {
                    meibo = meibos
                        .firstWhere((e) => e.studentSeq == seatData.seitoSeq);
                  }
                } catch (ex) {
                  //
                }

                newMeibos.add(meibo);
              }
            }

            if (newMeibos.isEmpty) {
              newMeibos.addAll(meibos);
            }

            return Transform.rotate(
              angle: rotate == 0.0 ? 0.0 : 3.14159265358979323846,
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: gridColumnCount,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 2,
                ),
                itemCount: newMeibos.length,
                itemBuilder: (BuildContext context, int index) {
                  final meibo = newMeibos[index];
              
                  if (meibo.studentKihonId == 0) {
                    // 空席
                    return const BlankSeatWidget(
                      width: 150,
                      height: 70,
                    );
                  }
              
                  if (meibo.studentKihonId == -1) {
                    return Container();
                    // return const NoSeatWidget(
                    //   width: 150,
                    //   height: 70,
                    // );
                  }
              
                  return Transform.rotate(
                    angle: rotate == 0.0 ? 0.0 : 3.14159265358979323846,
                    child: HealthSeatWidget(
                      index: index,
                      meibo: meibo,
                    ),
                  );
                },
              ),
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
