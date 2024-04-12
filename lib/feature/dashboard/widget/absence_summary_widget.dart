import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kyoumutechou/feature/dashboard/model/home_absence_model.dart';
import 'package:kyoumutechou/feature/dashboard/provider/home_absence_provider.dart';
import 'package:kyoumutechou/shared/http/app_exception.dart';
import 'package:kyoumutechou/shared/util/date_util.dart';
import 'package:pluto_grid/pluto_grid.dart';

class AbsenceSummaryWidget extends ConsumerStatefulWidget {
  const AbsenceSummaryWidget({super.key});

  @override
  ConsumerState<AbsenceSummaryWidget> 
  createState() => _AbsenceSummaryWidgetState();
}

class _AbsenceSummaryWidgetState extends ConsumerState<AbsenceSummaryWidget> {
  late final PlutoGridStateManager stateManager;

  final _baseUrl = dotenv.env['BASE_URL']!;
  String accessToken = Hive.box<String>('shusekibo').get('token').toString();

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
    final state = ref.watch(homeAbsenceNotifierProvider);
    return state.when(
      loading: () {
        return const Center(child: CircularProgressIndicator());
      },
      error: (AppException e) {
        return Text(e.toString());
      },
      loaded: (list) {
        return _build(context, list);
      },
    );
  }

  Widget _build(BuildContext context, List<HomeAbsenceModel> list) {

    return PlutoGrid(
      columns: getColumns(),
      rows: getRows(list),
      onLoaded: (PlutoGridOnLoadedEvent event) {
        stateManager = event.stateManager;
        stateManager.setSelectingMode(PlutoGridSelectingMode.cell);
      },
      onSelected: (PlutoGridOnSelectedEvent event) async {
      },
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
    );
  }

  List<PlutoRow> getRows(List<HomeAbsenceModel> list) {
    final rows = <PlutoRow>[];
    for (var i = 0; i < list.length; i++) {
      final model = list[i];
      final row = PlutoRow(cells: {
        'gakunen': PlutoCell(value: model.gakunen),
        'className': PlutoCell(value: model.className),
        'shusekiNo': PlutoCell(value: model.studentNumber),
        'photoPath': PlutoCell(value: model.photoUrl),
        'fullName': PlutoCell(value: model.name),
        'sex': PlutoCell(value: model.genderCode == '1' ? '男' : '女'),
        'mark': PlutoCell(value: model.ryaku ?? ''),
        'reason1': PlutoCell(value: model.jiyu1 ?? ''),
        'reason2': PlutoCell(value: model.jiyu2 ?? ''),
      },);
      rows.add(row);
    }
    return rows;
  }

    // カラムの設定
  List<PlutoColumn> getColumns() {
    return [
      PlutoColumn(
        title: '学年',
        field: 'gakunen',
        readOnly: true,
        enableSorting: false,
        type: PlutoColumnType.text(),
        width: 60,
        enableDropToResize: false,
        enableContextMenu: false,
        textAlign: PlutoColumnTextAlign.right,
        titleTextAlign: PlutoColumnTextAlign.center,
      ),
      PlutoColumn(
        title: 'クラス',
        field: 'className',
        readOnly: true,
        enableSorting: false,
        type: PlutoColumnType.text(),
        width: 80,
        enableDropToResize: false,
        enableContextMenu: false,
        textAlign: PlutoColumnTextAlign.right,
        titleTextAlign: PlutoColumnTextAlign.center,
      ),
      PlutoColumn(
        title: '出席番号',
        field: 'shusekiNo',
        readOnly: true,
        enableSorting: false,
        type: PlutoColumnType.text(),
        width: 80,
        enableDropToResize: false,
        enableContextMenu: false,
        textAlign: PlutoColumnTextAlign.right,
        titleTextAlign: PlutoColumnTextAlign.center,
      ),
      PlutoColumn(
        title: '写真',
        field: 'photoPath',
        readOnly: true,
        enableSorting: false,
        type: PlutoColumnType.text(),
        width: 60,
        enableDropToResize: false,
        enableContextMenu: false,
        textAlign: PlutoColumnTextAlign.center,
        titleTextAlign: PlutoColumnTextAlign.center,
        renderer: (rendererContext) {
          final photoUrl =
              rendererContext.row.cells['photoPath']!.value.toString().trim();

          final url = '$_baseUrl$photoUrl';

          return ClipOval(
            child: Image.network(
              url,
              headers: {'Authorization': 'Bearer $accessToken'},
            ),
          );
        },
      ),
      PlutoColumn(
        title: '氏名',
        field: 'fullName',
        readOnly: true,
        enableSorting: false,
        type: PlutoColumnType.text(),
        width: 160,
        enableDropToResize: false,
        enableContextMenu: false,
        textAlign: PlutoColumnTextAlign.left,
        titleTextAlign: PlutoColumnTextAlign.center,
      ),
      PlutoColumn(
        title: '性別',
        field: 'sex',
        readOnly: true,
        type: PlutoColumnType.text(),
        width: 55,
        enableDropToResize: false,
        enableContextMenu: false,
        textAlign: PlutoColumnTextAlign.center,
        titleTextAlign: PlutoColumnTextAlign.center,
      ),

      // mark
      PlutoColumn(
        title: DateUtil.getWeekDate(DateTime.now()),
        field: 'mark',
        readOnly: true,
        enableSorting: false,
        type: PlutoColumnType.text(),
        width: 110,
        cellPadding: const EdgeInsets.fromLTRB(0, 0, 1, 0),
        enableDropToResize: false,
        enableContextMenu: false,
        textAlign: PlutoColumnTextAlign.left,
        titleTextAlign: PlutoColumnTextAlign.center,
        renderer: (rendererContext) {
          return Center(
                  child: Text('${rendererContext.cell.value}',),
                );
        },
      ),

      // 理由1
      PlutoColumn(
        title: '事由1',
        field: 'reason1',
        readOnly: true,
        enableSorting: false,
        type: PlutoColumnType.text(),
        width: 110,
        cellPadding: const EdgeInsets.fromLTRB(0, 0, 1, 0),
        enableDropToResize: false,
        enableContextMenu: false,
        textAlign: PlutoColumnTextAlign.left,
        titleTextAlign: PlutoColumnTextAlign.center,
        renderer: (rendererContext) {
          return Text('${rendererContext.cell.value}',);
        },
      ),

      // 理由2
      PlutoColumn(
        title: '事由2',
        field: 'reason2',
        readOnly: true,
        enableSorting: false,
        type: PlutoColumnType.text(),
        width: 110,
        cellPadding: const EdgeInsets.fromLTRB(0, 0, 1, 0),
        enableDropToResize: false,
        enableContextMenu: false,
        textAlign: PlutoColumnTextAlign.left,
        titleTextAlign: PlutoColumnTextAlign.center,
        renderer: (rendererContext) {
          return Text('${rendererContext.cell.value}',);
        },
      ),

    ];
  }


}
