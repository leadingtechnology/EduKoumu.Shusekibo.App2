import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kyoumutechou/feature/attendance/model/attendance_timed_meibo_model.dart';
import 'package:kyoumutechou/feature/attendance/model/attendance_timed_status_model.dart';
import 'package:kyoumutechou/feature/attendance/provider/attendance_reason_provider.dart';
import 'package:kyoumutechou/feature/attendance/provider/attendance_stamp_provider.dart';
import 'package:kyoumutechou/feature/attendance/provider/attendance_timed_meibo_provider.dart';
import 'package:kyoumutechou/feature/boxes.dart';
import 'package:kyoumutechou/feature/common/provider/filter_provider.dart';
import 'package:kyoumutechou/feature/common/provider/tokobis_provider.dart';
import 'package:kyoumutechou/shared/util/date_util.dart';
import 'package:pluto_grid/pluto_grid.dart';

// ignore: library_private_types_in_public_api
GlobalKey<_AttendanceTimedListWidgetState> attendanceTimedGlobalKey =
    GlobalKey();

class AttendanceTimedListWidget extends ConsumerStatefulWidget {
  const AttendanceTimedListWidget({super.key});

  @override
  ConsumerState<AttendanceTimedListWidget> createState() =>
      _AttendanceTimedListWidgetState();
}

// 出欠（日）widget
class _AttendanceTimedListWidgetState
    extends ConsumerState<AttendanceTimedListWidget> {
  late final PlutoGridStateManager stateManager;

  final _baseUrl = dotenv.env['BASE_URL']!;
  String accessToken = Hive.box<String>('shusekibo').get('token').toString();

  // 登校日
  late final List<DateTime> tokobis;

  // 行の設定
  List<PlutoRow> getRows() {
    final meibos0 = Boxes.getAttendanceTimedMeibo().values.toList();

    final rows = <PlutoRow>[];
    for (final e0 in meibos0) {
      rows.add(setPlutRow(e0));
    }
    return rows;
  }

  PlutoRow setPlutRow(
    AttendanceTimedMeiboModel e0,
  ) {
    final filter = ref.read(filterProvider);

    final isTokobi = ref.read(isTokobiProvider);
    final jigenIdx = filter.jigenIdx;

    var jokyo0 = AttendanceTimedStatusModel(
      jokyoDate: filter.targetDate ?? DateTime.now(),
      jigenIdx: jigenIdx,
      ryaku: '',
      jiyu1: '',
      jiyu2: '',
      isEditable: e0.jokyoList?[0].isEditable,
    );

    if (e0.jokyoList != null && e0.jokyoList!.isNotEmpty) {
      try {
        jokyo0 = e0.jokyoList!
            .where(
              (e) => e.jigenIdx == jigenIdx,
            )
            .toList()
            .first;
      } catch (ex) {
        //print('$ex');
      }
    }

    final row= PlutoRow(
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
            value: jokyo0.isEditable == true && isTokobi == true ? 1 : 0,),
        'tenshutsuYoteiFlg':
            PlutoCell(value: e0.tenshutsuYoteiFlg == true ? 1 : 0),
        'tenshutsuSumiFlg':
            PlutoCell(value: e0.tenshutsuSumiFlg == true ? 1 : 0),
        'gakunen': PlutoCell(value: e0.gakunen),
      },
    );

    return row;

  }

  // カラムの設定
  List<PlutoColumn> getColumns() {
    return [
      //PlutoColumn(title: 'クラス',  field: 'classNo',   readOnly: true, type: PlutoColumnType.text(),               width: 90, enableContextMenu: false, textAlign: PlutoColumnTextAlign.left, titleTextAlign: PlutoColumnTextAlign.center),

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
      // 写真
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

      // 理由１
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

      // 理由２
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
    ];
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    attendanceTimedGlobalKey = GlobalKey();
  }

  Future<void> setReason(PlutoRow row) async {
    final filter = ref.read(filterProvider);
    final stamp = ref.read(attendanceStampProvider);
    if (stamp.shukketsuJokyoCd == '001') return;

    final reason1 = ref.read(attendanceReason1Provider);
    final reason2 = ref.read(attendanceReason2Provider);

    final studentNumber = row.cells['shusekiNo']!.value.toString();
    if (studentNumber.isEmpty) return;

    final meibos = Boxes.getAttendanceTimedMeibo().values.toList();
    AttendanceTimedMeiboModel meibo;
    try {
      meibo = meibos
          .where(
            (e) => e.studentNumber == studentNumber,
          )
          .toList()
          .first;
    } catch (e) {
      // ignore: avoid_print
      print('AttendanceTimedList PlutoGrid get meibo error. $e');
      return;
    }

    await ref.read(attendanceTimedMeiboListProvider.notifier).updateById(
          meibo,
          stamp,
          filter,
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
      stateManager.notifyListeners();
      return;
    }

    row.cells['mark']!.value =
        stamp.shukketsuJokyoCd == '999' ? '' : stamp.shukketsuJokyoNmRyaku;

    row.cells['reason1']!.value = reason1.shukketsuJiyuNmSeishiki ?? '';
    row.cells['reason2']!.value = reason2.shukketsuJiyuNmSeishiki ?? '';

    stateManager.notifyListeners();
    return;
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

  // void setAll(String mark, String reason1, String reason2){
  //   for (final row in stateManager.rows) {

  //     row.cells['mark']!.value = mark;
  //     row.cells['reason1']!.value = reason1;
  //     row.cells['reason2']!.value = reason2;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final list = Boxes.getAttendanceTimedMeibo().values.toList();
    if (list.isEmpty) {
      return Container();
    } else {
      tokobis = getFilteredTokobiDates(
        ref.read(filterProvider).targetDate ?? DateTime.now(),
        ref.read(filterProvider).classId ?? 0,
      );
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
