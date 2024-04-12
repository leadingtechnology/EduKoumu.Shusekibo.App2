import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kyoumutechou/feature/attendance/model/attendance_meibo_model.dart';
import 'package:kyoumutechou/feature/attendance/model/attendance_status_model.dart';
import 'package:kyoumutechou/feature/attendance/provider/attendance_meibo_provider.dart';
import 'package:kyoumutechou/feature/attendance/provider/attendance_reason_provider.dart';
import 'package:kyoumutechou/feature/attendance/provider/attendance_stamp_provider.dart';
import 'package:kyoumutechou/feature/boxes.dart';
import 'package:kyoumutechou/feature/common/provider/filter_provider.dart';
import 'package:kyoumutechou/feature/common/provider/tokobis_provider.dart';
import 'package:kyoumutechou/shared/util/date_util.dart';
import 'package:pluto_grid/pluto_grid.dart';

// ignore: library_private_types_in_public_api
GlobalKey<_AttendanceListWidgetState> attendanceGlobalKey = GlobalKey();

class AttendanceListWidget extends ConsumerStatefulWidget {
  const AttendanceListWidget({super.key});

  @override
  ConsumerState<AttendanceListWidget> createState() =>
      _AttendanceListWidgetState();
}

// 出欠（日）widget
class _AttendanceListWidgetState extends ConsumerState<AttendanceListWidget> {
  late final PlutoGridStateManager stateManager;

  final _baseUrl = dotenv.env['BASE_URL']!;
  String accessToken = Hive.box<String>('shusekibo').get('token').toString();

  // 行の設定
  List<PlutoRow> getRows() {
    final meibos0 = Boxes.getAttendanceMeibo().values.toList();
    final meibos1 = Boxes.getAttendanceMeibo1().values.toList();
    final meibos2 = Boxes.getAttendanceMeibo2().values.toList();

    final rows = <PlutoRow>[];
    for (final e0 in meibos0) {
      AttendanceMeiboModel e1;
      try {
        e1 = meibos1
          .where((e) => e.studentKihonId == e0.studentKihonId)
          .toList()
          .first;
      } catch (ex) {
        e1 = const AttendanceMeiboModel();
      }
      
      AttendanceMeiboModel e2;
      try {
        e2 = meibos2
          .where((e) => e.studentKihonId == e0.studentKihonId)
          .toList()
          .first;
      } catch (ex) {
        e2 = const AttendanceMeiboModel();
      }

      rows.add(setPlutRow(e0, e1, e2));
    }
    return rows;
  }

  PlutoRow setPlutRow(
    AttendanceMeiboModel e0,
    AttendanceMeiboModel e1,
    AttendanceMeiboModel e2,
  ) {

    final isTokobi = ref.read(isTokobiProvider);
    final tokobis = getFilteredTokobiDates(
      ref.read(filterProvider).targetDate ?? DateTime.now(),
      ref.read(filterProvider).classId ?? 0,
    );    

    AttendanceStatusModel jokyo0;
    if (e0.jokyoList != null && e0.jokyoList!.isNotEmpty) {
      try {
        jokyo0 = e0.jokyoList!.first;
      } catch (ex) {
        jokyo0 = const AttendanceStatusModel();
      }
    } else {
      jokyo0 = const AttendanceStatusModel();
    }

    AttendanceStatusModel jokyo1;
    if (e1.jokyoList != null && e1.jokyoList!.isNotEmpty) {
      try {
        jokyo1 = e1.jokyoList!.first;
      } catch (ex) {
        jokyo1 = const AttendanceStatusModel();
      }
    } else {
      jokyo1 = const AttendanceStatusModel();
    }

    AttendanceStatusModel jokyo2;
    if (e2.jokyoList != null && e2.jokyoList!.isNotEmpty) {
      try {
        jokyo2 = e2.jokyoList!.first;
      } catch (ex) {
        jokyo2 = const AttendanceStatusModel();
      }
    } else {
      jokyo2 = const AttendanceStatusModel();
    }

    PlutoRow row;
    switch (tokobis.length-1) {
      case 1:
        row = PlutoRow(
          cells: {
            //'classNo': PlutoCell(value: e.className),
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
            //'classNo': PlutoCell(value: e.className),
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
            //'classNo': PlutoCell(value: e.className),
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
            'studentKihonId':PlutoCell(value: e0.studentKihonId),
          },
        );
        break;
    }

    return row;

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
  }

  // カラムの設定
  List<PlutoColumn> getColumns() {
    final tokobis = getFilteredTokobiDates(
      ref.read(filterProvider).targetDate ?? DateTime.now(),
      ref.read(filterProvider).classId ?? 0,
    );

    return [
      // 出席番号
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
              '${rendererContext.row.cells['photoPath']!.value.toString()}'
                  .trim();
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
        renderer: (rendererContext) {
          return Text(
            '${rendererContext.cell.value}',
            style: TextStyle(
              color: rendererContext.row.cells['tenshutsuYoteiFlg']!.value == 1
                  ? Colors.blue
                  : rendererContext.row.cells['tenshutsuSumiFlg']!.value == 1
                      ? Colors.grey
                      : Colors.black,
            ),
          );
        },
        frozen: PlutoColumnFrozen.start,
      ),
      PlutoColumn(
          title: '性別',
          field: 'sex',
          readOnly: true,
          enableSorting: false,
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
        renderer: (rc) {
          final isEditable = rc.row.cells['isEditable']!.value == 1;

          return isEditable
              ? Center(
                  child: Text(
                  '${rc.cell.value}',
                ),)
              : Container(
                  padding: EdgeInsets.zero,
                  color: Colors.grey.withAlpha(50),
                  child: Center(
                    child: Text(
                      '${rc.cell.value}',
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
        renderer: (rc) {
          final isEditable = rc.row.cells['isEditable']!.value == 1;

          return isEditable
              ? Text(
                  '${rc.cell.value}',
                )
              : Container(
                  padding: EdgeInsets.zero,
                  color: Colors.grey.withAlpha(50),
                  child: Center(
                    child: Text(
                      '${rc.cell.value}',
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
        renderer: (rc) {
          final isEditable = rc.row.cells['isEditable']!.value == 1;

          return isEditable
              ? Text(
                  '${rc.cell.value}',
                )
              : Container(
                  padding: EdgeInsets.zero,
                  color: Colors.grey.withAlpha(50),
                  child: Center(
                    child: Text(
                      '${rc.cell.value}',
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
          renderer: (rc) {

            return Container(
                    padding: EdgeInsets.zero,
                    color: Colors.grey.withAlpha(50),
                    child: Center(
                      child: Text(
                        '${rc.cell.value}',
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
          renderer: (rc) {

            return Container(
                    padding: EdgeInsets.zero,
                    color: Colors.grey.withAlpha(50),
                    child: Center(
                      child: Text(
                        '${rc.cell.value}',
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
          renderer: (rc) {

            return Container(
                    padding: EdgeInsets.zero,
                    color: Colors.grey.withAlpha(50),
                    child: Center(
                      child: Text(
                        '${rc.cell.value}',
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
          renderer: (rc) {

            return Container(
                    padding: EdgeInsets.zero,
                    color: Colors.grey.withAlpha(50),
                    child: Center(
                      child: Text(
                        '${rc.cell.value}',
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
          renderer: (rc) {

            return Container(
                    padding: EdgeInsets.zero,
                    color: Colors.grey.withAlpha(50),
                    child: Center(
                      child: Text(
                        '${rc.cell.value}',
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
          renderer: (rc) {

            return Container(
                    padding: EdgeInsets.zero,
                    color: Colors.grey.withAlpha(50),
                    child: Center(
                      child: Text(
                        '${rc.cell.value}',
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
    attendanceGlobalKey = GlobalKey();
  }

  Future<void> setReason(PlutoRow row) async {
    final stamp = ref.read(attendanceStampProvider);
    if (stamp.shukketsuJokyoCd == '001') return;

    final reason1 = ref.read(attendanceReason1Provider);
    final reason2 = ref.read(attendanceReason2Provider);

    final studentKihonId = row.cells['studentKihonId']!.value.toString();
    if (studentKihonId.isEmpty) return;

    final meibos = Boxes.getAttendanceMeibo().values.toList();
    AttendanceMeiboModel meibo;
    try {
      meibo = meibos
          .where(
            (e) => e.studentKihonId == int.parse(studentKihonId),
          )
          .toList()
          .first;
    } catch (e) {
      print('AttendanceList PlutoGrid get meibo error. ${e.toString()}');
      return;
    }

    await ref.read(attendanceMeiboListProvider.notifier).updateById(
          meibo,
          stamp,
          reason1,
          reason2,
        );

    // set all.
    final gakunen = row.cells['gakunen']!.value.toString();
    if (stamp.shukketsuBunrui == '50' || stamp.shukketsuBunrui == '60') {
      for (final r in stateManager.rows) {
        if (r.cells['gakunen']!.value.toString() == gakunen &&
            r.cells['isEditable']!.value == 1) {
          r.cells['mark']!.value = stamp.shukketsuJokyoNmRyaku;
          r.cells['reason1']!.value = reason1.shukketsuJiyuNmSeishiki ?? '';
          r.cells['reason2']!.value = reason2.shukketsuJiyuNmSeishiki ?? '';
        }
      }
      stateManager.notifyListeners();
      return;
    }

    //clear all and set one
    if (row.cells['mark']!.value == '臨１' || row.cells['mark']!.value == '臨２') {
      for (final r in stateManager.rows) {
        if (r.cells['gakunen']!.value.toString() == gakunen &&
            r.cells['isEditable']!.value == 1) {
              
          if (r.sortIdx == row.sortIdx) {
            r.cells['mark']!.value = stamp.shukketsuJokyoCd == '999'
                ? ''
                : '${stamp.shukketsuJokyoNmRyaku}';

            r.cells['reason1']!.value = reason1.shukketsuJiyuNmSeishiki ?? '';
            r.cells['reason2']!.value = reason2.shukketsuJiyuNmSeishiki ?? '';
          } else {
            r.cells['mark']!.value = '';
            r.cells['reason1']!.value = '';
            r.cells['reason2']!.value = '';
          }
        }
        
      }
      stateManager.notifyListeners();
      return;
    }

    row.cells['mark']!.value =
        stamp.shukketsuJokyoCd == '999' ? '' : stamp.shukketsuJokyoNmRyaku;

    row.cells['reason1']!.value = reason1.shukketsuJiyuNmSeishiki ?? '';
    row.cells['reason2']!.value = reason2.shukketsuJiyuNmSeishiki ?? '';

    stateManager.notifyListeners();
  }

  void setBlank() {
    final isTokobi = ref.read(isTokobiProvider);
    if (isTokobi == false) return;

    for (final row in stateManager.rows) {
      if (row.cells['mark']!.value.toString().isEmpty &&
          row.cells['isEditable']!.value == 1) {
        row.cells['mark']!.value = '・';
        row.cells['reason1']!.value = '';
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
    final list = Boxes.getAttendanceMeibo().values.toList();
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

}
