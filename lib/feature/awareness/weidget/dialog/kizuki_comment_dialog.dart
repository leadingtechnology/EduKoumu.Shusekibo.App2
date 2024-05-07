import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kyoumutechou/feature/awareness/model/awareness_common.dart';
import 'package:kyoumutechou/feature/awareness/model/kizuki_comment_model.dart';
import 'package:kyoumutechou/feature/awareness/provider/awareness_meibo_provider.dart';
import 'package:kyoumutechou/feature/awareness/provider/kizuki_comment_provider.dart';
import 'package:kyoumutechou/feature/common/widget/save3_button_widget.dart';
import 'package:kyoumutechou/feature/common/widget/toast_helper.dart';
import 'package:kyoumutechou/helpers/theme/app_theme.dart';
import 'package:kyoumutechou/helpers/widgets/my_spacing.dart';

// ignore: must_be_immutable
class KizukiCommentDialog extends ConsumerStatefulWidget {
  const KizukiCommentDialog({
    required this.kizukiId,
    required this.originCommentId,
    this.comment = const KizukiCommentModel(),
    super.key,
    this.opt = AwarenessOperationItem.add,
  });

  final int kizukiId;
  final int originCommentId;
  final KizukiCommentModel comment;
  final AwarenessOperationItem opt;

  @override
  ConsumerState<KizukiCommentDialog> createState() =>
      _KizukiCommentDialogState();
}

class _KizukiCommentDialogState extends ConsumerState<KizukiCommentDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final commentController = TextEditingController();
  bool juyo = false;

  @override
  void initState() {
    super.initState();
    juyo = widget.comment.juyoFlg ?? false;

    commentController.text = widget.comment.commentbun ?? '';
  }

  @override
  Widget build(BuildContext context) {

    return Form(
      key: _formKey,
      child: SimpleDialog(
        surfaceTintColor: theme.colorScheme.surface,
        children: [
          SizedBox(
            width: 660,
            child: Column(
              children: [
                // 1. title
                const Text(
                  '　コメントの編集',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                MySpacing.height(8),
                Container(
                  padding: const EdgeInsets.fromLTRB(0, 4, 4, 4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 1.登録者情報
                      Row(
                        children: [
                          Container(
                            width: 60,
                            alignment: Alignment.centerRight,
                            child: const Icon(Icons.account_circle_outlined,
                                  color: Colors.blue, size: 24,),
                          ),
                          MySpacing.width(12),
                          Container(
                            alignment: Alignment.centerRight,
                            child: Text(
                              '${Hive.box<String>('shusekibo').get('user')}',
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                      MySpacing.height(8),

                      // 2. コメント情報
                      Row(
                        children: [
                          MySpacing.width(60),
                          SizedBox(
                            width: 540,
                            height: 330,
                            child: Stack(
                              children: [
                                // 2.1 コメント情報
                                Positioned(
                                  child: TextFormField(
                                    controller: commentController,
                                    keyboardType: TextInputType.multiline,
                                    maxLength: 300,
                                    maxLines: 11,
                                    decoration: InputDecoration(
                                      border: const OutlineInputBorder(),
                                      hintText: widget.originCommentId > 0
                                          ? 'コメントに返信する'
                                          : '気づきにコメントする', 
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return '';
                                      }
                                      return null;
                                    },
                                  ),
                                ),

                                // 2.2 重要フラグ
                                Positioned(
                                  top: 290,
                                  child: SizedBox(
                                    width: 240,
                                    child: CheckboxListTile(
                                      title: const Text(
                                        '重要',
                                        style: TextStyle(fontSize: 14),
                                      ),
                                      value: juyo,
                                      controlAffinity:
                                          ListTileControlAffinity.leading,
                                      onChanged: (bool? value) {
                                        setState(() {
                                          juyo = value ?? false;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      MySpacing.height(8),
                    ],
                  ),
                ),

                Container(
                  padding: MySpacing.fromLTRB(16, 0, 16, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton.icon(
                        icon: const Icon(Icons.close),
                        label: const Text(
                          '閉じる',
                          style: TextStyle(color: Colors.black),
                        ),
                        onPressed: () {
                          ref.read(awarenessStudentAddProvider.notifier).state =
                              [];
                          Navigator.of(context).pop();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            //side: const BorderSide(),
                          ),
                        ),
                      ),
                      Expanded(child: Container()),
                      Save3ButtonWidget(
                        label: '　送信',
                        onPressed: () async {
                          if (_formKey.currentState!.validate() == false) {
                            ToastHelper.showToast(context, '　必須項目を入力してください　');
                            return;
                          }

                          _formKey.currentState!.save();

                          try {
                            if (widget.opt == AwarenessOperationItem.edit) {
                              await ref
                                  .read(kizukiCommentListProvider.notifier)
                                  .patch(
                                    widget.comment.id ?? 0,
                                    commentController.text,
                                    juyo,
                                    widget.comment.timeStamp ?? '',
                                  );
                            }

                            if (widget.opt == AwarenessOperationItem.add) {
                              await ref
                                  .read(kizukiCommentListProvider.notifier)
                                  .post(
                                    widget.kizukiId ,
                                    widget.originCommentId,
                                    commentController.text,
                                    juyo,
                                  );
                            }
                          } catch (e) {
                            ToastHelper.showToast(context, '　エラーが発生しました　');
                            return;
                          }

                          ToastHelper.showToast(context, '　保存しました　');
                          Navigator.of(context).pop();
                          return;

                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          //
        ],
      ),
    );
  }
}
