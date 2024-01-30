
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kyoumutechou/feature/attendance/provider/attendance_meibo_provider.dart';
import 'package:kyoumutechou/feature/boxes.dart';
import 'package:kyoumutechou/feature/common/provider/common_provider.dart';
import 'package:kyoumutechou/feature/common/state/api_state.dart';
import 'package:kyoumutechou/feature/common/widget/save2_button_widget.dart';
import 'package:kyoumutechou/feature/common/widget/search_bar_widget.dart';
import 'package:kyoumutechou/feature/common/widget/toast_helper.dart';
import 'package:kyoumutechou/feature/seat/provider/seat_chart_provider.dart';
import 'package:kyoumutechou/feature/seat/widget/seat_chart_meibo_list_widget.dart';
import 'package:kyoumutechou/feature/seat/widget/seat_chart_meibo_stack_widget.dart';
import 'package:kyoumutechou/helpers/widgets/my_spacing.dart';
import 'package:kyoumutechou/helpers/widgets/my_text.dart';

class SeatChartGridWidget extends ConsumerStatefulWidget  {
  const SeatChartGridWidget({
    required this.scaffoldKey,
    super.key,
  });

  // draw key
  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  ConsumerState<SeatChartGridWidget> createState() => _SeatChartGridWidgetState();
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
    final state = ref.watch(attendanceMeiboListProvider);
    final state2 = ref.watch(seatChartListProvider);

    return state.maybeWhen(
      loaded: () => state2.maybeWhen(
        loaded: _buildGridItem,
        orElse: () => _loadingOrErrorWidget(state2), // state2がloaded以外の場合
      ),
      orElse: () => _loadingOrErrorWidget(state), // stateがloaded以外の場合
    );
  }

  Widget _loadingOrErrorWidget(ApiState state) {
    return state.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error) => Text(error.toString()),
      loaded: Container.new, // この場合は使用されない
    );
  }

  Widget _buildGridItem() {
    final isExp = ref.watch(isSeatExpandedProvider);
    
    // 名簿リストの取得
    final len = meiboBox.length;

    return Column(
      children: [
        // 010.検索バー
        SearchBarWidget(widget.scaffoldKey),
        MySpacing.height(8),
        SizedBox(
          height: 40,
          //decoration: BoxDecoration(border: Border.all()),
          child: Row(
            children: [
              Expanded(child: Container()),
              Row(
                children: [
                  MyText('未設定人数:', fontSize: 16),
                  MySpacing.width(8),
                  MyText(' 0 / $len ', fontSize: 16),
                  IconButton(
                    icon: isExp
                        ? const Icon(Icons.expand_more)
                        : const Icon(Icons.expand_less),
                    onPressed: () {
                      ref.read(isSeatExpandedProvider.notifier).state = !isExp;
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
        MySpacing.height(8),

        // 020.空席＋生徒一覧
        if (isExp)
        const SeatChartMeiboListWidget(),
        
        if (!isExp)
        Container(),

        // 030.座席設定
        MySpacing.height(2),
        Expanded(
          child: Container(
            color: Colors.grey[100],
            padding: MySpacing.all(8),
            child: const SeatChartMeiboStackWidget(),
          ),
        ),
        
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
                  borderRadius: BorderRadius.circular(10), // 调整这个值来改变弧度
                ),
              ),
            ),
            // 全てクリアボタン
            MySpacing.width(28),
            ElevatedButton.icon(
              onPressed: () {
              },
              icon: const Icon(Icons.clear_all_outlined),
              label: const Text('全てクリア'),
              style: ElevatedButton.styleFrom(
                side: BorderSide(
                  color: Colors.green.shade200, // 枠線の色
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10), // 调整这个值来改变弧度
                ),
              ),
            ),
            // 全てクリアボタン
            MySpacing.width(8),
            ElevatedButton.icon(
              onPressed: () {
              },
              icon: const Icon(Icons.manage_accounts_outlined),
              label: const Text('座席表を割り当て'),
              style: ElevatedButton.styleFrom(
                side: BorderSide(
                  color: Colors.green.shade200, // 枠線の色
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10), // 调整这个值来改变弧度
                ),
              ),
            ),

            Expanded(child: Container()),
            Save2ButtonWidget(
              label: '保存',
              onPressed: () {
                      ToastHelper.showToast(context, '　保存しました　');
                    },
            ),
          ],
        ),

      ],
    );
  }
}
