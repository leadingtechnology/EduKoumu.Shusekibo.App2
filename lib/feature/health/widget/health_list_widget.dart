import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kyoumutechou/feature/boxes.dart';
import 'package:kyoumutechou/feature/common/model/filter_model.dart';
import 'package:kyoumutechou/feature/common/provider/filter_provider.dart';
import 'package:kyoumutechou/feature/health/model/health_meibo_model.dart';
import 'package:kyoumutechou/feature/health/model/health_status_model.dart';
import 'package:kyoumutechou/feature/health/provider/health_meibo_provider.dart';
import 'package:kyoumutechou/feature/health/provider/health_reason_provider.dart';
import 'package:kyoumutechou/feature/health/provider/health_stamp_provider.dart';
import 'package:kyoumutechou/shared/util/date_util.dart';
import 'package:pluto_grid/pluto_grid.dart';


// ignore: library_private_types_in_public_api
GlobalKey<_HealthListWidgetState> 
helthGlobalKey = GlobalKey();

class HealthListWidget extends ConsumerStatefulWidget {
  const HealthListWidget({super.key});

  @override
  ConsumerState<HealthListWidget> 
  createState() => _HealthListWidgetState();
}

// 健康widget
class _HealthListWidgetState extends ConsumerState<HealthListWidget> {
  late final List<PlutoColumn> columns = [];
  late final List<PlutoRow> rows = [];

  late FilterModel filter;
  late final PlutoGridStateManager stateManager;
  
  final _baseUrl = dotenv.env['BASE_URL']!;
  String accessToken = Hive.box<String>('shusekibo').get('token').toString();

  PlutoRow setPlutRow(HealthMeiboModel e) {
    HealthStatusModel jokyo;
    if (e.jokyoList != null && e.jokyoList!.isNotEmpty) {
      try {
        jokyo = e.jokyoList!.first;
      } catch (ex) {
        jokyo = const HealthStatusModel();
      }
    } else {
      jokyo = const HealthStatusModel();
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
      PlutoColumn(title: '${DateUtil.getWeekDate(filter.targetDate??DateTime.now())}', field: 'mark', readOnly: true, type: PlutoColumnType.text(),          width: 100, enableContextMenu: false, textAlign: PlutoColumnTextAlign.left, titleTextAlign: PlutoColumnTextAlign.center),
      PlutoColumn(title: '理由1',   field: 'reason1',   readOnly: true, type: PlutoColumnType.text(),               width: 216, enableContextMenu: false, textAlign: PlutoColumnTextAlign.left, titleTextAlign: PlutoColumnTextAlign.center),
      PlutoColumn(title: '理由2',   field: 'reason2',   readOnly: true, type: PlutoColumnType.text(),               width: 216, enableContextMenu: false, textAlign: PlutoColumnTextAlign.left, titleTextAlign: PlutoColumnTextAlign.center),    
    ]);

    final meibos = Boxes.getHealthMeiboBox().values.toList();
    rows.addAll(meibos.map(setPlutRow).toList()); 
  }


  Future<void> setReason(PlutoRow row, WidgetRef ref) async {
    final stamp = ref.watch(healthStampProvider);
    if(stamp.jokyoCd == '001') return ;

    final reason1 = ref.watch(healthReason1Provider);
    final reason2 = ref.watch(healthReason2Provider);

    final studentNumber = row.cells['shusekiNo']!.value.toString();
    if (studentNumber.isEmpty) return;

    final meibos = Boxes.getHealthMeiboBox().values.toList();
    HealthMeiboModel meibo;
    try {
      meibo = meibos.where(
        (e) => e.studentNumber == studentNumber,
      ).toList().first;
    }catch(e){
      print('HealthList PlutoGrid get meibo error. $e');
      return ;
    }

    await ref.read(healthMeiboListProvider.notifier).updateById( 
      meibo, 
      stamp, 
      reason1, 
      reason2, 
    );
    
    // set all.
    if (stamp.bunrui == '50') {
      for (final r in stateManager.rows) {
        r.cells['mark']!.value = stamp.jokyoNmRyaku;
        r.cells['reason1']!.value = reason1.jiyuNmSeishiki ?? '';
        r.cells['reason2']!.value = reason2.jiyuNmSeishiki ?? '';
      }
      stateManager.notifyListeners();
      return;
    }

    //clear all and set one
    if(row.cells['mark']!.value.toString().startsWith('臨')) {

      for (final r in stateManager.rows) {
        if (r.sortIdx == row.sortIdx) {
          r.cells['mark']!.value = stamp.jokyoCd =='999'
              ? '' : stamp.jokyoNmRyaku;
          r.cells['reason1']!.value = reason1.jiyuNmSeishiki ?? '';
          r.cells['reason2']!.value = reason2.jiyuNmSeishiki ?? '';
        }else{
          r.cells['mark']!.value = '';
          r.cells['reason1']!.value = '';
          r.cells['reason2']!.value = '';
        }
      }
      stateManager.notifyListeners();
      return;
    }

    row.cells['mark']!.value = stamp.jokyoCd =='999'
        ? '' : stamp.jokyoNmRyaku;
    row.cells['reason1']!.value = reason1.jiyuNmSeishiki ?? '';
    row.cells['reason2']!.value = reason2.jiyuNmSeishiki ?? '';
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

  void setAll(String mark, String reason1, String reason2) {
    for (final row in stateManager.rows) {
      row.cells['mark']!.value = mark;
      row.cells['reason1']!.value = reason1;
      row.cells['reason2']!.value = reason2;
    }
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
