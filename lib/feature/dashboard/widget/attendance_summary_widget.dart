import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kyoumutechou/feature/common/provider/tokobis_provider.dart';
import 'package:kyoumutechou/feature/dashboard/model/home_attendance_model.dart';
import 'package:kyoumutechou/feature/dashboard/provider/home_attendance_list_provider.dart';
import 'package:kyoumutechou/helpers/widgets/my_spacing.dart';
import 'package:kyoumutechou/shared/http/app_exception.dart';
import 'package:kyoumutechou/shared/util/date_util.dart';

class AttendanceSummaryWidget extends ConsumerWidget {
  const AttendanceSummaryWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tokobi = ref.watch(tokobiProvider);
    if (tokobi == null) {
      return Container();
    }

    final state = ref.watch(homeAttendanceListNotifierProvider);
    return state.when(loading: () {
      return const Center(child: CircularProgressIndicator());
    }, error: (AppException e) {
      return Text(e.toString());
    }, loaded: (attendanceLists) {
      final tokobis = ref.watch(lastTokobisProvider);

      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children:List.generate(tokobis.length, (index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start, 
            children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: Text(
                    '${DateUtil.getJpMonthDayWeek(tokobis[index])} ',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              Expanded(
                child: daySummry(attendanceLists[index]),
              ),
            ],
          );
        }),
      );
    },);
  }

  Widget daySummry(List<HomeAttendanceModel> attendanceList){
    return SingleChildScrollView(
      child: Column(
            children: attendanceList.map((e) {
              String inputStates;
              var inputColor = Colors.pink[100];
      
                inputStates = '　未　';
                inputColor = Colors.pink[100];
              if (e.doneAttendanceFlg ?? false) {
                if(e.zaiseki! > 0){
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
                    height: 94,
                    width: 330,
                    child: Container(
                        decoration: BoxDecoration(
                          color: Colors.yellow[100],
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(3),
                        ),
                        alignment: Alignment.center,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MySpacing.height(8),
                            Row(
                              children: [
                                MySpacing.width(12),
                                const FaIcon(
                                  FontAwesomeIcons.clipboard,
                                  size: 16,
                                ),
                                MySpacing.width(8),
                                Text(
                                  '${e.className}',
                                  style: const TextStyle(
                                      fontSize: 16, fontWeight: FontWeight.bold,),
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
                                    const Text('出席'),
                                    MySpacing.height(4),
                                    Text(
                                      '${e.shusseki}',
                                      style:
                                          const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                  ],
                                ),
                                Container(
                                    color: Colors.grey,
                                    height: 45,
                                    child: const VerticalDivider(width: 1),),
                                Column(
                                  children: [
                                    const Text('遅刻'),
                                    MySpacing.height(4),
                                    Text(
                                      '${e.tikoku}',
                                      style:
                                          const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                  ],
                                ),
                                Container(
                                    color: Colors.grey,
                                    height: 45,
                                    child: const VerticalDivider(width: 1),),
                                Column(
                                  children: [
                                    const Text('早退'),
                                    MySpacing.height(4),
                                    Text(
                                      '${e.sotai}',
                                      style:
                                          const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                    MySpacing.height(4),
                                  ],
                                ),
                                Container(
                                    color: Colors.grey,
                                    height: 45,
                                    child: const VerticalDivider(width: 1),),
                                Column(
                                  children: [
                                    const Text('欠席・出停等'),
                                    MySpacing.height(4),
                                    Text(
                                      '${e.kessekiShuttei}',
                                      style:
                                          const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),),
                  ),
                ],
              );
            }).toList(),
          ),
    );
  }
}
