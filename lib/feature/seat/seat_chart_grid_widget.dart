import 'package:flutter/material.dart';
import 'package:kyoumutechou/feature/common/widget/search_bar_widget.dart';
import 'package:kyoumutechou/helpers/widgets/my_spacing.dart';
import 'package:pluto_grid/pluto_grid.dart';

class SeatChartGridWidget extends StatefulWidget {
  const SeatChartGridWidget({
    required this.scaffoldKey,
    super.key,
  });

  // draw key
  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  State<SeatChartGridWidget> createState() => _SeatChartGridWidgetState();
}

class _SeatChartGridWidgetState extends State<SeatChartGridWidget> {
  final List<PlutoColumn> columns = <PlutoColumn>[
    // 1
    PlutoColumn(
      title: 'No.',
      field: 'id',
      type: PlutoColumnType.text(),
      textAlign: PlutoColumnTextAlign.right,
      titleTextAlign: PlutoColumnTextAlign.center,
    ),
    // 2
    PlutoColumn(
      title: 'パターン名',
      field: 'parrtenName',
      type: PlutoColumnType.text(),
      textAlign: PlutoColumnTextAlign.left,
      titleTextAlign: PlutoColumnTextAlign.center,
    ),
    // 3
    PlutoColumn(
      title: '行',
      field: 'row',
      type: PlutoColumnType.text(),
      textAlign: PlutoColumnTextAlign.center,
      titleTextAlign: PlutoColumnTextAlign.center,
    ),
    // 4
    PlutoColumn(
      title: '列',
      field: 'num',
      type: PlutoColumnType.text(),
      textAlign: PlutoColumnTextAlign.center,
      titleTextAlign: PlutoColumnTextAlign.center,
    ),
    // 5
    PlutoColumn(
      title: '座席配置順',
      field: 'sortNo',
      type: PlutoColumnType.text(),
      textAlign: PlutoColumnTextAlign.left,
      titleTextAlign: PlutoColumnTextAlign.center,
    ),
    // 6
    PlutoColumn(
      title: '設定開始日',
      field: 'sortNo',
      type: PlutoColumnType.text(),
      textAlign: PlutoColumnTextAlign.left,
      titleTextAlign: PlutoColumnTextAlign.center,
    ),
    // 7
    PlutoColumn(
      title: '設定終了日',
      field: 'sortNo',
      type: PlutoColumnType.text(),
      textAlign: PlutoColumnTextAlign.left,
      titleTextAlign: PlutoColumnTextAlign.center,
    ),
    // 8
    PlutoColumn(
      title: '　',
      field: 'sortNo',
      type: PlutoColumnType.text(),
      textAlign: PlutoColumnTextAlign.center,
      titleTextAlign: PlutoColumnTextAlign.center,
    ),
  ];

  late final List<PlutoRow> rows = [];
  late final PlutoGridStateManager stateManager;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SearchBarWidget(widget.scaffoldKey),
        MySpacing.height(8),
        const Center(
          child: Text('座席表Grid'),
        ),
        PlutoGrid(
          columns: columns,
          rows: rows,
          onLoaded: (PlutoGridOnLoadedEvent event) {
            stateManager = event.stateManager;
            stateManager.setShowColumnFilter(true);
          },
          onChanged: (PlutoGridOnChangedEvent event) {
            print(event);
          },
          configuration: const PlutoGridConfiguration(),
        ),
      ],
    );
  }
}
