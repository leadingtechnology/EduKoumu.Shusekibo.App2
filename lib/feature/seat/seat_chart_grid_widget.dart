
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kyoumutechou/feature/boxes.dart';
import 'package:kyoumutechou/feature/common/provider/common_provider.dart';
import 'package:kyoumutechou/feature/common/widget/save2_button_widget.dart';
import 'package:kyoumutechou/feature/common/widget/toast_helper.dart';
import 'package:kyoumutechou/feature/linkage/widget/lectern_widget.dart';
import 'package:kyoumutechou/feature/seat/provider/seat_chart_provider.dart';
import 'package:kyoumutechou/feature/seat/widget/seat_bar_search_widget.dart';
import 'package:kyoumutechou/feature/seat/widget/seat_chart_meibo_list_widget.dart';
import 'package:kyoumutechou/feature/seat/widget/seat_chart_meibo_stack_widget.dart';
import 'package:kyoumutechou/helpers/widgets/my_spacing.dart';
import 'package:kyoumutechou/shared/http/app_exception.dart';

class SeatChartGridWidget extends ConsumerStatefulWidget  {
  const SeatChartGridWidget({
    required this.scaffoldKey,
    super.key,
  });

  // draw key
  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  ConsumerState<SeatChartGridWidget> createState() =>
      _SeatChartGridWidgetState();
}

class _SeatChartGridWidgetState extends ConsumerState<SeatChartGridWidget> {

  final meiboBox = Boxes.getAttendanceMeibo();
  
  @override
  void initState() {
    super.initState();

  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(seatChartListProvider);

    return state.when(
      loading: () {
        return const Center(child: CircularProgressIndicator());
      },
      error: (AppException e) {
        return Text(e.toString());
      },
      loaded: _buildGridItem,
    );
    
  }

  Widget _buildGridItem() {
    // 展開フラグ
    final isExp = ref.watch(isSeatExpandedProvider);
    // 教卓表示位置
    final lecternPosition = ref.watch(lecternPositionProvider);
    
    // 名簿リストの取得
    final len = meiboBox.length;

    return Column(
      children: [
        // 010.検索バー
        SeatSearchBarWidget(len: len),
        
        MySpacing.height(8),

        // 020.空席＋生徒一覧
        if (isExp)
        const SeatChartMeiboListWidget(),
        
        if (!isExp)
        Container(),

        // 030.座席設定 -- 教卓
        MySpacing.height(2),
        if (lecternPosition == LecternPosition.top) ...[
          MySpacing.height(8),
          const LecternWidget(),
          MySpacing.height(1),
        ],
        
        // 035.座席設定
        Expanded(
          child: Container(
            color: Colors.grey[100],
            padding: MySpacing.all(8),
            child: const SeatChartMeiboStackWidget(),
          ),
        ),

        // 040.座席設定 -- 教卓
        if (lecternPosition == LecternPosition.bottom) const LecternWidget(),
        
        // 090.アンダーバー
        MySpacing.height(16),
        Row(
          children: [
            // 前画面戻すボタン
            ElevatedButton.icon(
              onPressed: () {
                ref.read(seatChartPageTypeProvider.notifier).state =
                    PageType.list;
              },
              icon: const Icon(Icons.arrow_back),
              label: const Text('前画面へ戻る'),
              style: ElevatedButton.styleFrom(
                side: BorderSide(
                  color: Colors.green.shade200, // 枠線の色
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10), 
                ),
              ),
            ),
            // 全てクリアボタン
            MySpacing.width(28),
            ElevatedButton.icon(
              onPressed: () async{
                await ref.read(seatChartListProvider.notifier).clearAll();
              },
              icon: const Icon(Icons.clear_all_outlined),
              label: const Text('全てクリア'),
              style: ElevatedButton.styleFrom(
                side: BorderSide(
                  color: Colors.green.shade200, // 枠線の色
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10), 
                ),
              ),
            ),
            // 全て設定
            MySpacing.width(8),
            ElevatedButton.icon(
              onPressed: () async {
                await ref.read(seatChartListProvider.notifier).setAll();
              },
              icon: const Icon(Icons.manage_accounts_outlined),
              label: const Text('座席番号順に座席を配置'),
              style: ElevatedButton.styleFrom(
                side: BorderSide(
                  color: Colors.green.shade200, // 枠線の色
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10), 
                ),
              ),
            ),

            Expanded(child: Container()),
            ElevatedButton.icon(
              onPressed: () {
                ref.read(lecternPositionProvider.notifier).state = 
                    ref.read(lecternPositionProvider) == LecternPosition.top
                        ? LecternPosition.bottom
                        : LecternPosition.top;
              },
              icon: const Icon(Icons.swap_vert_outlined),
              label: const Text('表示回転'),
              style: ElevatedButton.styleFrom(
                side: BorderSide(
                  color: Colors.green.shade200, // 枠線の色
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            MySpacing.width(8),
            Save2ButtonWidget(
              label: '保存',
              onPressed: () async{
                await ref.read(seatChartListProvider.notifier).patch();

                // ignore: use_build_context_synchronously
                ToastHelper.showToast(context, '　保存しました　');
              },
            ),
          ],
        ),

      ],
    );
  }
}
