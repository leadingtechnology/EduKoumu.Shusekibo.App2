import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kyoumutechou/feature/awareness/model/awareness_common.dart';
import 'package:kyoumutechou/feature/awareness/model/awareness_kizuki_model.dart';
import 'package:kyoumutechou/feature/awareness/model/kizuki_comment_model.dart';
import 'package:kyoumutechou/feature/awareness/provider/awareness_kizuki_provider.dart';
import 'package:kyoumutechou/feature/awareness/provider/awareness_meibo_provider.dart';
import 'package:kyoumutechou/feature/awareness/provider/awareness_photo_provider.dart';
import 'package:kyoumutechou/feature/awareness/provider/kizuki_comment_provider.dart';
import 'package:kyoumutechou/feature/awareness/weidget/dialog/awareness_regist_dialog.dart';
import 'package:kyoumutechou/feature/awareness/weidget/dialog/kizuki_comment_dialog.dart';
import 'package:kyoumutechou/feature/boxes.dart';
import 'package:kyoumutechou/feature/common/widget/dialog_util.dart';
import 'package:kyoumutechou/feature/common/widget/search_bar_widget.dart';
import 'package:kyoumutechou/feature/common/widget/toast_helper.dart';
import 'package:kyoumutechou/feature/home/provider/home_provider.dart';
import 'package:kyoumutechou/feature/kizuki/model/kizuki_template_model.dart';
import 'package:kyoumutechou/feature/kizuki/widget/kizuki_template_dialog.dart';
import 'package:kyoumutechou/helpers/theme/app_theme.dart';
import 'package:kyoumutechou/helpers/widgets/my_spacing.dart';
import 'package:kyoumutechou/helpers/widgets/my_text.dart';
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

  late int targetIndex;
  List<bool> isOpen = [];

  final userId = Boxes.getBox().get('userId').toString();

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

            // isOpenを初期化する
            if (isOpen.length != kizuki.length) {
              isOpen = List.generate(kizuki.length, (index) => false);
            }

            //
            final studentId = ref.watch(studentIdProvider);

            return ListView.separated(
              padding: const EdgeInsets.only(top: 20),
              itemBuilder: (context, index) => ColoredBox(
                color: studentId == kizuki[index].studentId
                    ? theme.colorScheme.secondaryContainer
                    : theme.colorScheme.background,
                child: Column(
                  children: [
                    KizukiWidget(kizuki, index),
                    if (isOpen[index] == true &&
                        kizuki[index].commentCount != 0)
                      Padding(
                        padding: const EdgeInsets.only(left: 50),
                        child: KizukiCommentWidget(kizuki, index),
                      ),
                  ],
                ),
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

  ListTile KizukiWidget(List<AwarenessKizukiModel> kizuki, int index) {
    return ListTile(
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
              Expanded(
                child: Text('${kizuki[index].naiyou}'),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextButton(
                onPressed: kizuki[index].commentCount == 0
                    ? null
                    : () {
                        setState(() {
                          isOpen[index] = !isOpen[index];
                        });
                      },
                style: ButtonStyle(
                  fixedSize: MaterialStateProperty.all<Size>(
                    const Size(160, 15),
                  ),
                ),
                child: Text('　コメント確認(${kizuki[index].commentCount ?? 0})　'),
              ),
              MySpacing.width(10),
              Container(
                height: 32,
                alignment: Alignment.center,
                width: 10,
                child: const Text('|'),
              ),
              TextButton(
                onPressed: () async {
                  await DialogUtil.show(
                    context: context,
                    builder: (BuildContext context) {
                      return KizukiCommentDialog(
                        kizukiId: kizuki[index].id ?? 0,
                        originCommentId: 0,
                      );
                    },
                  );
                },
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                ), // 移除或减少内部填充
                child: const Text('　コメント追加　'),
              ),
              MySpacing.width(10),
              Container(
                height: 32,
                alignment: Alignment.centerLeft,
                width: 12,
                child: const Text('|'),
              ),
              Container(
                height: 32,
                alignment: Alignment.center,
                child: Text(
                  kizuki[index].tourokusyaId == 0
                      ? 'システム管理者'
                      : kizuki[index].tourokusyaName ?? ''.trim(),
                ),
              ),
              MySpacing.width(10),
              Container(
                height: 32,
                alignment: Alignment.centerLeft,
                width: 12,
                child: const Text('|'),
              ),
              Container(
                height: 32,
                alignment: Alignment.center,
                child: Text(
                  DateUtil.getJapaneseDate(
                    DateTime.parse(
                      kizuki[index].torokuDate ?? '',
                    ),
                  ).trim(),
                ),
              ),
            ],
          ),
        ],
      ),
      trailing: PopUpMenu(kizuki: kizuki[index]),
    );
  }

  // ソートされたコメントリストを返す
  List<KizukiCommentModel> sortComments(
      List<KizukiCommentModel> comments, 
      int pid,
      int levelId,
      String oyaCommentTorokuUserName,
  ) {
    
    // pidに一致するコメントを取得
    final list = comments
        .where(
          (c) =>
              pid == 0 &&
                  (c.originCommentId == 0 || c.originCommentId == null) ||
              (pid != 0 && c.originCommentId == pid),
        )
        .toList();
    // ソートする
    if (list.isEmpty) {
      return [];
    }
    list.sort((a, b) => a.id!.compareTo(b.id!));  
    
    final commandList = <KizukiCommentModel>[];
    for (final comment in list) {
      final subComments = sortComments(
        comments, 
        comment.id ?? 0, 
        levelId + 1,
        comment.commentTorokuUserName ?? '',
      );
      final hasChildren = subComments.isNotEmpty;
      commandList..add(
        KizukiCommentModel(
          id: comment.id,
          kizukiId: comment.kizukiId,
          originCommentId: comment.originCommentId ?? 0,
          commentTorokuUserId: comment.commentTorokuUserId,
          commentTorokuUserName: comment.commentTorokuUserName,
          commentTorokuDateTime: comment.commentTorokuDateTime,
          commentbun: comment.commentbun,
          hasAttachment: comment.hasAttachment,
          attachmentList: comment.attachmentList,
          juyoFlg: comment.juyoFlg,
          timeStamp: comment.timeStamp,
          levelId: levelId,
          hasChildren: hasChildren,
          oyaCommentTorokuUserName: oyaCommentTorokuUserName,
        ),
      )
      ..addAll(subComments);

    } 

    return commandList;
  }

  ListView KizukiCommentWidget(List<AwarenessKizukiModel> kizuki, int index) {
    // コメントリストを取得
    final list = kizuki[index].commentList ?? [];
    if (list.isEmpty) {
      return ListView();
    }

    final commentList = sortComments(list, 0, 0, ''); 

    // commentListもとにListViewを作成
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final comment = commentList[index];
        var isEditable = userId == comment.commentTorokuUserId.toString();

        if (comment.hasChildren != null && comment.hasChildren == true) {
          isEditable = false;
        }

        var userName = comment.commentTorokuUserName ?? '';
        if (comment.commentTorokuUserId == 0) {
          userName = 'システム管理者';
        } 

        var oyaUserName = comment.oyaCommentTorokuUserName ?? '';
        if (comment.commentTorokuUserId == 0) {
          oyaUserName = 'システム管理者';
        }

        final intDistince = comment.levelId! >= 1 ? 32.0 : 0.0; 

        return Padding(
          padding: EdgeInsets.only(left: intDistince),
          child: ListTile(
            title: Row(
              children: [
                const Icon(
                  Icons.account_circle_outlined,
                  color: Colors.blue,
                  size: 24,
                ),
                MySpacing.width(8),
                Text(userName),
                MySpacing.width(24),
                if (oyaUserName.trim().isNotEmpty) Text('$oyaUserNameに返信'),
                MySpacing.width(24),
                Text(
                  DateUtil.getJapaneseDateTime(
                    comment.commentTorokuDateTime!,
                  ),
                ),
              ],
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(left: 32),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(child: Text('${comment.commentbun}')),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () async {
                          await DialogUtil.show(
                            context: context,
                            builder: (BuildContext context) {
                              return KizukiCommentDialog(
                                kizukiId: comment.kizukiId ?? 0,
                                originCommentId: comment.id ?? 0,
                              );
                            },
                          );
                        },
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                        ),
                        child: const Text('返信'),
                      ),
                      MySpacing.width(10),
                      Container(
                        height: 32,
                        alignment: Alignment.center,
                        width: 10,
                        child: const Text('|'),
                      ),
                      TextButton(
                        onPressed: !isEditable 
                            ? null
                            : () async {
                                await DialogUtil.show(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return KizukiCommentDialog(
                                      kizukiId: comment.kizukiId ?? 0,
                                      originCommentId: comment.id ?? 0,
                                      comment: comment,
                                      opt: AwarenessOperationItem.edit,
                                    );
                                  },
                                );
                              },
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                        ),
                        child: const Text('編集'),
                      ),
                      MySpacing.width(10),
                      Container(
                        height: 32,
                        alignment: Alignment.centerLeft,
                        width: 12,
                        child: const Text('|'),
                      ),
                      TextButton(
                        onPressed: !isEditable 
                            ? null
                            : () async {
                                //ダイアログを表示してユーザーの選択を待つ
                                final result = await deleteDealog(
                                  context: context,
                                  title: 'コメントを削除しますか？',
                                  text1: '選択したコメントを削除すると、もとに戻せることが',
                                  text2: 'できません。',
                                );
          
                                // キャンセルされた場合は何もしない
                                if (result == null || !result) {
                                  return;
                                }
          
                                ToastHelper.showToast(context, '　削除しました　');
                                await ref
                                    .read(kizukiCommentListProvider.notifier)
                                    .delete(
                                      comment.id ?? 0,
                                      comment.timeStamp ?? '',
                                    );
                                
                              },
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                        ),
                        child: const Text('削除'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
      itemCount: commentList.length,
      separatorBuilder: (context, index) {
        return const Divider(
          height: 0.5,
          indent: 25,
          endIndent: 20,
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
                child: Center(
                  child: FaIcon(FontAwesomeIcons.pen, size: 18),
                ),
              ),
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
                child: Center(child: FaIcon(FontAwesomeIcons.copy, size: 18)),
              ),
              MySpacing.width(8),
              Text('気づきのコピー', style: style),
            ],
          ),
        ),
        const PopupMenuDivider(),
        PopupMenuItem<AwarenessOperationItem>(
          value: AwarenessOperationItem.delete,
          enabled:
              box.get('kihonId').toString() == kizuki.tourokusyaId.toString() &&
                  kizuki.commentCount == 0,
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
    //ダイアログを表示してユーザーの選択を待つ
    final result = await deleteDealog(
      context: context,
      title: '気づきを削除しますか？',
      text1: '選択した気づきを削除すると、もとに戻せることが',
      text2: 'できません。',
    );

    if (result == null || !result) return; // キャンセルされた場合は何もしない

    ToastHelper.showToast(context, '　削除しました　');
    await ref.read(awarenessKizukiListProvider.notifier).delete(kizuki);
    // ignore: use_build_context_synchronously

    return;
  }

  if (opt == AwarenessOperationItem.favorite ||
      opt == AwarenessOperationItem.template) {
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

Future<bool?> deleteDealog({
  required BuildContext context,
  String? title,
  String? text1,
  String? text2,
}) {
  return showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title ?? ''),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MySpacing.height(8),
          MyText.bodyLarge(text1 ?? ''),
          MyText.bodyLarge(text2 ?? ''),
          MySpacing.height(8),
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          style: TextButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
              side: const BorderSide(color: Colors.grey), // 加灰色边框
            ),
          ), // falseを返す
          child: const Text(' キャンセル '),
        ),
        MySpacing.width(198),
        TextButton(
          onPressed: () => Navigator.of(context).pop(true),
          style: TextButton.styleFrom(
            foregroundColor: Colors.red,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
              side: const BorderSide(color: Colors.red), // 加灰色边框
            ),
          ), // trueを返す
          child: const Text('　削除　'),
        ),
      ],
    ),
  );
}
