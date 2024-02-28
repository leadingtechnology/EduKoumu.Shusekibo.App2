import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kyoumutechou/feature/boxes.dart';
import 'package:kyoumutechou/feature/common/provider/filter_provider.dart';
import 'package:kyoumutechou/feature/seat/model/seat_setting_model.dart';
import 'package:kyoumutechou/feature/seat/provider/seat_chart_provider.dart';
import 'package:kyoumutechou/feature/seat/provider/seat_setting_provider.dart';
import 'package:kyoumutechou/helpers/widgets/my_spacing.dart';

class SeatChartPatternWidget extends ConsumerStatefulWidget {
  const SeatChartPatternWidget({super.key});

  @override
  SeatChartPatternState createState() => SeatChartPatternState();
}

class SeatChartPatternState extends ConsumerState<SeatChartPatternWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(seatSettingListProvider);
    return state.when(
      loading: Container.new,
      error: (error) => Center(child: Text(error.toString())),
      loaded: () {
          final filter = ref.watch(filterProvider);
          final settings =
              Boxes.getSeatSetting().values.toList().cast<SeatSettingModel>();

          if (settings.isEmpty) {
            return Container();
          }

          try {
            // ignore: cascade_invocations
            settings
              ..removeWhere(
                (e) =>
                    e.startDate!.isAfter(filter.targetDate!) &&
                    e.endDate!.isBefore(filter.targetDate!),
              )
              ..sort((a, b) => a.startDate!.compareTo(b.startDate!));
          } catch (e) {
            //
          }

          return _buildGridItem(context, settings);
      },
    );
  }

  Widget _buildGridItem(BuildContext context, List<SeatSettingModel> settings) {
    var seatSetting = ref.watch(seatSettingProvider);

    if (settings.isEmpty || seatSetting.id == null) {
      return Container();
    }

    settings.sort((a, b) => a.id!.compareTo(b.id!));

    if (settings.where((e) => e.id == seatSetting.id).isEmpty) {
      seatSetting = settings.first;
    }

    return Row(
      children: [
        const Text('座席表パターン'),
        MySpacing.width(8),
        Container(
          height: 35,
          padding: MySpacing.left(4),
          decoration: BoxDecoration(
            border: Border.all(),
            borderRadius: BorderRadius.circular(4),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<SeatSettingModel>(
              value: seatSetting,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontFamily: 'NotoSansJP',
              ),
              dropdownColor: Colors.white,
              onChanged: (SeatSettingModel? newValue) async {
                await _doAsyncTask(newValue);
              },
              items: settings.map((setting) {
                return DropdownMenuItem<SeatSettingModel>(
                  value: setting,
                  child: Text(
                    '${setting.seatPatternName}',
                    style: const TextStyle(fontFamily: 'NotoSansJP'),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _doAsyncTask(SeatSettingModel? newValue) async {
    if (newValue == null) {
      return;
    }

    // 2) 座席設定IDにより、座席表の詳細設定を取得する(hive box)
    await ref.read(seatChartListProvider.notifier).fetch(newValue.id ?? 0);
    ref.read(seatSettingProvider.notifier).state = newValue;

  }
}
