import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kyoumutechou/feature/awareness/model/awareness_common.dart';
import 'package:kyoumutechou/feature/awareness/model/awareness_kizuki_model.dart';
import 'package:kyoumutechou/feature/awareness/provider/awareness_kizuki_provider.dart';
import 'package:kyoumutechou/feature/awareness/weidget/dialog/awareness_regist_dialog.dart';
import 'package:kyoumutechou/feature/boxes.dart';
import 'package:kyoumutechou/feature/common/widget/dialog_util.dart';
import 'package:kyoumutechou/helpers/widgets/my_spacing.dart';

import '../../../shared/http/app_exception.dart';
import '../../../shared/util/date_util.dart';

class AwarenessListPage extends ConsumerWidget {
  const AwarenessListPage({
    super.key,
    this.screenTitle = '',
  });

  final String screenTitle;
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // search bar
        MySpacing.height(8),
        //AwarenessSearchWidget(scaffoldKey: scaffoldKey),
        //AwarenessListSearchWidget(),
        //AwarenessListSearchWidget(scaffoldKey: scaffoldKey),

        // screen
        MySpacing.height(8),
        Expanded(
          child: AwarenessListView(),
        ),

        // footer
      ],
    );
  }
}

class AwarenessListView extends ConsumerWidget {
  AwarenessListView({Key? key}) : super(key: key);

  final List<String> opeItem = [
    'edit',
    '',
    'copy',
    '',
    'delete',
    '',
    'favorite',
    '',
    'template'
  ];
  final Map<String, IconData> opeIcon = {
    'edit': FontAwesomeIcons.pen,
    'copy': FontAwesomeIcons.copy,
    'delete': FontAwesomeIcons.trashCan,
    'favorite': FontAwesomeIcons.star,
    'template': FontAwesomeIcons.fileLines,
  };

  final _baseUrl = dotenv.env['BASE_URL']!;
  String accessToken = Hive.box<String>('shusekibo').get('token').toString();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(awarenessKizukiListProvider);

    // final String ids = ref.watch(awarenessListIdProvider);
    // final String txt = ref.watch(awarenessListTextProvider);
    // final bool juyo = ref.watch(awarenessListJuyoProvider);

    return state.when(
      loading: () {
        return Container();
      },
      error: (AppException e) {
        return Container(
          child: Text('${e.toString()}'),
        );
      },
      loaded: () {
        return ValueListenableBuilder(
            valueListenable: Boxes.getAwarenessKizukiModelBox().listenable(),
            builder: (context, Box<AwarenessKizukiModel> box, _) {
              List<AwarenessKizukiModel> kizuki =
                  Boxes.getAwarenessKizukiModelBox().values.toList();
              kizuki.sort((a, b) => a.studentId ?? 0.compareTo(b.studentId ?? 0));

              return ListView.separated(
                padding: EdgeInsets.only(top: 20.0),
                itemBuilder: (context, index) => ListTile(
                  leading: ClipOval(child: Image.network(
                    '${_baseUrl}api/images?seitoseq=${kizuki[index].seitoSeq}',
                    headers: {"Authorization": "Bearer " + accessToken},
                  )),
                  
                  title: Text('${kizuki[index].studentName}'),
                  isThreeLine: true,
                  subtitle: Container(
                      child: Column(children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [Text('${kizuki[index].naiyou}')]),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text('${kizuki[index].tourokusyaName}'),
                          MySpacing.width(10),
                          SizedBox(
                            width: 10,
                            child: Text('|'),
                          ),
                          Text(
                              '${DateUtil.getJapaneseDate(DateTime.parse(kizuki[index].torokuDate ?? ''))}'),
                        ]),
                  ])),
                  selected: false,
                  trailing: popUpMenu(kizuki: kizuki[index]),
                ),
                itemCount: kizuki.length,
                separatorBuilder: (context, index) {
                  return Divider(
                    height: 0.5,
                    indent: 75,
                    endIndent: 20,
                  );
                },
              );
            });
      },
    );
  }
}

class popUpMenu extends ConsumerWidget {
  popUpMenu({
    Key? key,
    required this.kizuki,
  }) : super(key: key);

  final AwarenessKizukiModel kizuki;
  final TextStyle style = TextStyle(fontSize: 14); 

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PopupMenuButton<AwarenessOperationItem>(
      onSelected: (AwarenessOperationItem opt) async{
        await _handlePressActionButton(context, kizuki, opt, ref);
      },
      itemBuilder: (BuildContext context) =>
          <PopupMenuEntry<AwarenessOperationItem>>[
        PopupMenuItem<AwarenessOperationItem>(
          value: AwarenessOperationItem.edit,
          child: Row(
            children: [
              SizedBox(
                  width: 24,
                  child: Center(child: FaIcon(FontAwesomeIcons.pen, size: 18))),
              MySpacing.width(8),
              Text('気づきの編集', style: style),
            ],
          ),
        ),
        const PopupMenuDivider(),
        PopupMenuItem<AwarenessOperationItem>(
          value: AwarenessOperationItem.copy,
          child: Row(
            children: [
              SizedBox(
                  width: 24,
                  child:
                      Center(child: FaIcon(FontAwesomeIcons.copy, size: 18))),
              MySpacing.width(8),
              Text('気づきのコピー', style: style),
            ],
          ),
        ),
        const PopupMenuDivider(),
        PopupMenuItem<AwarenessOperationItem>(
          value: AwarenessOperationItem.delete,
          child: Row(
            children: [
              SizedBox(
                  width: 24,
                  child: Center(
                      child: FaIcon(FontAwesomeIcons.trashCan, size: 18))),
              MySpacing.width(8),
              Text('削除', style: style),
            ],
          ),
        ),
        //const PopupMenuDivider(),
        // PopupMenuItem<AwarenessOperationItem>(
        //   value: AwarenessOperationItem.favorite,
        //   child: Row(
        //     children: [
        //       SizedBox(
        //           width: 24,
        //           child: Center(
        //               child: FaIcon(FontAwesomeIcons.star, size: 18))),
        //       Spacing.width(8),
        //       Text('${S.of(context).awareness_menu_favorite}', style: style),
        //     ],
        //   ),
        // ),
        // const PopupMenuDivider(),
        // PopupMenuItem<AwarenessOperationItem>(
        //   value: AwarenessOperationItem.template,
        //   child: Row(
        //     children: [
        //       SizedBox(
        //           width: 24,
        //           child: Center(
        //               child: FaIcon(FontAwesomeIcons.fileLines, size: 18))),
        //       Spacing.width(8),
        //       Text('${S.of(context).awareness_menu_template}', style: TextStyle(fontSize: 13)),
        //     ],
        //   ),
        // ),
      ],
    );
  }
}

Future<void> _handlePressActionButton(
    BuildContext context,
    AwarenessKizukiModel kizuki,
    AwarenessOperationItem opt,
    WidgetRef ref
) async {
  //if (opt == AwarenessOperationItem.edit)
  //  await ref.read(awarenessMeiboListProvider.notifier).updateById(id);

  if (opt == AwarenessOperationItem.copy || opt == AwarenessOperationItem.edit)
    await DialogUtil.show(
      context: context,
      builder: (BuildContext context) {
        return AwarenessRegistDialog(kizuki:kizuki, opt: opt);
      },
    );

  if (opt == AwarenessOperationItem.delete) {
    await ref.read(awarenessKizukiListProvider.notifier).delete(kizuki);
    return;
  }

  if (opt == AwarenessOperationItem.favorite) return null;
  if (opt == AwarenessOperationItem.template) return null;

  return null;
}
