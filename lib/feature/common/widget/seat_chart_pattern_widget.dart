import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kyoumutechou/feature/boxes.dart';
import 'package:kyoumutechou/feature/common/provider/common_provider.dart';
import 'package:kyoumutechou/feature/common/provider/filter_provider.dart';
import 'package:kyoumutechou/feature/common/provider/seat_chart_pattern_provider.dart';
import 'package:kyoumutechou/feature/seat/model/seat_setting_model.dart';
import 'package:kyoumutechou/feature/seat/provider/seat_chart_provider.dart';
import 'package:kyoumutechou/feature/seat/provider/seat_setting_provider.dart';
import 'package:kyoumutechou/helpers/widgets/my_spacing.dart';
import 'package:kyoumutechou/shared/util/date_util.dart';

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
          settings
            ..removeWhere(
              (e) => !DateUtil.isDateInRange(
                filter.targetDate!,
                e.startDate,
                e.endDate,
              ),
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
    var seatSetting = ref.watch(seatSettingPatternProvider);

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
        MySpacing.width(8),
        ElevatedButton.icon(
          onPressed: () {
            ref.read(lecternPositionProvider.notifier).state =
                ref.read(lecternPositionProvider) == LecternPosition.top
                    ? LecternPosition.bottom
                    : LecternPosition.top;
          },
          icon: const Icon(Icons.swap_vert_outlined),
          label: const Text('表示回転'),
          style: ElevatedButton.styleFrom(
            side: BorderSide(
              color: Colors.green.shade200, // 枠線の色
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
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
    ref.read(seatSettingPatternProvider.notifier).state = newValue;
  }
}
