import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kyoumutechou/helpers/widgets/my_spacing.dart';

class AwarenessDialogRightWidget extends ConsumerWidget {
  AwarenessDialogRightWidget({
    Key? key,
    required this.kizukiController,
  }) : super(key: key);

  final TextEditingController kizukiController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(width: 300, child: Column(crossAxisAlignment: CrossAxisAlignment.start,  children: [
      Text('テンプレート文(学校共通)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),),
      //AwarenessTemplateSearchText(kizukiController: kizukiController,),
      
      MySpacing.height(12),
      Text('テンプレート文(個人)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),),
      SingleChildScrollView(scrollDirection: Axis.horizontal, child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, 
        children: kizukiPerson.map((e) =>
          
          Column(children: [
            MySpacing.height(12),
            OutlinedButton(
              child: Text('$e', maxLines: 1,),
              onPressed: (){kizukiController.text = e;}, 
            )
          ],)

      ).toList(), ),)

    ],));
  }
}

List<String> kizukiPerson = [
  'この調子で、がんばってほしいと思います。',
  'どの学習でも、やる気いっぱいで取り組んでいました。',
  'いつもフレッシュな気持ちで、学習に向かっていました。',
  '心身共に、ひと回りたくましくなりました。',
  '自立へのステップをふみながら、自信のある生活ぶりでした。',
];
