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
import 'package:kyoumutechou/feature/common/widget/toast_helper.dart';
import 'package:kyoumutechou/feature/home/provider/home_provider.dart';
import 'package:kyoumutechou/feature/kizuki/model/kizuki_template_model.dart';
import 'package:kyoumutechou/feature/kizuki/widget/kizuki_template_dialog.dart';
import 'package:kyoumutechou/helpers/widgets/my_spacing.dart';
import 'package:kyoumutechou/shared/http/app_exception.dart';
import 'package:kyoumutechou/shared/util/date_util.dart';

class AwarenessListPage extends ConsumerWidget {
  const AwarenessListPage(
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
        const Expanded(
          child: AwarenessListView(),
        ),

        // footer
      ],
    );
  }
}

class AwarenessListView extends ConsumerStatefulWidget {
  const AwarenessListView({super.key});

  @override
  ConsumerState<AwarenessListView> createState() => _AwarenessListViewState();
}

class _AwarenessListViewState extends ConsumerState<AwarenessListView> {
  final List<String> opeItem = [
    'edit',
    '',
    'copy',
    '',
    'delete',
    '',
    'favorite',
    '',
    'template',
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
  void initState() {
    super.initState();

    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   final list = Boxes.getAwarenessKizukiModelBox().values.toList();
    //   if (list.isEmpty) {
    //     ToastHelper.showToast(context, '　該当する期間に気づきは登録されていません　');
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
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

            if (kizuki.isEmpty) {
              return Container();
            }

            kizuki.sort((a, b) {
              // 登録日の降順でソート
              final dateCompare = b.torokuDate!.compareTo(a.torokuDate!);
              if (dateCompare != 0) {
                return dateCompare;
              }

              // studentIdの昇順でソート
              return a.studentId!.compareTo(b.studentId!);
            });

            return ListView.separated(
              padding: const EdgeInsets.only(top: 20),
              itemBuilder: (context, index) => ListTile(
                leading: ClipOval(
                  child: Image.network(
                    '$_baseUrl${kizuki[index].photoUrl}',
                    headers: {'Authorization': 'Bearer $accessToken'},
                  ),
                ),
                title: Text('${kizuki[index].studentName}'),
                isThreeLine: true,
                subtitle: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(child: Text('${kizuki[index].naiyou}'),),],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                            '${kizuki[index].tourokusyaId == 0 ? 'システム管理者' : kizuki[index].tourokusyaName}'),
                        MySpacing.width(10),
                        const SizedBox(
                          width: 10,
                          child: Text('|'),
                        ),
                        Text(
                          DateUtil.getJapaneseDate(
                            DateTime.parse(kizuki[index].torokuDate ?? ''),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
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
          },
        );
      },
    );
  }
}

class PopUpMenu extends ConsumerWidget {
  PopUpMenu({
    required this.kizuki,
    super.key,
  });

  final AwarenessKizukiModel kizuki;
  final TextStyle style = const TextStyle(fontSize: 14);
  final box = Boxes.getBox();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PopupMenuButton<AwarenessOperationItem>(
      onSelected: (AwarenessOperationItem opt) async {
        await _handlePressActionButton(context, kizuki, opt, ref);
      },
      tooltip: 'メニュー表示',
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
                  child: FaIcon(FontAwesomeIcons.trashCan, size: 18),
                ),
              ),
              MySpacing.width(8),
              Text('削除', style: style),
            ],
          ),
        ),
        const PopupMenuDivider(),
        PopupMenuItem<AwarenessOperationItem>(
          value: AwarenessOperationItem.favorite,
          child: Row(
            children: [
              const SizedBox(
                width: 24,
                child: Center(
                  child: FaIcon(FontAwesomeIcons.star, size: 18),
                ),
              ),
              MySpacing.width(8),
              Text('「テンプレート文（個人）」登録', style: style),
            ],
          ),
        ),
        const PopupMenuDivider(),
        PopupMenuItem<AwarenessOperationItem>(
          value: AwarenessOperationItem.template,
          child: Row(
            children: [
              const SizedBox(
                width: 24,
                child: Center(
                  child: FaIcon(FontAwesomeIcons.fileLines, size: 18),
                ),
              ),
              MySpacing.width(8),
              const Text(
                '「テンプレート文（学校共通）」登録', 
                style: TextStyle(fontSize: 13),
              ),
            ],
          ),
        ),
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
    ref.read(awarenessJuyoProvider.notifier).state = kizuki.juyoFlg ?? false;
    ref.read(awarenessIdProvider.notifier).state = kizuki.id ?? 0;

    await DialogUtil.show(
      context: context,
      builder: (BuildContext context) {
        return AwarenessRegistDialog(kizuki: kizuki, opt: opt);
      },
    );
  }

  if (opt == AwarenessOperationItem.delete) {

    // ダイアログを表示してユーザーの選択を待つ
    // final result = await showDialog<bool>(
    //   context: context,
    //   builder: (context) => AlertDialog(
    //     title: const Text('確認'),
    //     content: MyText('削除してもよろしいですか？', fontSize: 16),
    //     actions: <Widget>[
    //       TextButton(
    //         onPressed: () => Navigator.of(context).pop(false), // falseを返す
    //         child: const Text('キャンセル'),
    //       ),
    //       TextButton(
    //         onPressed: () => Navigator.of(context).pop(true), // trueを返す
    //         child: const Text('OK'),
    //       ),
    //     ],
    //   ),
    // );

    // if(result == null || !result) return; // キャンセルされた場合は何もしない

    ToastHelper.showToast(context, '　削除しました　');
    await ref.read(awarenessKizukiListProvider.notifier).delete(kizuki);
    // ignore: use_build_context_synchronously
    
    return;
  }

  if (opt == AwarenessOperationItem.favorite ||
      opt == AwarenessOperationItem.template) 
  {
    final commonFlg = opt == AwarenessOperationItem.template;

    final model = KizukiTemplateModel(
      karuteBunruiCode: kizuki.bunruiCode,
      commonFlg: commonFlg,
      title: '',
      kizukiTemplate: kizuki.naiyou,
    );

    final dialogContext = context;

    await DialogUtil.show(
      context: dialogContext,
      builder: (context) {
        return KizukiTemplateDialog(
          model: model,
          action: ScreenAction.copy,
        );
      },
    );
  }

  return;
}
