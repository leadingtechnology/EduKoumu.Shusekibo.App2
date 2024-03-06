import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kyoumutechou/feature/boxes.dart';
import 'package:kyoumutechou/feature/common/provider/filter_provider.dart';
import 'package:kyoumutechou/feature/common/provider/tokobis_provider.dart';
import 'package:kyoumutechou/feature/health/model/health_meibo_model.dart';
import 'package:kyoumutechou/feature/health/model/health_status_model.dart';
import 'package:kyoumutechou/feature/health/provider/health_meibo_provider.dart';
import 'package:kyoumutechou/feature/health/provider/health_reason_provider.dart';
import 'package:kyoumutechou/feature/health/provider/health_stamp_provider.dart';
import 'package:kyoumutechou/shared/http/app_exception.dart';
import 'package:kyoumutechou/shared/util/date_util.dart';
import 'package:pluto_grid/pluto_grid.dart';

// ignore: library_private_types_in_public_api
GlobalKey<_HealthListWidgetState> helthGlobalKey = GlobalKey();

class HealthListWidget extends ConsumerStatefulWidget {
  const HealthListWidget({super.key});

  @override
  ConsumerState<HealthListWidget> createState() => _HealthListWidgetState();
}

// 健康widget
class _HealthListWidgetState extends ConsumerState<HealthListWidget> {
  late final PlutoGridStateManager stateManager;

  final _baseUrl = dotenv.env['BASE_URL']!;
  String accessToken = Hive.box<String>('shusekibo').get('token').toString();

  // 行の設定
  List<PlutoRow> getRows() {
    final meibos0 = Boxes.getHealthMeiboBox().values.toList();
    final meibos1 = Boxes.getHealthMeiboBox1().values.toList();
    final meibos2 = Boxes.getHealthMeiboBox2().values.toList();

    final rows = <PlutoRow>[];
    for (final e0 in meibos0) {
      HealthMeiboModel e1;
      try{
        e1 = meibos1
          .where((e) => e.studentKihonId == e0.studentKihonId)
          .toList()
          .first;
      }catch(e){
        e1 = const HealthMeiboModel();
      }

      HealthMeiboModel e2;
      try {
        e2 = meibos2
            .where((e) => e.studentKihonId == e0.studentKihonId)
            .toList()
            .first;
      } catch (e) {
        e2 = const HealthMeiboModel();
      }
  
      rows.add(setPlutRow(e0, e1, e2));
    }
    return rows;
  }

  PlutoRow setPlutRow(
    HealthMeiboModel e0, 
    HealthMeiboModel? e1, 
    HealthMeiboModel? e2,
  ) {
    final tokobis = getFilteredTokobiDates(
      ref.read(filterProvider).targetDate ?? DateTime.now(),
      ref.read(filterProvider).classId ?? 0,
    );    

    final isTokobi = ref.read(isTokobiProvider);

    HealthStatusModel jokyo0;
    if (e0.jokyoList != null && e0.jokyoList!.isNotEmpty) {
      try {
        jokyo0 = e0.jokyoList!.first;
      } catch (ex) {
        jokyo0 = const HealthStatusModel();
      }
    } else {
      jokyo0 = const HealthStatusModel();
    }

    HealthStatusModel jokyo1;
    if (e1 != null && e1.jokyoList != null && e1.jokyoList!.isNotEmpty) {
      try {
        jokyo1 = e1.jokyoList!.first;
      } catch (ex) {
        jokyo1 = const HealthStatusModel();
      }
    } else {
      jokyo1 = const HealthStatusModel();
    }

    HealthStatusModel jokyo2;
    if (e2 != null && e2.jokyoList != null && e2.jokyoList!.isNotEmpty) {
      try {
        jokyo2 = e2.jokyoList!.first;
      } catch (ex) {
        jokyo2 = const HealthStatusModel();
      }
    } else {
      jokyo2 = const HealthStatusModel();
    }

    PlutoRow row;

    switch (tokobis.length-1) {
      case 1: 
        row = PlutoRow(
          cells: {
            'shusekiNo': PlutoCell(value: e0.studentNumber ?? ''),
            'photoPath': PlutoCell(value: e0.photoUrl),
            'fullName': PlutoCell(value: e0.name),
            'sex': PlutoCell(value: e0.genderCode == '1' ? '男' : '女'),
            'mark': PlutoCell(value: jokyo0.ryaku ?? ''),
            'reason1': PlutoCell(value: jokyo0.jiyu1 ?? ''),
            'reason2': PlutoCell(value: jokyo0.jiyu2 ?? ''),
            'mark1' : PlutoCell(value: jokyo1.ryaku ?? ''),
            'reason11': PlutoCell(value: jokyo1.jiyu1 ?? ''),
            'reason12': PlutoCell(value: jokyo1.jiyu2 ?? ''),
            'isEditable': PlutoCell(
                value: jokyo0.isEditable == true && isTokobi == true ? 1 : 0),
            'tenshutsuYoteiFlg':
                PlutoCell(value: e0.tenshutsuYoteiFlg == true ? 1 : 0),
            'tenshutsuSumiFlg':
                PlutoCell(value: e0.tenshutsuSumiFlg == true ? 1 : 0),
            'gakunen': PlutoCell(value: e0.gakunen),
            'studentKihonId': PlutoCell(value: e0.studentKihonId),
          },
        );
        break;
      case 2:
        row = PlutoRow(
          cells: {
            'shusekiNo': PlutoCell(value: e0.studentNumber ?? ''),
            'photoPath': PlutoCell(value: e0.photoUrl),
            'fullName': PlutoCell(value: e0.name),
            'sex': PlutoCell(value: e0.genderCode == '1' ? '男' : '女'),
            'mark': PlutoCell(value: jokyo0.ryaku ?? ''),
            'reason1': PlutoCell(value: jokyo0.jiyu1 ?? ''),
            'reason2': PlutoCell(value: jokyo0.jiyu2 ?? ''),
            'mark1': PlutoCell(value: jokyo1.ryaku ?? ''),
            'reason11': PlutoCell(value: jokyo1.jiyu1 ?? ''),
            'reason12': PlutoCell(value: jokyo1.jiyu2 ?? ''),
            'mark2': PlutoCell(value: jokyo2.ryaku ?? ''),
            'reason21': PlutoCell(value: jokyo2.jiyu1 ?? ''),
            'reason22': PlutoCell(value: jokyo2.jiyu2 ?? ''),
            'isEditable': PlutoCell(
                value: jokyo0.isEditable == true && isTokobi == true ? 1 : 0),
            'tenshutsuYoteiFlg':
                PlutoCell(value: e0.tenshutsuYoteiFlg == true ? 1 : 0),
            'tenshutsuSumiFlg':
                PlutoCell(value: e0.tenshutsuSumiFlg == true ? 1 : 0),
            'gakunen': PlutoCell(value: e0.gakunen),
            'studentKihonId': PlutoCell(value: e0.studentKihonId),
          },
        );
        break;
      default:
        row = PlutoRow(
          cells: {
            'shusekiNo': PlutoCell(value: e0.studentNumber ?? ''),
            'photoPath': PlutoCell(value: e0.photoUrl),
            'fullName': PlutoCell(value: e0.name),
            'sex': PlutoCell(value: e0.genderCode == '1' ? '男' : '女'),
            'mark': PlutoCell(value: jokyo0.ryaku ?? ''),
            'reason1': PlutoCell(value: jokyo0.jiyu1 ?? ''),
            'reason2': PlutoCell(value: jokyo0.jiyu2 ?? ''),
            'isEditable': PlutoCell(
                value: jokyo0.isEditable == true && isTokobi == true ? 1 : 0),
            'tenshutsuYoteiFlg':
                PlutoCell(value: e0.tenshutsuYoteiFlg == true ? 1 : 0),
            'tenshutsuSumiFlg':
                PlutoCell(value: e0.tenshutsuSumiFlg == true ? 1 : 0),
            'gakunen': PlutoCell(value: e0.gakunen),
            'studentKihonId': PlutoCell(value: e0.studentKihonId),
          },
        );
        break;
    } 

    // return PlutoRow(
    //   cells: {
    //     //'classNo': PlutoCell(value: e.className),
    //     'shusekiNo': PlutoCell(value: e0.studentNumber ?? ''),
    //     'photoPath': PlutoCell(value: e0.photoUrl),
    //     'fullName': PlutoCell(value: e0.name),
    //     'sex': PlutoCell(value: e0.genderCode == '1' ? '男' : '女'),
    //     'mark': PlutoCell(value: jokyo0.ryaku ?? ''),
    //     'reason1': PlutoCell(value: jokyo0.jiyu1 ?? ''),
    //     'reason2': PlutoCell(value: jokyo0.jiyu2 ?? ''),
    //     'isEditable': PlutoCell(
    //         value: jokyo0.isEditable == true && isTokobi == true ? 1 : 0),
    //     'tenshutsuYoteiFlg':
    //         PlutoCell(value: e0.tenshutsuYoteiFlg == true ? 1 : 0),
    //     'tenshutsuSumiFlg':
    //         PlutoCell(value: e0.tenshutsuSumiFlg == true ? 1 : 0),
    //     'gakunen': PlutoCell(value: e0.gakunen),
    //   },
    // );

    return row;
  }

  // カラムの設定
  List<PlutoColumn> getColumns() {
    final tokobis = getFilteredTokobiDates(
      ref.read(filterProvider).targetDate ?? DateTime.now(),
      ref.read(filterProvider).classId ?? 0,
    );

    return [
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
        frozen: PlutoColumnFrozen.start,
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
        frozen: PlutoColumnFrozen.start,
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
        frozen: PlutoColumnFrozen.start,
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
        frozen: PlutoColumnFrozen.start,
      ),

      // mark
      PlutoColumn(
        title: DateUtil.getWeekDate(tokobis[0]),
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
          final isEditable =
              rendererContext.row.cells['isEditable']!.value == 1;

          return isEditable
              ? Center(
                  child: Text(
                  '${rendererContext.cell.value}',
                ),)
              : Container(
                  padding: EdgeInsets.zero,
                  color: Colors.grey.withAlpha(50),
                  child: Center(
                    child: Text(
                      '${rendererContext.cell.value}',
                    ),
                  ),
                );
        },
      ),

      // 理由1
      PlutoColumn(
        title: '理由1',
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
          final isEditable =
              rendererContext.row.cells['isEditable']!.value == 1;

          return isEditable
              ? Text(
                  '${rendererContext.cell.value}',
                )
              : Container(
                  padding: EdgeInsets.zero,
                  color: Colors.grey.withAlpha(50),
                  child: Center(
                    child: Text(
                      '${rendererContext.cell.value}',
                    ),
                  ),
                );
        },
      ),

      // 理由2
      PlutoColumn(
        title: '理由2',
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
          final isEditable =
              rendererContext.row.cells['isEditable']!.value == 1;

          return isEditable
              ? Text(
                  '${rendererContext.cell.value}',
                )
              : Container(
                  padding: EdgeInsets.zero,
                  color: Colors.grey.withAlpha(50),
                  child: Center(
                    child: Text(
                      '${rendererContext.cell.value}',
                    ),
                  ),
                );
        },
      ),
      if (tokobis.length > 1) ...[
        // mark
        PlutoColumn(
          title: DateUtil.getWeekDate(tokobis[1]),
          field: 'mark1',
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

            return Container(
                    padding: EdgeInsets.zero,
                    color: Colors.grey.withAlpha(50),
                    child: Center(
                      child: Text(
                        '${rendererContext.cell.value}',
                      ),
                    ),
                  );
          },
        ),

        // 理由1
        PlutoColumn(
          title: '理由1',
          field: 'reason11',
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

            return Container(
                    padding: EdgeInsets.zero,
                    color: Colors.grey.withAlpha(50),
                    child: Center(
                      child: Text(
                        '${rendererContext.cell.value}',
                      ),
                    ),
                  );
          },
        ),

        // 理由2
        PlutoColumn(
          title: '理由2',
          field: 'reason12',
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

            return Container(
                    padding: EdgeInsets.zero,
                    color: Colors.grey.withAlpha(50),
                    child: Center(
                      child: Text(
                        '${rendererContext.cell.value}',
                      ),
                    ),
                  );
          },
        ),
      ],
      if (tokobis.length > 2) ...[
        // mark
        PlutoColumn(
          title: DateUtil.getWeekDate(tokobis[2]),
          field: 'mark2',
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
            return Container(
                    padding: EdgeInsets.zero,
                    color: Colors.grey.withAlpha(50),
                    child: Center(
                      child: Text(
                        '${rendererContext.cell.value}',
                      ),
                    ),
                  );
          },
        ),

        // 理由1
        PlutoColumn(
          title: '理由1',
          field: 'reason21',
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

            return Container(
                    padding: EdgeInsets.zero,
                    color: Colors.grey.withAlpha(50),
                    child: Center(
                      child: Text(
                        '${rendererContext.cell.value}',
                      ),
                    ),
                  );
          },
        ),

        // 理由2
        PlutoColumn(
          title: '理由2',
          field: 'reason22',
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

            return Container(
                    padding: EdgeInsets.zero,
                    color: Colors.grey.withAlpha(50),
                    child: Center(
                      child: Text(
                        '${rendererContext.cell.value}',
                      ),
                    ),
                  );
          },
        ),
      ],
      PlutoColumn(
        title: '',
        field: 'isEditable',
        hide: true,
        type: PlutoColumnType.number(),
      ),
      PlutoColumn(
        title: '',
        field: 'tenshutsuYoteiFlg',
        hide: true,
        type: PlutoColumnType.number(),
      ),
      PlutoColumn(
        title: '',
        field: 'tenshutsuSumiFlg',
        hide: true,
        type: PlutoColumnType.number(),
      ),
      PlutoColumn(
        title: '学年',
        field: 'gakunen',
        hide: true,
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(
        title: 'StudentKihonId',
        field: 'studentKihonId',
        hide: true,
        type: PlutoColumnType.text(),
      ),
    ];
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> setReason(PlutoRow row) async {
    final stamp = ref.watch(healthStampProvider);
    if (stamp.jokyoCd == '001') return;

    final reason1 = ref.read(healthReason1Provider);
    final reason2 = ref.read(healthReason2Provider);

    final studentKihonId = row.cells['studentKihonId']!.value.toString();
    if (studentKihonId.isEmpty) return;

    final meibos = Boxes.getHealthMeiboBox().values.toList();
    HealthMeiboModel meibo;
    try {
      meibo = meibos
          .where(
            (e) => e.studentKihonId == int.parse(studentKihonId),
          )
          .toList()
          .first;
    } catch (e) {
      // ignore: avoid_print
      print('HealthList PlutoGrid get meibo error. $e');
      return;
    }

    await ref.read(healthMeiboListProvider.notifier).updateById(
          meibo,
          stamp,
          reason1,
          reason2,
        );

    // set all.
    final gakunen = row.cells['gakunen']!.value.toString();
    if (stamp.bunrui == '50') {
      for (final r in stateManager.rows) {
        if (r.cells['gakunen']!.value.toString() == gakunen &&
            r.cells['isEditable']!.value == 1) {
          r.cells['mark']!.value = stamp.jokyoNmRyaku;
          r.cells['reason1']!.value = reason1.jiyuNmSeishiki ?? '';
          r.cells['reason2']!.value = reason2.jiyuNmSeishiki ?? '';
        }
      }
      stateManager.notifyListeners();
      return;
    }

    //clear all and set one
    if (row.cells['mark']!.value.toString().startsWith('臨')) {
      for (final r in stateManager.rows) {
        if (r.sortIdx == row.sortIdx) {
          r.cells['mark']!.value = stamp.jokyoCd == '999'
              ? ''
              : '${stamp.jokyoNmRyaku}${reason1.jiyuNmRyaku ?? ''}';

          r.cells['reason1']!.value = reason1.jiyuNmSeishiki ?? '';
          r.cells['reason2']!.value = reason2.jiyuNmSeishiki ?? '';
        } else {
          r.cells['mark']!.value = '';
          r.cells['reason1']!.value = '';
          r.cells['reason2']!.value = '';
        }
      }
      stateManager.notifyListeners();
      return;
    }

    row.cells['mark']!.value = stamp.jokyoCd == '999'
        ? ''
        : '${stamp.jokyoNmRyaku}${reason1.jiyuNmRyaku ?? ''}';

    row.cells['reason1']!.value = reason1.jiyuNmSeishiki ?? '';
    row.cells['reason2']!.value = reason2.jiyuNmSeishiki ?? '';

    stateManager.notifyListeners();
  }

  void setBlank() {
    final isTokobi = ref.read(isTokobiProvider);
    if (isTokobi == false) return;

    for (final row in stateManager.rows) {
      if (row.cells['mark']!.value.toString().isEmpty &&
          row.cells['isEditable']!.value == 1) {
        row.cells['mark']!.value = '・.';
        row.cells['reason1']!.value = '健康';
        row.cells['reason2']!.value = '';
      }
    }

    stateManager.notifyListeners();
  }

  // void setAll(String mark, String reason1, String reason2) {
  //   for (final row in stateManager.rows) {

  //     row.cells['mark']!.value = mark;
  //     row.cells['reason1']!.value = reason1;
  //     row.cells['reason2']!.value = reason2;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(healthMeiboListProvider);

    return state.when(
      loading: () {
        return const Center(child: CircularProgressIndicator());
      },
      error: (AppException e) {
        return Text(e.toString());
      },
      loaded: () {
        return _build(context);
      },
    );
  }

  Widget _build(BuildContext context) {
    final list = Boxes.getHealthMeiboBox().values.toList();
    if (list.isEmpty) {
      return Container();
    } 
    
    return PlutoGrid(
      columns: getColumns(),
      rows: getRows(),
      onLoaded: (PlutoGridOnLoadedEvent event) {
        stateManager = event.stateManager;
        stateManager.setSelectingMode(PlutoGridSelectingMode.cell);
      },
      onSelected: (PlutoGridOnSelectedEvent event) async {
        if (event.row != null && event.row!.cells['isEditable']!.value == 1) {
          await setReason(event.row!);
        }
      },
      mode: PlutoGridMode.selectWithOneTap,
    );
  }
}
