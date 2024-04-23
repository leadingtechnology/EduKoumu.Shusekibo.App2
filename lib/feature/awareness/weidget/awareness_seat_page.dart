import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kyoumutechou/feature/awareness/model/awareness_meibo_model.dart';
import 'package:kyoumutechou/feature/awareness/weidget/awareness_seat_widget.dart';
import 'package:kyoumutechou/feature/boxes.dart';
import 'package:kyoumutechou/feature/common/provider/common_provider.dart';
import 'package:kyoumutechou/feature/common/provider/seat_chart_pattern_provider.dart';
import 'package:kyoumutechou/feature/common/widget/search_bar_widget.dart';
import 'package:kyoumutechou/feature/linkage/widget/lectern_widget.dart';
import 'package:kyoumutechou/feature/seat/provider/seat_chart_provider.dart';
import 'package:kyoumutechou/feature/seat/widget/blank_seat_widget.dart';
import 'package:kyoumutechou/helpers/widgets/my_spacing.dart';

class AwarenessSeatPage extends ConsumerWidget {
  const AwarenessSeatPage(
    this._scaffoldKey, 
    this.tabController,
    {super.key,}
  );

  // draw key
  final GlobalKey<ScaffoldState> _scaffoldKey;
  final TabController tabController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lecternPosition = ref.watch(lecternPositionProvider);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SearchBarWidget(_scaffoldKey, isPeriod: false),

        // screen
        MySpacing.height(8),
        Expanded(
          child: Column(
            children: [
              if (lecternPosition == LecternPosition.top)
                const SizedBox(height: 10, child: LecternWidget(title: '')),
              Expanded(
                child: Container(
                  color: Colors.grey[100],
                  padding: MySpacing.all(16),
                  child: AwarenessSeats(tabController),
                ),
              ),
              if (lecternPosition == LecternPosition.bottom)
                const SizedBox(height: 10, child: LecternWidget(title: '')),
              // tools bar
            ],
          ),
        ),
      ],
    );
  }
}

class AwarenessSeats extends ConsumerStatefulWidget {
  const AwarenessSeats(
    this.tabController,
    {super.key,}
  );

  final TabController tabController;

  @override
  ConsumerState<AwarenessSeats> createState() => _AwarenessSeatsState();
}

class _AwarenessSeatsState extends ConsumerState<AwarenessSeats> {
  @override
  void initState() {
    super.initState();

    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   final list = Boxes.getAwarenessMeiboBox().values.toList();
    //   if (list.isEmpty) {
    //     ToastHelper.showToast(context, '　該当データがありません　');
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(seatSettingAwarenessProvider);

    return state.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Text(error.toString()),
      data: (data) {
        return _build(context);
      },
    );
  }

  Widget _build(BuildContext context) {
    final lp = ref.watch(lecternPositionProvider);

    return ValueListenableBuilder(
      valueListenable: Boxes.getAwarenessMeiboBox().listenable(),
      builder: (context, Box<AwarenessMeiboModel> box, _) {
        final meibos = box.values.toList();
        final ms = Boxes.getAttendanceMeibo().values.toList();
        final newMeibos = <AwarenessMeiboModel>[];

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
        final setting = ref.watch(seatSettingPatternProvider);
        final seats = Boxes.getSeatChart().values.toList();
        if (seats.isNotEmpty && setting.id != null && setting.id != 0) {
          seats.sort((a, b) => a.seatIndex!.compareTo(b.seatIndex!));

          final m = setting.row!;
          final n = setting.column!;
          gridColumnCount = n;

          // 座席ごとにデータを設定する
          for (var i = 0; i < m * n; i++) {
            var meibo = const AwarenessMeiboModel(
              studentKihonId: 0,
            );

            try {
              final seatData = seats.firstWhere((e) => e.seatIndex == i);

              // 席無し情報の設定
              if (seatData.seatNumber == 0) {
                meibo = const AwarenessMeiboModel(
                  studentKihonId: -1,
                );
              }

              // 生徒情報の設定
              if (seatData.seatNumber != 0 && seatData.seitoSeq != '0') {
                final m =
                    ms.firstWhere((e) => e.studentSeq == seatData.seitoSeq);
                meibo = meibos.firstWhere(
                  (e) => e.studentId == m.studentKihonId,
                );
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
                child: AwarenessSeatWidget(
                  widget.tabController,
                  meibo: newMeibos[index],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
