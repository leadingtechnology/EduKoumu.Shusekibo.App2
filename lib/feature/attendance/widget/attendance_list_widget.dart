
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kyoumutechou/feature/attendance/model/attendance_meibo_model.dart';
import 'package:kyoumutechou/feature/attendance/model/attendance_reason_model.dart';
import 'package:kyoumutechou/feature/attendance/model/attendance_stamp_model.dart';
import 'package:kyoumutechou/feature/attendance/provider/attendance_meibo_provider.dart';
import 'package:kyoumutechou/feature/attendance/provider/attendance_reason_provider.dart';
import 'package:kyoumutechou/feature/attendance/provider/attendance_stamp_provider.dart';
import 'package:kyoumutechou/feature/boxes.dart';
import 'package:kyoumutechou/feature/common/model/filter_model.dart';
import 'package:kyoumutechou/feature/common/provider/filter_provider.dart';
import 'package:kyoumutechou/shared/util/date_util.dart';
import 'package:pluto_grid/pluto_grid.dart';

GlobalKey<_AttendanceListWidgetState> attendanceGlobalKey = GlobalKey();

class AttendanceListWidget extends ConsumerStatefulWidget {
  const AttendanceListWidget({Key? key}) : super(key: key);

  @override
  ConsumerState<AttendanceListWidget> createState() => _AttendanceListWidgetState();
}

class _AttendanceListWidgetState extends ConsumerState<AttendanceListWidget> {
  final List<PlutoColumn> columns = [];
  final List<PlutoRow> rows = [];

  late final PlutoGridStateManager stateManager;
  late FilterModel filter;

  final _baseUrl = dotenv.env['BASE_URL']!;
  String accessToken = Hive.box<String>('shusekibo').get('token').toString();


  PlutoRow setPlutRow(AttendanceMeiboModel e) {
    print('行設定時の写真パス：${e.photoUrl}');
    return PlutoRow(cells: {
      'gakunen': PlutoCell(value: e.gakunen),
      'classNo': PlutoCell(value: e.className),
      'shusekiNo': PlutoCell(value: e.studentNumber??''),
      'photoPath': PlutoCell(value: e.photoUrl),
      'fullName': PlutoCell(value: e.name),
      'sex': PlutoCell(value: e.genderCode == '1' ? '男' : '女'),
      'mark': PlutoCell(value: e.jokyoList![0].ryaku ?? ''),
      'reason1': PlutoCell(value: e.jokyoList![0].jiyu1 ?? ''),
      'reason2': PlutoCell(value: e.jokyoList![0].jiyu2 ?? ''),
    });
  }

  @override
  void initState() {
    super.initState();
    // "ref" can be used in all life-cycles of a StatefulWidget.
    filter = ref.read(filterProvider);

    columns.addAll([
      PlutoColumn(title: '学年',    field: 'gakunen',   readOnly: true, type: PlutoColumnType.text(), width: 70,  enableContextMenu:false, textAlign: PlutoColumnTextAlign.left, titleTextAlign: PlutoColumnTextAlign.center),
      PlutoColumn(title: 'クラス',  field: 'classNo',   readOnly: true, type: PlutoColumnType.text(), width: 90, enableContextMenu: false, textAlign: PlutoColumnTextAlign.left, titleTextAlign: PlutoColumnTextAlign.center),
      PlutoColumn(title: '出席番号',field: 'shusekiNo', readOnly: true, type: PlutoColumnType.text(), width: 80, enableContextMenu: false, textAlign: PlutoColumnTextAlign.right, titleTextAlign: PlutoColumnTextAlign.center),
      PlutoColumn(
        title: '写真',    
        field: 'photoPath', 
        readOnly: true, 
        type: PlutoColumnType.text(), 
        enableDropToResize:false,
        enableContextMenu: false,
        textAlign: PlutoColumnTextAlign.center,
        titleTextAlign: PlutoColumnTextAlign.center,
        renderer: (rendererContext) {

          var photoUrl = '${rendererContext.row.cells['photoPath']!.value.toString()}'.trim();
          String url = '${_baseUrl}$photoUrl';

          return ClipOval(child: Image.network(
            url,
            headers: {"Authorization": "Bearer " + accessToken},
          ));
        },
        width: 80,
      ),
      PlutoColumn(title: '氏名',    field: 'fullName',  readOnly: true, type: PlutoColumnType.text(),               width: 160, enableContextMenu:false , textAlign: PlutoColumnTextAlign.left, titleTextAlign: PlutoColumnTextAlign.center),
      PlutoColumn(title: '性別',    field: 'sex',       readOnly: true, type: PlutoColumnType.text(),               width: 70,  enableContextMenu: false, textAlign: PlutoColumnTextAlign.left, titleTextAlign: PlutoColumnTextAlign.center),
      PlutoColumn(title: '${DateUtil.getWeekDate(filter.targetDate??DateTime.now())}',    field: 'mark', readOnly: true, type: PlutoColumnType.text(),               width: 100, enableContextMenu: false, textAlign: PlutoColumnTextAlign.left, titleTextAlign: PlutoColumnTextAlign.center),
      PlutoColumn(title: '理由1',   field: 'reason1',   readOnly: true, type: PlutoColumnType.text(),               width: 216, enableContextMenu: false, textAlign: PlutoColumnTextAlign.left, titleTextAlign: PlutoColumnTextAlign.center),
      PlutoColumn(title: '理由2',   field: 'reason2',   readOnly: true, type: PlutoColumnType.text(),               width: 216, enableContextMenu: false, textAlign: PlutoColumnTextAlign.left, titleTextAlign: PlutoColumnTextAlign.center),
    ]);

    final List<AttendanceMeiboModel> meibos = Boxes.getAttendanceMeiboModelBox().values.toList();
    
    rows.addAll(meibos.map((e) => setPlutRow(e)).toList()); 
  }

  void setReason(PlutoRow row, WidgetRef ref) async {
    AttendanceStampModel stamp = ref.read(attendanceStampProvider);
    if (stamp.shukketsuJokyoCd == '001') return;

    AttendanceReasonModel reason1 = ref.watch(attendanceReason1Provider);
    AttendanceReasonModel reason2 = ref.watch(attendanceReason2Provider);

    String studentNumber = row.cells['shusekiNo']!.value.toString();
    if (studentNumber.isEmpty) return;

    final List<AttendanceMeiboModel> meibos =
        Boxes.getAttendanceMeiboModelBox().values.toList();
    AttendanceMeiboModel meibo;
    try {
      meibo =
          meibos.where((e) => e.studentNumber == studentNumber).toList().first;
    } catch (e) {
      print('HealthListWidget PlutoGrid get meibo error. ${e.toString()}');
      return;
    }

    ref.read(attendanceMeiboListProvider.notifier).updateById(
          meibo,
          stamp,
          reason1,
          reason2,
        );
    
    // set all.
    if (stamp.shukketsuBunrui == '50' || stamp.shukketsuBunrui == '60') {
      stateManager.rows.forEach((r) {
        r.cells['mark']!.value = stamp.shukketsuJokyoNmRyaku;
        r.cells['reason1']!.value = reason1.shukketsuJiyuNmSeishiki ?? '';
        r.cells['reason2']!.value = reason2.shukketsuJiyuNmSeishiki ?? '';
      });
      stateManager.notifyListeners();
      return;
    }

    //clear all and set one
    if(row.cells['mark']!.value == '臨１' || row.cells['mark']!.value == '臨２') {
      stateManager.rows.forEach((r) {
        if (r.sortIdx == row.sortIdx) {
          r.cells['mark']!.value = stamp.shukketsuJokyoCd=='999'?'':stamp.shukketsuJokyoNmRyaku;;
          r.cells['reason1']!.value = reason1.shukketsuJiyuNmSeishiki ?? '';
          r.cells['reason2']!.value = reason2.shukketsuJiyuNmSeishiki ?? '';
        }else{
          r.cells['mark']!.value = '';
          r.cells['reason1']!.value = '';
          r.cells['reason2']!.value = '';
        }
      });
      stateManager.notifyListeners();
      return;
    }

    row.cells['mark']!.value = stamp.shukketsuJokyoCd=='999'?'':stamp.shukketsuJokyoNmRyaku;
    row.cells['reason1']!.value = reason1.shukketsuJiyuNmSeishiki ?? '';
    row.cells['reason2']!.value = reason2.shukketsuJiyuNmSeishiki ?? '';
    stateManager.notifyListeners();
  }

  void setBlank() {
    stateManager.rows.forEach((row) { 
      if (row.cells['mark']!.value.toString().isEmpty) {
        row.cells['mark']!.value = '・';
        row.cells['reason1']!.value = '';
        row.cells['reason2']!.value = '';
      }
    });
    stateManager.notifyListeners();
  } 

  void setAll(String mark, String reason1, String reason2){
    stateManager.rows.forEach((row) {
      row.cells['mark']!.value = mark;
      row.cells['reason1']!.value = reason1;
      row.cells['reason2']!.value = reason2;
    });
  }

  @override
  Widget build(BuildContext context) {
    return PlutoGrid(
      columns: columns,
      rows: rows,
      onLoaded: (PlutoGridOnLoadedEvent event) {
        stateManager = event.stateManager;
        stateManager.setSelectingMode(PlutoGridSelectingMode.cell);
      },
      onSelected: (PlutoGridOnSelectedEvent event) {
        if (event.row != null) {
          setReason(event.row!, ref);
        }
      },
      mode: PlutoGridMode.selectWithOneTap,
    );
  }
}
