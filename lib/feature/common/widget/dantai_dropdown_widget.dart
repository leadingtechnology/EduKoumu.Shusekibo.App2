import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kyoumutechou/feature/boxes.dart';
import 'package:kyoumutechou/feature/common/model/dantai_model.dart';
import 'package:kyoumutechou/feature/common/provider/common_provider.dart';
import 'package:kyoumutechou/feature/common/provider/dantais_provider.dart';
import 'package:kyoumutechou/feature/home/provider/home_provider.dart';
import 'package:kyoumutechou/feature/seat/provider/seat_chart_provider.dart';

class DantaiDropdownWidget extends ConsumerWidget {
  const DantaiDropdownWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 座席表設定時は非表示にする
    final menu = ref.watch(menuProvider);
    final pageType = ref.watch(seatChartPageTypeProvider);
    if (menu == Menu.seatChart && pageType == PageType.seat) {
      return const SizedBox.shrink();
    }


    // 団体ドロップダを作成する
    final dantaiList = Boxes.getDantais().values.toList();
    
    dantaiList.sort(
      (a, b) => '${a.organizationBunrui}${a.organizationKbn}${a.code}'
          .compareTo('${b.organizationBunrui}${b.organizationKbn}${b.code}'),
    );

    return DropdownButton<DantaiModel>(
      value: ref.watch(dantaiProvider),
      //icon: const Icon(Icons.school),
      elevation: 16,
      style: const TextStyle(color: Colors.black, fontSize: 18),
      dropdownColor: Colors.white,
      underline: Container(
        height: 2,
        color: Colors.white,
      ),
      onChanged: (DantaiModel? newValue) {
        ref.read(dantaiProvider.notifier).state = newValue!;
      },
      items: dantaiList.map((value) {
        return DropdownMenuItem<DantaiModel>(
          value: value,
          child: Text(
            value.name.toString(),
            style: const TextStyle(fontFamily: 'NotoSansJP'),
          ),
        );
      }).toList(),
    );        
  }
}
