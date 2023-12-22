
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
import 'package:kyoumutechou/feature/common/model/filter_model.dart';
import 'package:kyoumutechou/feature/common/provider/filter_provider.dart';
import 'package:kyoumutechou/feature/common/provider/tokobis_provider.dart';
import 'package:kyoumutechou/shared/util/date_util.dart';
import 'package:pluto_grid/pluto_grid.dart';

// ignore: library_private_types_in_public_api
GlobalKey<_AttendanceTimedListWidgetState> 
attendanceTimedGlobalKey = GlobalKey();

class AttendanceTimedListWidget extends ConsumerStatefulWidget {
  const AttendanceTimedListWidget({super.key});

  @override
  ConsumerState<AttendanceTimedListWidget> 
  createState() => _AttendanceTimedListWidgetState();
}

// 出欠（時限）widget
class _AttendanceTimedListWidgetState extends ConsumerState<AttendanceTimedListWidget> {
  late final List<PlutoColumn> columns = [];
  late final List<PlutoRow> rows = [];

  late FilterModel filter;
  late final PlutoGridStateManager stateManager;

  final _baseUrl = dotenv.env['BASE_URL']!;
  String accessToken = Hive.box<String>('shusekibo').get('token').toString();
 

  PlutoRow setPlutRow(AttendanceTimedMeiboModel e, int jigenIdx) {
    AttendanceTimedStatusModel jokyo;
    if (e.jokyoList != null && e.jokyoList!.isNotEmpty) {
      try {
        jokyo = e.jokyoList!.where(
          (e) => e.jigenIdx == jigenIdx,
        ).toList().first;
      } catch (ex) {
        jokyo = const AttendanceTimedStatusModel();
      }
    } else {
      jokyo = const AttendanceTimedStatusModel();
    }

    return PlutoRow(cells: {
      //'gakunen': PlutoCell(value: e.gakunen),
      //'classNo': PlutoCell(value: e.className),
      'shusekiNo': PlutoCell(value: e.studentNumber ?? ''),
      'photoPath': PlutoCell(value: e.photoUrl),
      'fullName': PlutoCell(value: e.name),
      'sex': PlutoCell(value: e.genderCode == '1' ? '男' : '女'),
      'mark': PlutoCell(value: jokyo.ryaku ?? ''),
      'reason1': PlutoCell(value: jokyo.jiyu1 ?? ''),
      'reason2': PlutoCell(value: jokyo.jiyu2 ?? ''),
    },);
  }

  @override
  void initState() {
    super.initState();
    filter = ref.read(filterProvider);

    columns.addAll([
      //PlutoColumn(title: '学年',    field: 'gakunen',   readOnly: true, type: PlutoColumnType.text(),               width: 70,  enableContextMenu:false, textAlign: PlutoColumnTextAlign.left, titleTextAlign: PlutoColumnTextAlign.center),
      //PlutoColumn(title: 'クラス',  field: 'classNo',   readOnly: true, type: PlutoColumnType.text(),               width: 90, enableContextMenu: false, textAlign: PlutoColumnTextAlign.left, titleTextAlign: PlutoColumnTextAlign.center),
      PlutoColumn(title: '出席番号',field: 'shusekiNo', readOnly: true, type: PlutoColumnType.text(), width: 80, enableContextMenu: false, textAlign: PlutoColumnTextAlign.right, titleTextAlign: PlutoColumnTextAlign.center),
      PlutoColumn(title: '写真',    field: 'photoPath', readOnly: true, type: PlutoColumnType.text(), enableDropToResize:false,
        enableContextMenu: false,
        textAlign: PlutoColumnTextAlign.center,
        titleTextAlign: PlutoColumnTextAlign.center,
        renderer: (rendererContext) {
          final photoUrl = 
          rendererContext.row.cells['photoPath']!.value.toString().trim();
          
          final url = '$_baseUrl$photoUrl';

          return ClipOval(child: Image.network(
            url,
            headers: {'Authorization': 'Bearer $accessToken'},
          ),);
        },
        width: 80,
      ),
      PlutoColumn(title: '氏名',    field: 'fullName',  readOnly: true, type: PlutoColumnType.text(),               width: 160, enableContextMenu:false , textAlign: PlutoColumnTextAlign.left, titleTextAlign: PlutoColumnTextAlign.center),
      PlutoColumn(title: '性別',    field: 'sex',       readOnly: true, type: PlutoColumnType.text(),               width: 70,  enableContextMenu: false, textAlign: PlutoColumnTextAlign.left, titleTextAlign: PlutoColumnTextAlign.center),
      PlutoColumn(title: DateUtil.getWeekDate(filter.targetDate ?? DateTime.now(),),    field: 'mark', readOnly: true, type: PlutoColumnType.text(),               width: 100, enableContextMenu: false, textAlign: PlutoColumnTextAlign.left, titleTextAlign: PlutoColumnTextAlign.center),
      PlutoColumn(title: '理由1',   field: 'reason1',   readOnly: true, type: PlutoColumnType.text(),               width: 216, enableContextMenu: false, textAlign: PlutoColumnTextAlign.left, titleTextAlign: PlutoColumnTextAlign.center),
      PlutoColumn(title: '理由2',   field: 'reason2',   readOnly: true, type: PlutoColumnType.text(),               width: 216, enableContextMenu: false, textAlign: PlutoColumnTextAlign.left, titleTextAlign: PlutoColumnTextAlign.center),
    ]);

    final meibos = Boxes.getAttendanceTimedMeiboModelBox().values.toList();
    rows.addAll(meibos.map((e) => setPlutRow(e, filter.jigenIdx??0)).toList()); 
  }

  Future<void> setReason(PlutoRow row, WidgetRef ref) async {
    final stamp = ref.read(attendanceStampProvider);
    if (stamp.shukketsuJokyoCd == '001') return;

    final reason1 = ref.watch(attendanceReason1Provider);
    final reason2 = ref.watch(attendanceReason2Provider);

    final studentNumber = row.cells['shusekiNo']!.value.toString();
    if (studentNumber.isEmpty) return;

    final meibos = Boxes.getAttendanceTimedMeiboModelBox().values.toList();
    AttendanceTimedMeiboModel meibo;
    try {
      meibo = meibos.where(
        (e) => e.studentNumber == studentNumber,
      ).toList().first;
    } catch (e) {
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
    if (stamp.shukketsuBunrui == '50' || stamp.shukketsuBunrui == '60') {
      for (final r in stateManager.rows) {
        r.cells['mark']!.value = stamp.shukketsuJokyoNmRyaku;
        r.cells['reason1']!.value = reason1.shukketsuJiyuNmSeishiki ?? '';
        r.cells['reason2']!.value = reason2.shukketsuJiyuNmSeishiki ?? '';
      }
      stateManager.notifyListeners();
      return;
    }

    //clear all and set one
    if(row.cells['mark']!.value == '臨１' || 
        row.cells['mark']!.value == '臨２') {
      
      for (final r in stateManager.rows) {
        if (r.sortIdx == row.sortIdx) {
          r.cells['mark']!.value = stamp.shukketsuJokyoCd=='999'
              ? '' : stamp.shukketsuJokyoNmRyaku;
          r.cells['reason1']!.value = reason1.shukketsuJiyuNmSeishiki ?? '';
          r.cells['reason2']!.value = reason2.shukketsuJiyuNmSeishiki ?? '';
        }else{
          r.cells['mark']!.value = '';
          r.cells['reason1']!.value = '';
          r.cells['reason2']!.value = '';
        }
      }
      stateManager.notifyListeners();
      return;
    }

    row.cells['mark']!.value = stamp.shukketsuJokyoCd=='999'
        ? '' : stamp.shukketsuJokyoNmRyaku;
    row.cells['reason1']!.value = reason1.shukketsuJiyuNmSeishiki ?? '';
    row.cells['reason2']!.value = reason2.shukketsuJiyuNmSeishiki ?? '';
    stateManager.notifyListeners();
  }

  void setBlank() {
    for (final row in stateManager.rows) { 
      if (row.cells['mark']!.value.toString().isEmpty) {
        row.cells['mark']!.value = '・';
        row.cells['reason1']!.value = '';
        row.cells['reason2']!.value = '';
      }
    }
    stateManager.notifyListeners();
  } 

  void setAll(String mark, String reason1, String reason2){
    for (final row in stateManager.rows) {
      row.cells['mark']!.value = mark;
      row.cells['reason1']!.value = reason1;
      row.cells['reason2']!.value = reason2;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditable = ref.watch(isTokobiProvider);
    
    return PlutoGrid(
      columns: columns,
      rows: rows,
      onLoaded: (PlutoGridOnLoadedEvent event) {
        stateManager = event.stateManager;
        stateManager.setSelectingMode(PlutoGridSelectingMode.cell);
      },
      onSelected: (PlutoGridOnSelectedEvent event) {
        if (event.row != null && isEditable) {
          setReason(event.row!, ref);
        }
      },
      mode: PlutoGridMode.selectWithOneTap,
    );
  }
}
