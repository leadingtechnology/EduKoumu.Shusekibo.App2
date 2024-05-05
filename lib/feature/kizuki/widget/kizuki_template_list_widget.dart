import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:kyoumutechou/feature/awareness/model/awareness_code_model.dart';
import 'package:kyoumutechou/feature/boxes.dart';
import 'package:kyoumutechou/feature/home/provider/home_provider.dart';
import 'package:kyoumutechou/feature/kizuki/model/kizuki_template_model.dart';
import 'package:kyoumutechou/feature/kizuki/provider/kizuki_template_provider.dart';
import 'package:kyoumutechou/feature/kizuki/widget/kizuki_template_dialog.dart';
import 'package:kyoumutechou/shared/http/app_exception.dart';
import 'package:kyoumutechou/shared/util/date_util.dart';
import 'package:pluto_grid/pluto_grid.dart';

class KizukiTemplateListWidget extends ConsumerWidget {
  KizukiTemplateListWidget({
    super.key,
  });

  List<KizukiTemplateModel> filterList(
    List<KizukiTemplateModel> list,
    String searchText,
    List<AwarenessCodeModel> bunruis,
  ) {
    var ktms = <KizukiTemplateModel>[];
    try{
      ktms = list.where((row) {
        final commonFlg = row.commonFlg;
        final karuteBunruiCode = row.karuteBunruiCode;
        final title = row.title;
        final kizukiTemplate = row.kizukiTemplate;

        if (searchText != '') {
          // 学校共通
          if (commonFlg != null) {
            if (searchText.contains('共通') && commonFlg == true) {
              return true;
            }
            if (searchText.contains('個人') && commonFlg == false) {
              return true;
            }
          }

          // 分類
          if (karuteBunruiCode != null) {
            try {
              final name = bunruis
                  .firstWhere((element) => element.code == karuteBunruiCode)
                  .name;
              if (searchText.contains('$name')) {
                return true;
              }
            } catch (e) {
              // ignore
            }
          }

          // タイトル
          if (title != null) {
            if (title.contains(searchText)) {
              return true;
            }
          }

          // 気づき
          if (kizukiTemplate != null) {
            if (kizukiTemplate.contains(searchText)) {
              return true;
            }
          }
          return false;
        }
        return true;
      }).toList();

    }catch(e){
      // ignore
    }
    
    return ktms;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(kizukiTemplateProvider);

    return state.when(
      loading: () {
        return const Center(child: CircularProgressIndicator());
      },
      error: (AppException e) {
        return Text(e.toString());
      },
      loaded: (items) {
        //final searchText = ref.watch(kzukiSearchTextProvider);
        //final filteredList = filterList(list, searchText, bunruis);
        final list = <KizukiTemplateModel>[...items]

        ..sort((a, b) {
          var compare = b.crtDateTime!.compareTo(a.crtDateTime!);
          if (compare != 0) return compare;

          compare = a.karuteBunruiCode!.compareTo(b.karuteBunruiCode!);
          if (compare != 0) return compare;

          return a.id!.compareTo(b.id!);
        });

        return KizukiGridWidget(
          list: list,
          key: kizukiGlobalKey,
        );
      },
    );
  }
}

// ignore: library_private_types_in_public_api
GlobalKey<_KizukiGridWidgetState> kizukiGlobalKey = GlobalKey();

class KizukiGridWidget extends ConsumerStatefulWidget {
  const KizukiGridWidget({
    required this.list,
    super.key,
  });

  final List<KizukiTemplateModel> list;

  @override
  ConsumerState<KizukiGridWidget> createState() =>
      _KizukiGridWidgetState();
}

class _KizukiGridWidgetState extends ConsumerState<KizukiGridWidget> {
  late final PlutoGridStateManager stateManager;

  String accessToken = Hive.box<String>('shusekibo').get('token').toString();
  final bunruis = Boxes.getBunruiBox().values.toList();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void filter(String value) {
    
    final filteredList = widget.list.where((row) {
      final commonFlg = row.commonFlg;
      final karuteBunruiCode = row.karuteBunruiCode;
      final title = row.title;
      final kizukiTemplate = row.kizukiTemplate;

      if (value != '') {
        // 学校共通
        if (commonFlg != null) {
          if (commonFlg == true && value == '共通') {
            return true;
          }
          if (commonFlg == false && value == '個人') {
            return true;
          }
        }

        // 分類
        if (karuteBunruiCode != null) {
          try {
            final name = bunruis
                .firstWhere((element) => element.code == karuteBunruiCode)
                .name;
            if (value == name) {
              return true;
            }
          } catch (e) {
            // ignore
          }
        }

        // タイトル
        if (title != null) {
          if (title.contains(value)) {
            return true;
          }
        }

        // 気づき
        if (kizukiTemplate != null) {
          if (kizukiTemplate.contains(value)) {
            return true;
          }
        }
        return false;
      }
      return true;
    }).toList();

    final rows = getRows(filteredList);
    stateManager
      ..removeAllRows()
      ..appendRows(rows)
      ..notifyListeners();

  }

  @override
  Widget build(BuildContext context) {
    return PlutoGrid(
      columns: getColumns(widget.list),
      rows: getRows(widget.list),
      onLoaded: (PlutoGridOnLoadedEvent event) {
        stateManager = event.stateManager;
        stateManager.setSelectingMode(PlutoGridSelectingMode.cell);
      },
      onSelected: (PlutoGridOnSelectedEvent event) async {},
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

  List<PlutoRow> getRows(List<KizukiTemplateModel> list) {
    final rows = <PlutoRow>[];
    for (var i = 0; i < list.length; i++) {
      final model = list[i];
      if (!bunruis
          .any((AwarenessCodeModel m) => m.code == model.karuteBunruiCode)) {
        continue;
      }
      
      rows.add(
        PlutoRow(
          cells: {
            'KaruteBunruiCode': PlutoCell(value: model.karuteBunruiCode),
            'CommonFlg': PlutoCell(value: model.commonFlg),
            'Title': PlutoCell(value: model.title),
            'KizukiTemplate': PlutoCell(value: model.kizukiTemplate),
            'KinyuKyoinName': PlutoCell(
              value: model.kinyuKyoinId == 0
                  ? 'システム管理者'
                  : model.kinyuKyoinName ?? '',
            ),
            'ModifiedDateTime': PlutoCell(value: model.modifiedDateTime),
            'id': PlutoCell(value: model.id),
          },
        ),
      );
    }
    return rows;
  }

  List<PlutoColumn> getColumns(List<KizukiTemplateModel> list) {
    return [
      // 1 分類
      PlutoColumn(
        title: '分類',
        field: 'KaruteBunruiCode',
        width: 60,
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
          final cd = rendererContext.row.cells['KaruteBunruiCode']!.value;
          var codeName = '';
          try {
            final code = bunruis.firstWhere((element) => element.code == cd);
            codeName = code.name!;
          } catch (e) {
            // ignore
          }
          return Center(child: Text(codeName));
        },
      ),
      // ２．学校共通
      PlutoColumn(
        title: '種別',
        field: 'CommonFlg',
        width: 60,
        readOnly: true,
        enableContextMenu: false,
        type: PlutoColumnType.text(),
        textAlign: PlutoColumnTextAlign.center,
        titleTextAlign: PlutoColumnTextAlign.center,
        enableColumnDrag: false,
        enableDropToResize: false,
        enableSorting: false,
        renderer: (rendererContext) {
          final b = rendererContext.row.cells['CommonFlg']!.value;
          var name = '';
          try {
            name = b == true ? '共通' : '個人';
          } catch (e) {
            // ignore
          }
          return Center(child: Text(name));
        },
      ),
      // ３．テンプレート名
      PlutoColumn(
        title: 'テンプレート名',
        field: 'Title',
        width: 250,
        readOnly: true,
        enableContextMenu: false,
        type: PlutoColumnType.text(),
        textAlign: PlutoColumnTextAlign.left,
        titleTextAlign: PlutoColumnTextAlign.center,
        enableColumnDrag: false,
        enableDropToResize: false,
        enableSorting: false,
        renderer: (rendererContext) {
          final title = rendererContext.row.cells['Title']!.value;
          final id = rendererContext.row.cells['id']!.value as int;
          final model = list.firstWhere((element) => element.id == id);

          return GestureDetector(
            onTap: () async {
              final result = await showDialog<String>(
                barrierDismissible: false,
                context: context,
                builder: (context) {
                  return PopScope(
                    child: KizukiTemplateDialog(
                      model: model,
                      action: ScreenAction.edit,
                    ),
                  );
                },
              );

              if (result != null) {
                ref.refresh(kizukiTemplateProvider);
              }
            },
            child: Text(
              '$title',
              style: const TextStyle(
                decoration: TextDecoration.underline,
              ),
            ),
          );
        },
      ),
      // 4.気づき
      PlutoColumn(
        title: '気づき',
        field: 'KizukiTemplate',
        width: 780,
        readOnly: true,
        enableContextMenu: false,
        type: PlutoColumnType.text(),
        textAlign: PlutoColumnTextAlign.left,
        titleTextAlign: PlutoColumnTextAlign.center,
        enableColumnDrag: false,
        enableDropToResize: false,
        enableSorting: false,
        renderer: (rendererContext) {
          final kizukiTemplate =
              rendererContext.row.cells['KizukiTemplate']!.value;

          return Text(
            '$kizukiTemplate',
            maxLines: 2,
            overflow:  TextOverflow.ellipsis,
          );
        },
      ),
      // 5.登録者
      PlutoColumn(
        title: '登録者',
        field: 'KinyuKyoinName',
        width: 150,
        readOnly: true,
        enableContextMenu: false,
        type: PlutoColumnType.text(),
        textAlign: PlutoColumnTextAlign.center,
        titleTextAlign: PlutoColumnTextAlign.center,
        enableColumnDrag: false,
        enableDropToResize: false,
        enableSorting: false,
      ),
      // 6.登録日付
      PlutoColumn(
        title: '登録日付',
        field: 'ModifiedDateTime',
        width: 100,
        readOnly: true,
        enableContextMenu: false,
        type: PlutoColumnType.text(),
        textAlign: PlutoColumnTextAlign.center,
        titleTextAlign: PlutoColumnTextAlign.center,
        enableColumnDrag: false,
        enableDropToResize: false,
        enableSorting: false,
        renderer: (rendererContext) {
          var strDate =
              rendererContext.row.cells['ModifiedDateTime']!.value.toString();

          try {
            final date = DateTime.parse(strDate);
            strDate = DateUtil.getJapaneseDate(date);
          } catch (e) {
            // ignore
          }
          // 行番号を表示する
          return Center(child: Text(strDate));
        },
      ),
      // 非表示カラム
      PlutoColumn(
        title: 'id',
        field: 'id',
        width: 0,
        readOnly: true,
        hide: true,
        type: PlutoColumnType.number(),
      ),
    ];
  }
}
