import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:kyoumutechou/feature/awareness/provider/awareness_code_provider.dart';
import 'package:kyoumutechou/feature/common/widget/delete_button_widget.dart';
import 'package:kyoumutechou/feature/common/widget/radio_group_form_field.dart';
import 'package:kyoumutechou/feature/common/widget/save2_button_widget.dart';
import 'package:kyoumutechou/feature/common/widget/toast_helper.dart';
import 'package:kyoumutechou/feature/home/provider/home_provider.dart';
import 'package:kyoumutechou/feature/kizuki/model/kizuki_template_model.dart';
import 'package:kyoumutechou/feature/kizuki/provider/kizuki_template_provider.dart';
import 'package:kyoumutechou/helpers/theme/app_theme.dart';
import 'package:kyoumutechou/helpers/widgets/my_spacing.dart';

// ignore: must_be_immutable
class KizukiTemplateDialog extends ConsumerWidget {
  KizukiTemplateDialog({
    this.model = const KizukiTemplateModel(),
    this.action = ScreenAction.add,
    super.key,
  });

  final ScreenAction? action;
  final KizukiTemplateModel model;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final kihonId = Hive.box<String>('shusekibo').get('kihonId');

  static Map<String, String> radioMap = {
    '1': '学校共通',
    '0': '個人',
  };

  final ctrTitle = TextEditingController();
  final ctrKizuki = TextEditingController();
  String _bunruiCd = '';
  String _syubetu = '';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bunruiMap =
        ref.read(awarenessCodeListProvider.notifier).getBunruiList();

    if (action == ScreenAction.add) {
      _bunruiCd = bunruiMap.keys.first;
      _syubetu = radioMap.keys.first;
    } else {
      _bunruiCd = model.karuteBunruiCode ?? '';
      _syubetu = model.commonFlg != null && model.commonFlg! ? '1' : '0';
      ctrTitle.text = '${model.title}';
      ctrKizuki.text = '${model.kizukiTemplate}';
    }

    return Form(
      key: _formKey,
      child: SimpleDialog(
        surfaceTintColor: theme.colorScheme.surface,
        children: [
          SizedBox(
            width: 900,
            child: Column(
              children: [
                const SizedBox(height: 4),
                // 1. title
                const Text(
                  '　気づきテンプレート文の編集',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),

                // 2. body
                const Padding(
                  padding: EdgeInsets.fromLTRB(8, 8, 8, 4),
                  child: Divider(color: Colors.grey),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(8, 4, 16, 4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 2.1 タイトル
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 100,
                            height: 36,
                            alignment: Alignment.centerRight,
                            child: const Text(
                              'テンプレート名',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          MySpacing.width(16),
                          Expanded(
                            child: TextFormField(
                              controller: ctrTitle,
                              keyboardType: TextInputType.multiline,
                              maxLength: 20,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return '';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),

                      Row(
                        children: [
                          Container(
                            width: 100,
                            alignment: Alignment.centerRight,
                            child: const Text(
                              '分類',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          MySpacing.width(12),
                          Expanded(
                            child: RadioGroupFormField(
                              radioMap: bunruiMap,
                              initialValue: _bunruiCd,
                              onSaved: (value) {
                                _bunruiCd = '$value';
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return '';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),

                      // 2.3 種別
                      Row(
                        children: [
                          Container(
                            width: 100,
                            alignment: Alignment.centerRight,
                            child: const Text(
                              '種別',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          MySpacing.width(12),
                          Expanded(
                            child: RadioGroupFormField(
                              radioMap: radioMap,
                              initialValue: _syubetu,
                              onSaved: (value) {
                                _syubetu = '$value';
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return '';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),

                      // 2.4 気づきテンプレート
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 100,
                            alignment: Alignment.centerRight,
                            child: const Text(
                              '気づき',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          MySpacing.width(12),
                          Expanded(
                            child: TextFormField(
                              controller: ctrKizuki,
                              keyboardType: TextInputType.multiline,
                              maxLength: 300,
                              maxLines: 9,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return '';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // 3.buttom button
                const Padding(
                  padding: EdgeInsets.all(8),
                  child: Divider(color: Colors.grey),
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
                          Navigator.of(context).pop('0');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                            //side: const BorderSide(),
                          ),
                        ),
                      ),
                      Expanded(child: Container()),
                      if (action == ScreenAction.edit ||
                          action == ScreenAction.detail) ...[
                        DeleteButtonWidget(
                          onPressed: model.kinyuKyoinId == null ||
                                  kihonId != model.kinyuKyoinId.toString()
                              ? null
                              : () async {
                                  await ref
                                      .read(kizukiTemplateProvider.notifier)
                                      .delete(model.id!);

                                  ToastHelper.showToast(context, '　削除しました　');
                                  Navigator.of(context).pop('1');
                                },
                          label: '削除',
                        ),
                        MySpacing.width(16),
                      ],
                      Save2ButtonWidget(
                        label: '保存',
                        onPressed: action != ScreenAction.add &&
                                action !=
                                    ScreenAction.copy && 
                                (model.kinyuKyoinId == null ||
                                    kihonId != model.kinyuKyoinId.toString())
                            ? null
                            : () async {
                                if (_formKey.currentState!.validate() ==
                                    false) {
                                  ToastHelper.showToast(
                                      context, '　必須項目を入力してください　');
                                  return;
                                }

                                _formKey.currentState!.save();

                                // 分類コードから分類名を取得
                                final bunrui = ref
                                    .read(awarenessCodeListProvider.notifier)
                                    .setCodeValue(
                                      code: _bunruiCd,
                                    );
                                switch (action) {
                                  case ScreenAction.add:
                                  case ScreenAction.copy:
                                    try{
                                      await ref
                                          .read(kizukiTemplateProvider.notifier)
                                          .save(
                                            kinyuKyoinId: '$kihonId',
                                            karuteSettingId: '${bunrui.id}',
                                            karuteShubetsuNaibuCode: '20',
                                            karuteBunruiCode: '${bunrui.code}',
                                            title: ctrTitle.text,
                                            kizukiTemplate: ctrKizuki.text,
                                            commonFlg: _syubetu,
                                          );
                                    }catch(e){
                                      //
                                    }
                                    
                                  case ScreenAction.edit:
                                    await ref
                                        .read(kizukiTemplateProvider.notifier)
                                        .patch(
                                          id: model.id!,
                                          kinyuKyoinId: '$kihonId',
                                          karuteSettingId: '${bunrui.id}',
                                          karuteShubetsuNaibuCode: '20',
                                          karuteBunruiCode: '${bunrui.code}',
                                          title: ctrTitle.text,
                                          kizukiTemplate: ctrKizuki.text,
                                          commonFlg: _syubetu,
                                        );
                                  default:
                                    break;
                                }

                                ToastHelper.showToast(context, '　保存しました　');

                                Navigator.of(context).pop();
                              },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
