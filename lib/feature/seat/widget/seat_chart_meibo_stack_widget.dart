import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kyoumutechou/feature/boxes.dart';
import 'package:kyoumutechou/feature/common/provider/common_provider.dart';
import 'package:kyoumutechou/feature/seat/provider/seat_chart_provider.dart';

class SeatChartMeiboStackWidget extends ConsumerStatefulWidget {
  const SeatChartMeiboStackWidget({super.key});

  @override
  ConsumerState<SeatChartMeiboStackWidget> createState() =>
      _SeatChartMeiboStackWidgetState();
}

class _SeatChartMeiboStackWidgetState
    extends ConsumerState<SeatChartMeiboStackWidget> {
  final seatSettingBox = Boxes.getSeatSetting();

  final rowPadding = 8.0;
  final columnPadding = 8.0;

  final meiboWidth = 150.0;
  final meiboHeight = 70.0;

  late int id;
  late int m; // 行数
  late int n; // 列数
  late int setMaxNumber;

  late int seatOrder;

  @override
  void initState() {
    super.initState();

    id = ref.read(seatSettingIdProvider);
    final setting = seatSettingBox.get(id)!;

    m = setting.row ?? 0;
    n = setting.column ?? 0;
    seatOrder = setting.seatOrder ?? 0;

    setMaxNumber = m * n;
  }

  @override
  Widget build(BuildContext context) {
    final lp = ref.watch(lecternPositionProvider);
    final scMeibos = ref.watch(scMeibosStackProvider);

    // インデックスによりソートする
    scMeibos.sort((a, b) => a.seatIndex.compareTo(b.seatIndex));

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final maxWidth = constraints.maxWidth;
        final maxHeight = constraints.maxHeight;

        // 行数により、最大の高さを決定。
        final height = (maxHeight - (m + 1) * rowPadding) / m;
        // 列数により、最大の幅を決定。
        final width = (maxWidth - (n + 1) * columnPadding) / n;

        final heightScale = height > meiboHeight ? 1.0 : height / meiboHeight;
        final widthScale = width > meiboWidth ? 1.0 : width / meiboWidth;
        var scale = heightScale < widthScale ? heightScale : widthScale;

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

        return Transform.rotate(
          angle: rotate == 0.0 ? 0.0 : 3.14159265358979323846,
          child: Stack(
            children: [
              for (var i = 0; i < m; i++) ...[
                for (var j = 0; j < n; j++) ...[
                  _buildCell(
                    i * (height + rowPadding) + rowPadding,
                    j * (width + columnPadding) + columnPadding,
                    scale,
                    Transform.rotate(
                      angle: rotate == 0.0 ? 0.0 : 3.14159265358979323846,
                      child: GestureDetector(
                        onTap: () {
                          ref.read(seatChartStackFocusProvider.notifier).state =
                              i * n + j;
                        },
                        onDoubleTap: () {
                          ref.read(seatChartStackFocusProvider.notifier).state =
                              i * n + j;
                        },
                        child: SizedBox(
                          width: width,
                          height: height,
                          child: Center(child: scMeibos[i * n + j]),
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            ],
          ),
        );
      },
    );
  }

  Widget _buildCell(
    double top,
    double left,
    double scale,
    Widget meibo,
  ) {
    return Positioned(
      top: top,
      left: left,
      child: Transform.scale(
        scale: scale,
        child: meibo,
      ),
    );
  }
}
