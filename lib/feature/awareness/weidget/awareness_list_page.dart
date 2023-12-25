import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kyoumutechou/feature/awareness/model/awareness_common.dart';
import 'package:kyoumutechou/feature/awareness/model/awareness_kizuki_model.dart';
import 'package:kyoumutechou/feature/awareness/provider/awareness_kizuki_provider.dart';
import 'package:kyoumutechou/feature/awareness/provider/awareness_meibo_provider.dart';
import 'package:kyoumutechou/feature/awareness/provider/awareness_photo_provider.dart';
import 'package:kyoumutechou/feature/awareness/weidget/dialog/awareness_regist_dialog.dart';
import 'package:kyoumutechou/feature/boxes.dart';
import 'package:kyoumutechou/feature/common/widget/dialog_util.dart';
import 'package:kyoumutechou/feature/common/widget/search_bar_widget.dart';
import 'package:kyoumutechou/helpers/widgets/my_spacing.dart';
import 'package:kyoumutechou/shared/http/app_exception.dart';
import 'package:kyoumutechou/shared/util/date_util.dart';

class AwarenessListPage extends ConsumerWidget {
  AwarenessListPage(
    this._scaffoldKey, {
    super.key,
    this.screenTitle = '',
  });

  // draw key
  final GlobalKey<ScaffoldState> _scaffoldKey;

  final String screenTitle;
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SearchBarWidget(_scaffoldKey, isPeriod: true),
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
  AwarenessListView({super.key});

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
        return Text(e.toString());
      },
      loaded: () {
        return ValueListenableBuilder(
            valueListenable: Boxes.getAwarenessKizukiModelBox().listenable(),
            builder: (context, Box<AwarenessKizukiModel> box, _) {
              final kizuki = Boxes.getAwarenessKizukiModelBox().values.toList();
              
              kizuki.sort(
                (a, b) => a.studentId ?? 0.compareTo(b.studentId ?? 0),
              );

              return ListView.separated(
                padding: const EdgeInsets.only(top: 20),
                itemBuilder: (context, index) => ListTile(
                  leading: ClipOval(child: Image.network(
                    '${_baseUrl}api/images?seitoseq=${kizuki[index].seitoSeq}',
                    headers: {'Authorization': 'Bearer $accessToken'},
                  ),),
                  
                  title: Text('${kizuki[index].studentName}'),
                  isThreeLine: true,
                  subtitle: Column(children: [
                                      Row(
                    children: [Text('${kizuki[index].naiyou}')],),
                                      Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text('${kizuki[index].tourokusyaName}'),
                      MySpacing.width(10),
                      const SizedBox(
                        width: 10,
                        child: Text('|'),
                      ),
                      Text(
                          DateUtil.getJapaneseDate(
                            DateTime.parse(kizuki[index].torokuDate ?? ''),
                          ),),
                    ],),
                                    ],),
                  trailing: PopUpMenu(kizuki: kizuki[index]),
                ),
                itemCount: kizuki.length,
                separatorBuilder: (context, index) {
                  return const Divider(
                    height: 0.5,
                    indent: 75,
                    endIndent: 20,
                  );
                },
              );
            },);
      },
    );
  }
}

class PopUpMenu extends ConsumerWidget {
  PopUpMenu({
    required this.kizuki, super.key,
  });

  final AwarenessKizukiModel kizuki;
  final TextStyle style = const TextStyle(fontSize: 14); 
  final box = Boxes.getBox();

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
          enabled:
              box.get('kihonId').toString() == kizuki.tourokusyaId.toString(),
          child: Row(
            children: [
              const SizedBox(
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
              const SizedBox(
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
          enabled:
              box.get('kihonId').toString() == kizuki.tourokusyaId.toString(),
          child: Row(
            children: [
              const SizedBox(
                  width: 24,
                  child: Center(
                      child: FaIcon(FontAwesomeIcons.trashCan, size: 18),),),
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
    WidgetRef ref,
) async {
  //if (opt == AwarenessOperationItem.edit)
  //  await ref.read(awarenessMeiboListProvider.notifier).updateById(id);

  if (opt == AwarenessOperationItem.copy || 
      opt == AwarenessOperationItem.edit) {
    
    ref.read(awarenessBunruiProvider.notifier).state = '${kizuki.bunruiCode}';
    ref.read(awarenessJuyoProvider.notifier).state = kizuki.juyoFlg ?? false;
    ref.read(awarenessIdProvider.notifier).state = kizuki.id??0;


    await DialogUtil.show(
      context: context,
      builder: (BuildContext context) {
        return AwarenessRegistDialog(kizuki:kizuki, opt: opt);
      },
    );
  }

  if (opt == AwarenessOperationItem.delete) {
    await ref.read(awarenessKizukiListProvider.notifier).delete(kizuki);
    return;
  }

  if (opt == AwarenessOperationItem.favorite) return;
  if (opt == AwarenessOperationItem.template) return;

  return;
}
