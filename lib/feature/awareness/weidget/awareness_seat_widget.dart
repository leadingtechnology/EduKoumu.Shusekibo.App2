
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kyoumutechou/feature/awareness/model/awareness_meibo_model.dart';
import 'package:kyoumutechou/feature/awareness/provider/awareness_meibo_provider.dart';
import 'package:kyoumutechou/helpers/widgets/my_spacing.dart';

// ignore: must_be_immutable
class AwarenessSeatWidget extends ConsumerWidget {
  AwarenessSeatWidget(
    this.tabController,
    {required this.meibo, super.key,});

  final AwarenessMeiboModel meibo;
  final TabController tabController;
  Color changeColor = Colors.black;
  final _baseUrl = dotenv.env['BASE_URL']!;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ignore: use_if_null_to_convert_nulls_to_bools
    if (meibo.changedFlag != null && meibo.changedFlag == true){
      changeColor = Colors.blue;
    }

    final url = '$_baseUrl${meibo.photoUrl}';
    final accessToken = Hive.box<String>('shusekibo').get('token').toString();

    return GestureDetector(
      onTap: () async {
        await ref
            .read(awarenessMeiboListProvider.notifier)
            .updateByMeibo(meibo);
      },
      child: Stack(children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 5, 5),
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(6)),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    spreadRadius: 1,
                    color: Colors.black26,
                    blurRadius: 2,
                    offset: Offset(2, 0),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // User Information
                  Expanded(
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8, 4, 8, 0),
                          child: ClipOval(child: Image.network(
                            url,
                            headers: {'Authorization': 'Bearer $accessToken'},
                          ),),
                        ),
                        Expanded(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                                alignment: Alignment.centerRight,
                                padding: const EdgeInsets.fromLTRB(0, 0, 18, 0),
                                child: Text(
                                  meibo.shussekiNo ?? '',
                                  style: const TextStyle(fontSize: 12),
                                ),
                              ),
                            Text('${meibo.studentName}',
                                style: const TextStyle(fontSize: 14),),
                          ],
                        ),),
                      ],
                    ),
                  ),

                  // status bar
                  MySpacing.height(4),
                  InkWell(
                    onTap: meibo.kizukiCount == 0 ? null : () {
                            // 生徒情報を設定する
                            ref.read(studentIdProvider.notifier).state =
                                meibo.studentId ?? 0;
                            ref.read(isStudentIdProvider.notifier).state = true;

                            // タブを遷移する
                            tabController.animateTo(1);
                      //Navigator.pop(context);
                    },
                    child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.withAlpha(50),
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(6),
                            bottomRight: Radius.circular(6),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            //Text('$a1'),
                            if (meibo.kizukiCount!=0) 
                              const FaIcon(FontAwesomeIcons.lightbulb,size: 16,) 
                            else Container(),
                            
                            if (meibo.kizukiCount!=0) Text(
                              '${meibo.kizukiCount} 件',
                              style: TextStyle(color: changeColor ),
                            ) else const Text(' '),
                          ],
                        ),),
                  ),
                ],
              ),
            ),
          ),
          if (meibo.selectFlag??false == true) Opacity(opacity: 0.6,
            child: Stack(
              children: [
                Container(color: Colors.grey[500]),
              ],
            ),
          ) else Container(),
          if (meibo.selectFlag??false == true) Column( children: [
                MySpacing.height(2),
                Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  Container(
                    padding: const EdgeInsets.all(2), 
                    alignment: Alignment.topRight, 
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(90),
                    ),
                    child: FaIcon(
                      FontAwesomeIcons.solidCircleCheck,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  //Spacing.width(8),
                ],),
            ],) else Container(),
        ],
      ),
    );
  }
}
