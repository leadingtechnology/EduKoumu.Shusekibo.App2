
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kyoumutechou/feature/awareness/model/awareness_common.dart';
import 'package:kyoumutechou/feature/awareness/model/awareness_kizuki_model.dart';
import 'package:kyoumutechou/feature/awareness/model/awareness_meibo_model.dart';
import 'package:kyoumutechou/feature/awareness/provider/awareness_kizuki_provider.dart';
import 'package:kyoumutechou/feature/awareness/provider/awareness_meibo_provider.dart';
import 'package:kyoumutechou/feature/awareness/weidget/dialog/awareness_bunrui.dart';
import 'package:kyoumutechou/feature/awareness/weidget/dialog/awareness_dialog_left_widget.dart';
import 'package:kyoumutechou/feature/awareness/weidget/dialog/awareness_dialog_middle_widget.dart';
import 'package:kyoumutechou/feature/awareness/weidget/dialog/awareness_dialog_right_widget.dart';
import 'package:kyoumutechou/feature/awareness/weidget/dialog/awareness_template_search_student.dart';
import 'package:kyoumutechou/feature/awareness/weidget/dialog/photo_widget.dart';
import 'package:kyoumutechou/feature/awareness/weidget/dialog/seito_widget.dart';
import 'package:kyoumutechou/feature/boxes.dart';
import 'package:kyoumutechou/feature/common/widget/save2_button_widget.dart';
import 'package:kyoumutechou/feature/common/widget/toast_helper.dart';
import 'package:kyoumutechou/helpers/theme/app_theme.dart';
import 'package:kyoumutechou/helpers/widgets/my_spacing.dart';


class AwarenessRegistDialog extends ConsumerWidget {
  AwarenessRegistDialog({
    required this.kizuki, super.key, 
    this.opt = AwarenessOperationItem.add,
  });

  final AwarenessKizukiModel kizuki;
  final AwarenessOperationItem opt;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final kizukiController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final meiboBox = Boxes.getAwarenessMeiboBox();
    var meibos = <AwarenessMeiboModel>[];

    // Add Mode
    if (opt == AwarenessOperationItem.add){
      meibos = meiboBox.values.toList().where(
        (e) => e.selectFlag ?? false
      ,).toList();
    }
    
    // Edit Mode
    if (opt == AwarenessOperationItem.edit){
      kizukiController.text = '${kizuki.naiyou}';
    }
    
    // Copy Mode
    if (opt == AwarenessOperationItem.copy){
      kizukiController.text = '${kizuki.naiyou}';
    }

    return Form(
        key: _formKey,
        child: SimpleDialog(
          surfaceTintColor: theme.colorScheme.surface,
          children: [
            // 1. title
            const Text('　気づきの編集', style: TextStyle(
              fontWeight: FontWeight.bold, 
              fontSize: 20,
            ),),
      
            // 2. body
            const Divider(color: Colors.grey),
            Container(
              padding: MySpacing.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  // 2.1 生徒情報
                  Row(
                    children: [
                      Container(
                        width: 88,
                        alignment: Alignment.centerRight,
                        child: const Text('氏名', style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 14,),),
                      ),
                      MySpacing.width(12),
                      
                      if (opt == AwarenessOperationItem.add)
                        Expanded(child: SizedBox(
                              width: 600,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                    children: 
                                        meibos.map((e) => SeitoWidget(
                                              studentName: e.studentName ?? '',
                                              studentId: e.studentId??0,
                                              photoUrl: e.photoUrl ?? '',
                                            ),)
                                        .toList(),),
                              ),),),
                      if (opt == AwarenessOperationItem.edit)
                        Expanded(child: SizedBox(
                          width: 600,
                          child: SeitoWidget(
                            studentName: kizuki.studentName??'',
                            studentId: kizuki.studentId ?? 0,
                            photoUrl: kizuki.photoUrl ?? '',
                          ),
                        ),),
                      
                      if (opt == AwarenessOperationItem.copy)
                        Expanded(child: SizedBox(
                          width: 600,
                          child: AwarenessTemplateSearchStudent(),
                        ),),
                    ],
                  ),
      
                  // 2.2 分類 
                  Row(children: [
                    Container(
                      width: 88,
                      alignment: Alignment.centerRight,
                      child: const Text('分類', style:TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 14,),),
                    ),
                    MySpacing.width(12),
                    const Expanded(child: SizedBox(
                      width: 600,
                      child:  AwarenessBunrui(),
                    ),),
                  ],),
      
                  MySpacing.height(8),
                  // 2.3 kizuki
                  Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    AwarenessDialogLeftWidget(
                      kizukiController: kizukiController,
                    ),
                    MySpacing.width(12),
                    AwarenessDialogMiddleWidget(
                      controller: kizukiController,
                    ),
                    MySpacing.width(12),
                    AwarenessDialogRightWidget(
                      kizukiController: kizukiController,
                    ),
                  ],),

                  // 2.4 写真
                  MySpacing.height(8),
                  PhotoWidget(kizukiId : kizuki.id??0),
                ],
              ),
            ),
      
            // 3.buttom button
            const Divider(color: Colors.grey),
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
                        ref.read(awarenessStudentAddProvider.notifier).state=[];
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
                    Save2ButtonWidget(
                      label: '保存',
                      onPressed: () async {
                        if (_formKey.currentState!.validate() == false) {
                          ToastHelper.showToast(context, '　必須項目を入力してください　');
                          return;
                        }

                        if (opt == AwarenessOperationItem.edit){
                          ref.read(awarenessEditProvider.notifier).state = 
                          kizuki.id!;
                          await ref.read(awarenessKizukiListProvider.notifier)
                          .patch(kizukiController.text);
                        }else{
                          await ref.read(awarenessMeiboListProvider.notifier)
                          .save(kizukiController.text, opt);
                        }
                        ToastHelper.showToast(context, '　保存しました　');
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),),
          ],
        ),
      );
  }
}
