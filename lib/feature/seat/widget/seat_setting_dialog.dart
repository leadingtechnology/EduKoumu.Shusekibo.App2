
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kyoumutechou/feature/awareness/provider/awareness_meibo_provider.dart';
import 'package:kyoumutechou/feature/boxes.dart';
import 'package:kyoumutechou/feature/common/provider/filter_provider.dart';
import 'package:kyoumutechou/feature/common/widget/commom_widget.dart';
import 'package:kyoumutechou/feature/common/widget/delete_button_widget.dart';
import 'package:kyoumutechou/feature/common/widget/save2_button_widget.dart';
import 'package:kyoumutechou/feature/common/widget/toast_helper.dart';
import 'package:kyoumutechou/feature/seat/model/seat_setting_model.dart';
import 'package:kyoumutechou/feature/seat/provider/seat_setting_provider.dart';
import 'package:kyoumutechou/feature/seat/widget/seat_configration.dart';
import 'package:kyoumutechou/helpers/theme/app_theme.dart';
import 'package:kyoumutechou/helpers/widgets/my_spacing.dart';
import 'package:kyoumutechou/shared/util/date_util.dart';

class SeatSettingDialog extends ConsumerStatefulWidget {
  const SeatSettingDialog({required this.id, super.key});

  final int id;

  @override
  SeatSettingState createState() => SeatSettingState();
}

class SeatSettingState extends ConsumerState<SeatSettingDialog> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _patternNameController = TextEditingController();

  SeatSettingModel model = SeatSettingModel(
    id: 0,
    row: 6,
    column: 6,
    seatOrder: 0,
    seatPattern: '',
    seatPatternName: '',
    startDate : DateTime.now(),
    endDate: DateTime.now(),
  );
  
  int selectedRow = 6;
  int selectedColumn = 6;
  String seatPattern = '0';
  int selectedSeatOrder = seatConfigurations[0].seatOrder;
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();

  final box = Boxes.getSeatSetting();
  late final SeatSettingModel seatsSetting;

  @override
  void initState() {
    super.initState();

    if (widget.id != 0) {
      model = Boxes.getSeatSetting().values.toList().firstWhere(
            (element) => element.id == widget.id,
          );
      _patternNameController.text = model.seatPatternName!;

      if (widget.id > 0) {
        selectedRow = model.row!;
        selectedColumn = model.column!;
        seatPattern = model.seatPattern!;
        selectedSeatOrder = model.seatOrder!;
        startDate = model.startDate!;
        endDate = model.endDate!;
      }
    }
  }

  @override
  void dispose() {
    _patternNameController.dispose();
    super.dispose();
  }

  Future<void> _pickDateRange(BuildContext context, WidgetRef ref) async {
    final dates = DateUtil.calculateFiscalYear(DateTime.now());

    final initialDateRange =
        DateTimeRange(start: DateTime.now(), end: DateTime.now());

    final newDateRange = await showDateRangePicker(
      context: context,
      initialDateRange: initialDateRange,
      initialEntryMode : DatePickerEntryMode.calendar,
      firstDate: dates.item1,
      lastDate: dates.item2,
      locale: const Locale('ja', 'JP'),
      builder: (context, child) {
        return Column(
          children: [
            ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 400,
              ),
              child: child,
            ),
          ],
        );
      },
    );

    if (newDateRange != null) {
      startDate = newDateRange.start;
      endDate = newDateRange.end;
    } else {
      return;
    }
  }  


  @override
  Widget build(BuildContext context) {
    
    return Form(
      key: _formKey,
      child: SimpleDialog(
        surfaceTintColor: theme.colorScheme.surface,
        children: [
          // 1. title
          const Text(
            '　座席表パターンの編集',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          MySpacing.width(560),

          // 2.1 student name
          const Divider(color: Colors.grey),
          Container(
            padding: MySpacing.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1 行
                Row(
                  children: [
                    Container(
                      width: 88,
                      alignment: Alignment.centerRight,
                      child: const Text(
                        '行',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    MySpacing.width(12),
                    DropdownButton<int>(
                      value: selectedRow, 
                      style: const TextStyle(color: Colors.black, fontSize: 18),
                      dropdownColor: Colors.white,
                      underline: Container(
                        height: 2,
                        color: Colors.white,
                      ),
                      items: List.generate(8, (index) {
                        return DropdownMenuItem<int>(
                          value: index + 1,
                          child: Text((index + 1).toString()),
                        );
                      }),
                      onChanged: (value) {
                        setState(() {
                          selectedRow = value ?? 6;  
                        });
                      },
                    ),
                  ],
                ),

                // 2 列
                MySpacing.height(8),
                Row(
                  children: [
                    Container(
                      width: 88,
                      alignment: Alignment.centerRight,
                      child: const Text(
                        '列',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    MySpacing.width(12),
                    DropdownButton<int>(
                      value: selectedColumn, 
                      style: const TextStyle(color: Colors.black, fontSize: 18),
                      dropdownColor: Colors.white,
                      underline: Container(
                        height: 2,
                        color: Colors.white,
                      ),
                      items: List.generate(8, (index) {
                        return DropdownMenuItem<int>(
                          value: index + 1,
                          child: Text((index + 1).toString()),
                        );
                      }),
                      onChanged: (value) {
                        setState(() {
                          selectedColumn = value!;  
                        });
                      },
                    ),
                  ],
                ),

                // 3 座席配置順
                MySpacing.height(8),
                Row(
                  children: [
                    Container(
                      width: 88,
                      alignment: Alignment.centerRight,
                      child: const Text(
                        '座席配置順',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    MySpacing.width(12),
                    DropdownButton<int>(
                      value: selectedSeatOrder, 
                      style: const TextStyle(color: Colors.black, fontSize: 14),
                      dropdownColor: Colors.white,
                      underline: Container(
                        height: 2,
                        color: Colors.white,
                      ),
                      items: seatConfigurations.map((cf) {
                        return DropdownMenuItem<int>(
                          value: cf.seatOrder,
                          child: Text(cf.name),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedSeatOrder = value!;  
                        }); 
                      },
                    ),
                  ],
                ),
                // 4パターン名
                MySpacing.height(8),
                Row(
                  children: [
                    Container(
                      width: 88,
                      alignment: Alignment.centerRight,
                      child: const Text(
                        'パターン名',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    MySpacing.width(12),
                    SizedBox(
                      width: 200,
                      child: TextFormField(
                        controller: _patternNameController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.all(8),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'パターン名を入力してください';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),

                // 5期間
                MySpacing.height(8),
                Row(
                  children: [
                    Container(
                      width: 88,
                      alignment: Alignment.centerRight,
                      child: const Text(
                        '期間',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    MySpacing.width(12),
                    Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: InkWell(
                        onTap: () async {
                          await _pickDateRange(context, ref);
                          setState(() {
                            
                          });
                        },
                        child: SingleIconChip(
                          isSelected: true,
                          text:
                              '${DateUtil.getJapaneseDate(startDate)} ~ ${DateUtil.getJapaneseDate(endDate)}',
                          iconData: Icons.calendar_month_outlined,
                        ),
                      ),
                    ),
                    
                  ],
                ),

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
                OutlinedButton(
                  child: const Text(
                    '閉じる',
                    style: TextStyle(color: Colors.black),
                  ),
                  onPressed: () {
                    ref.read(awarenessStudentAddProvider.notifier).state = [];
                    Navigator.of(context).pop();
                  },
                ),
                Expanded(child: Container()),
                DeleteButtonWidget(
                  label: '削除',
                  onPressed: widget.id == 0 ? null :  () async {
                          // 削除処理
                          await ref
                              .read(seatSettingListProvider.notifier)
                              .delete(widget.id);
                              
                          ref.read(filterProvider.notifier).refresh();

                    ToastHelper.showToast(context, '　削除しました　');
                    Navigator.of(context).pop();
                  },
                ),
                MySpacing.width(12),
                Save2ButtonWidget(
                  label: '保存',
                  onPressed: () async {

                    if (_formKey.currentState!.validate() == false) {
                      //ToastHelper.showToast(context, '　必須項目を入力してください　');
                      return;
                    }

                    if (widget.id > 0) {
                      await ref.read(seatSettingListProvider.notifier).patch(
                          id: widget.id,
                          row: selectedRow,
                          col: selectedColumn,
                          seatOrder: selectedSeatOrder,
                          seatPattern: seatPattern,
                          seatPatternName: _patternNameController.text,
                          startDate: startDate,
                          endDate: endDate,
                        );
                    } else {  
                      await ref.read(seatSettingListProvider.notifier).save(
                          row: selectedRow,
                          col: selectedColumn,
                          seatOrder: selectedSeatOrder,
                          seatPattern: seatPattern,
                          seatPatternName: _patternNameController.text,
                          startDate: startDate,
                          endDate: endDate,
                        );
                    }
                    ref.read(filterProvider.notifier).refresh();
                    
                    // 成功の場合、トーストを表示して、ダイアログを閉じる。
                    ToastHelper.showToast(context, '　保存しました　');
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

}
