import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kyoumutechou/feature/boxes.dart';
import 'package:kyoumutechou/feature/common/widget/dialog_util.dart';
import 'package:kyoumutechou/feature/common/widget/search_bar_widget.dart';
import 'package:kyoumutechou/feature/seat/model/seat_setting_model.dart';
import 'package:kyoumutechou/feature/seat/provider/seat_setting_provider.dart';
import 'package:kyoumutechou/feature/seat/widget/seat_chart_edit_button_widget.dart';
import 'package:kyoumutechou/feature/seat/widget/seat_configration.dart';
import 'package:kyoumutechou/feature/seat/widget/seat_setting_dialog.dart';
import 'package:kyoumutechou/helpers/widgets/my_spacing.dart';
import 'package:kyoumutechou/shared/util/date_util.dart';
import 'package:pluto_grid/pluto_grid.dart';

// ignore: must_be_immutable
class SeatChartListWidget extends ConsumerWidget {
  SeatChartListWidget({
    required this.scaffoldKey,
    super.key,
  });

  // draw key
  final GlobalKey<ScaffoldState> scaffoldKey;
  late List<PlutoColumn> columns = [];
  late List<PlutoRow> rows = [];

  void setColumns(BuildContext context, WidgetRef ref) {
    columns = <PlutoColumn>[
      // 0
      PlutoColumn(
        title: '',
        field: 'Id',
        width: 50,
        readOnly: true,
        type: PlutoColumnType.text(),
        hide: true,
      ),
      // 1
      PlutoColumn(
        title: 'No.',
        field: 'SeatPattern',
        width: 50,
        readOnly: true,
        enableContextMenu: false,
        type: PlutoColumnType.text(),
        textAlign: PlutoColumnTextAlign.right,
        titleTextAlign: PlutoColumnTextAlign.center,
        enableColumnDrag: false,
        enableDropToResize: false,
        enableSorting: false,
        renderer: (rendererContext) {
          // 行番号を表示する
          final rowIdx = rendererContext.rowIdx + 1;
          return Text('$rowIdx');
        },
      ),
      // 2
      PlutoColumn(
        title: 'パターン名',
        field: 'SeatPatternName',
        width: 290,
        readOnly: true,
        enableContextMenu: false,
        type: PlutoColumnType.text(),
        textAlign: PlutoColumnTextAlign.left,
        titleTextAlign: PlutoColumnTextAlign.center,
        enableColumnDrag: false,
        enableDropToResize: false,
        enableSorting: false,
        renderer: (rendererContext) {
          final id = rendererContext.row.cells['Id']!.value as int;

          final seatPatternName =
              rendererContext.row.cells['SeatPatternName']!.value;

          return GestureDetector(
            onTap: () async {
              await _handlePressActionButton(context, id);
            },
            child: Text(
              '$seatPatternName',
              style: const TextStyle(
                decoration: TextDecoration.underline,
              ),
            ),
          );
        },
      ),
      // 3
      PlutoColumn(
        title: '行',
        field: 'Row',
        width: 45,
        readOnly: true,
        enableContextMenu: false,
        type: PlutoColumnType.text(),
        textAlign: PlutoColumnTextAlign.center,
        titleTextAlign: PlutoColumnTextAlign.center,
        enableColumnDrag: false,
        enableDropToResize: false,
        enableSorting: false,
      ),
      // 4
      PlutoColumn(
        title: '列',
        field: 'Column',
        width: 45,
        readOnly: true,
        enableContextMenu: false,
        type: PlutoColumnType.text(),
        textAlign: PlutoColumnTextAlign.center,
        titleTextAlign: PlutoColumnTextAlign.center,
        enableColumnDrag: false,
        enableDropToResize: false,
        enableSorting: false,
      ),
      // 5
      PlutoColumn(
        title: '座席配置順',
        field: 'SeatOrder',
        width: 180,
        readOnly: true,
        enableContextMenu: false,
        type: PlutoColumnType.text(),
        textAlign: PlutoColumnTextAlign.left,
        titleTextAlign: PlutoColumnTextAlign.center,
        enableColumnDrag: false,
        enableDropToResize: false,
        enableSorting: false,
        renderer: (rendererContext) {
          final seatOrder =
              rendererContext.row.cells['SeatOrder']!.value as int;
          return Text(seatConfigurations[seatOrder - 1].name);
        },
      ),
      // 6
      PlutoColumn(
        title: '設定開始日',
        field: 'StartDate',
        width: 100,
        readOnly: true,
        enableContextMenu: false,
        type: PlutoColumnType.text(),
        textAlign: PlutoColumnTextAlign.left,
        titleTextAlign: PlutoColumnTextAlign.center,
        enableColumnDrag: false,
        enableDropToResize: false,
        enableSorting: false,
      ),
      // 7
      PlutoColumn(
        title: '設定終了日',
        field: 'EndDate',
        width: 100,
        readOnly: true,
        enableContextMenu: false,
        type: PlutoColumnType.text(),
        textAlign: PlutoColumnTextAlign.left,
        titleTextAlign: PlutoColumnTextAlign.center,
        enableColumnDrag: false,
        enableDropToResize: false,
        enableSorting: false,
      ),
      // 8
      PlutoColumn(
        title: '　',
        field: 'actions',
        width: 180,
        readOnly: true,
        enableContextMenu: false,
        type: PlutoColumnType.text(),
        textAlign: PlutoColumnTextAlign.center,
        titleTextAlign: PlutoColumnTextAlign.center,
        enableColumnDrag: false,
        enableDropToResize: false,
        enableSorting: false,
        renderer: (rendererContext) {
          var id = 0;
          try {
            id = rendererContext.row.cells['Id']!.value as int;
          } catch (e) {
            id = 0;
          }

          final strDate = rendererContext.row.cells['sDate']!.value as String;

          var targetDate = DateTime.now();
          try {
            targetDate = DateTime.parse(strDate);
          } catch (e) {
            targetDate = DateTime.now();
          }

          return SeatChartEditButtonWidget(
            id: id,
            targetDate: targetDate,
          );
        },
      ),
      // 9 hide column
      PlutoColumn(
        title: '',
        field: 'sDate',
        hide: true,
        type: PlutoColumnType.date(),
      ),
      PlutoColumn(
        title: '',
        field: 'eDate',
        hide: true,
        type: PlutoColumnType.date(),
      ),
    ];
  }

  late final PlutoGridStateManager stateManager;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(seatSettingListProvider);

    return state.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error) => Center(child: Text(error.toString())),
      loaded: () {
        return ValueListenableBuilder(
          valueListenable: Boxes.getSeatSetting().listenable(),
          builder: (context, Box<SeatSettingModel> box, _) {
            final settings = box.values.toList().cast<SeatSettingModel>();

            // ignore: cascade_invocations
            settings.sort(
              (a, b) => '${a.crtDateTime}'.compareTo('${a.crtDateTime}'),
            );

            setColumns(context, ref);
            rows = settings.map((e) {
              return PlutoRow(
                cells: {
                  'Id': PlutoCell(value: e.id),
                  'SeatPattern': PlutoCell(value: e.seatPattern),
                  'SeatPatternName': PlutoCell(value: e.seatPatternName),
                  'Row': PlutoCell(value: e.row),
                  'Column': PlutoCell(value: e.column),
                  'SeatOrder': PlutoCell(value: e.seatOrder),
                  'StartDate': PlutoCell(
                    value: e.startDate == null
                        ? ''
                        : DateUtil.getJapaneseDate(
                            e.startDate ?? DateTime.now(),
                          ),
                  ),
                  'EndDate': PlutoCell(
                    value: e.endDate == null
                        ? ''
                        : DateUtil.getJapaneseDate(
                            e.endDate ?? DateTime.now(),
                          ),
                  ),
                  'actions': PlutoCell(value: 'actions'),
                  // 以下は非表示カラム
                  'sDate': PlutoCell(value: e.startDate),
                  'eDate': PlutoCell(value: e.endDate),
                },
              );
            }).toList();

            //
            return showList(context);
          },
        );
      },
    );
  }

  Widget showList(BuildContext context) {
    return Column(
      children: [
        SearchBarWidget(scaffoldKey),
        MySpacing.height(8),
        Row(
          children: [
            const Text(
              '座席表の設定',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            Expanded(child: Container()),
            TextButton.icon(
              onPressed: () async {
                await _handlePressActionButton(context, 0);
              },
              icon: const Icon(Icons.add),
              label: const Text('新規追加'),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                side: const BorderSide(
                  color: Colors.black54,
                ),
              ),
            ),
          ],
        ),
        MySpacing.height(8),
        SizedBox(
          height: 550,
          child: PlutoGrid(
            columns: columns,
            rows: rows,
            onLoaded: (PlutoGridOnLoadedEvent event) {
              stateManager = event.stateManager;
              stateManager.setSelectingMode(PlutoGridSelectingMode.cell);
            },
            onChanged: print,
            //configuration: const PlutoGridConfiguration(),
            //onSorted: null,
            mode: PlutoGridMode.selectWithOneTap,
            configuration: const PlutoGridConfiguration(
              scrollbar: PlutoGridScrollbarConfig(
                isAlwaysShown: true,
                onlyDraggingThumb: false,
                dragDevices: {
                  // PointerDeviceKind.mouse,
                  PointerDeviceKind.touch,
                  PointerDeviceKind.trackpad,
                  PointerDeviceKind.unknown,
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _handlePressActionButton(BuildContext context, int id) async {
    await DialogUtil.show(
      context: context,
      builder: (BuildContext context) {
        return SeatSettingDialog(
          id: id,
        );
      },
    );
  }
}
