import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kyoumutechou/feature/common/provider/tokobis_provider.dart';
import 'package:kyoumutechou/feature/dashboard/model/home_health_model.dart';
import 'package:kyoumutechou/feature/dashboard/provider/home_health_list_provider.dart';
import 'package:kyoumutechou/helpers/widgets/my_spacing.dart';
import 'package:kyoumutechou/shared/http/app_exception.dart';

class HealthSummaryWidget extends ConsumerWidget {
  const HealthSummaryWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tokobi = ref.watch(tokobiProvider);
    if (tokobi == null) {
      return Container();
    }

    final state = ref.watch(homeHealthListNotifierProvider);
    return state.when(
      loading: () {
        return const Center(child: CircularProgressIndicator());
      },
      error: (AppException e) {
        return Text(e.toString());
      },
      loaded: (healthListList) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: healthListList.map(daySummry).toList(),
        );
      },
    );
  }

  Widget daySummry(List<HomeHealthModel> healthList) {
    return Expanded(
      child: ListView(
        children: healthList.map((e) {
          String inputStates;
          Color? inputColor = Colors.pink[100];
      
          inputStates = '　未　';
          inputColor = Colors.pink[100];
          if (e.doneKenkoKansatsuFlg ?? false) {
            if (e.zaiseki! > 0) {
              inputStates = '　済　';
              inputColor = Colors.greenAccent[100];
            }
          }
      
          return Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MySpacing.height(4),
              SizedBox(
                width: 330,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: 1),
                    borderRadius: BorderRadius.circular(3),
                  ),
                  alignment: Alignment.center,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MySpacing.height(8),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          MySpacing.width(12),
                          const FaIcon(
                            FontAwesomeIcons.stethoscope,
                            size: 16,
                          ),
                          MySpacing.width(8),
                          Text(
                            '${e.className}',
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          MySpacing.width(16),
                          Container(
                            decoration: BoxDecoration(
                              color: inputColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(inputStates),
                          ),
                        ],
                      ),
                      MySpacing.height(8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              Text('出席'),
                              MySpacing.height(4),
                              Text(
                                '${e.shusseki}',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Container(
                              color: Colors.grey,
                              height: 45,
                              child: VerticalDivider(width: 1)),
                          Column(
                            children: [
                              Text('遅刻'),
                              MySpacing.height(4),
                              Text(
                                '${e.tikoku}',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Container(
                              color: Colors.grey,
                              height: 45,
                              child: VerticalDivider(width: 1)),
                          Column(
                            children: [
                              Text('早退'),
                              MySpacing.height(4),
                              Text(
                                '${e.sotai}',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Container(
                              color: Colors.grey,
                              height: 45,
                              child: VerticalDivider(width: 1)),
                          Column(
                            children: [
                              Text('欠席・出停等'),
                              MySpacing.height(4),
                              Text(
                                '${e.kessekiShuttei}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            color: Colors.grey,
                            height: 45,
                            child: const VerticalDivider(width: 1),
                          ),
                          Column(
                            children: [
                              const Text('ｲﾝﾌﾙｴﾝｻﾞ'),
                              MySpacing.height(4),
                              Text(
                                '${e.influenza}',
                                style: const TextStyle(
                                  //fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
          //return HealthSummaryWidget(model: e,);
        }).toList(),
      ),
    );
  }

}
