import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kyoumutechou/feature/common/provider/common_provider.dart';
import 'package:kyoumutechou/feature/common/widget/search_bar_widget.dart';
import 'package:kyoumutechou/feature/seat/provider/seat_chart_provider.dart';
import 'package:kyoumutechou/feature/seat/widget/image_text_widget.dart';
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

  @override
  Widget build(BuildContext context) {
    final isExp = ref.watch(isSeatExpandedProvider);

    return Column(
      children: [
        // 検索バー
        SearchBarWidget(widget.scaffoldKey),
        MySpacing.height(8),
        Row(
          children: [
            ElevatedButton.icon(
              onPressed: () {
                ref.read(seatChartPageTypeProvider.notifier).state =
                    PageType.list;
              },
              icon: const Icon(Icons.arrow_back),
              label: const Text('前画面へ戻る'),
            ),
            MySpacing.width(8),
            Expanded(child: Container()),
            Row(
              children: [
                MyText('未設定人数:', fontSize: 16),
                MySpacing.width(8),
                MyText(' 0 / 36 ', fontSize: 16),
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
        MySpacing.height(8),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey, // 枠線の色を設定
            ),
          ),
          child: Column(
            children: [
              if(isExp) ...[
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(100, (index) {
                      return const Padding(
                        padding: EdgeInsets.all(8),
                        child: ImageTextWidget(
                          imagePath: 'assets/icons/seito.png',
                          buttonText: '未設定',
                          onPressed: null,
                        ),
                      );
                    }),
                  ),
                ),
                MySpacing.height(8),
              ],

              // グリッド
            ],),  
        ),
      ],
    );
  }

 
}
