import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kyoumutechou/feature/awareness/model/awareness_meibo_model.dart';
import 'package:kyoumutechou/feature/awareness/provider/awareness_meibo_provider.dart';
import 'package:kyoumutechou/feature/awareness/weidget/dialog/seito_widget.dart';
import 'package:kyoumutechou/feature/boxes.dart';
import 'package:kyoumutechou/helpers/widgets/my_spacing.dart';

import 'package:kyoumutechou/shared/http/app_exception.dart';

class AwarenessTemplateSearchStudent extends ConsumerStatefulWidget {
  const AwarenessTemplateSearchStudent({super.key});

  @override
  ConsumerState<AwarenessTemplateSearchStudent> createState() =>
      _AwarenessTemplateSearchStudentState();
}

class _AwarenessTemplateSearchStudentState
    extends ConsumerState<AwarenessTemplateSearchStudent> {
  final _multiKey = GlobalKey<DropdownSearchState<AwarenessMeiboModel>>();
  bool? _popupBuilderSelection;

  @override
  void initState() {
    super.initState();
    _popupBuilderSelection = false;
  }

  void _handleCheckBoxState() {
    final selectedItem = _multiKey.currentState!.popupGetSelectedItems;
    final isAllSelected =
        _multiKey.currentState?.popupIsAllItemSelected ?? false;
    _popupBuilderSelection =
        selectedItem.isEmpty ? false : (isAllSelected ? true : null);

    setState(() {});
  }

  Widget _customPopupItemBuilder(
    BuildContext context,
    AwarenessMeiboModel item,
    bool isSelected,
  ) {
    return Column(
      children: [
        MySpacing.height(8),
        Row(
          children: [
            MySpacing.width(8),
            SeitoWidget(
              studentName: item.studentName ?? '',
              studentId: item.studentId ?? 0,
              photoUrl: item.photoUrl ?? '',
            ),
          ],
        ),
        const Divider(
          color: Colors.black12,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(awarenessMeiboListProvider);

    return state.when(
      loading: () {
        return Container();
      },
      error: (AppException e) {
        return Text(e.toString());
      },
      loaded: () {
        return ValueListenableBuilder(
          valueListenable: Boxes.getAwarenessMeiboBox().listenable(),
          builder: (context, Box<AwarenessMeiboModel> box, _) {
            final meibos = box.values.toList();

            return SizedBox(
              width: 300,
              child: DropdownSearch<AwarenessMeiboModel>.multiSelection(
                key: _multiKey,
                items: meibos,
                clearButtonProps: const ClearButtonProps(isVisible: true),
                filterFn: (item, filter) {
                  return item.studentName?.contains(filter) ?? false;
                },
                validator: (List<AwarenessMeiboModel>? v) {
                  return v == null || v.isEmpty ? '必須項目です' : null;
                },
                onChanged: (List<AwarenessMeiboModel> meibos) async {
                  final ids = meibos.map((e) => e.studentId ?? 0).toList();
                  ref.read(awarenessStudentAddProvider.notifier).state = ids;
                },
                compareFn: (item, selectedItem) {
                  return item.studentId == selectedItem.studentId;
                },
                
                popupProps: PopupPropsMultiSelection.dialog(
                  itemBuilder: _customPopupItemBuilder,
                  showSearchBox: true,
                  emptyBuilder: (context, search) {
                    return const Padding(
                      padding: EdgeInsets.all(8),
                      child: Center(
                        child: Text(
                          '生徒が見つかりません',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  },
                  containerBuilder: (ctx, popupWidget) {
                    return Padding(
                      padding: const EdgeInsets.all(8),
                      child: _CheckBoxWidget(
                        isSelected: _popupBuilderSelection,
                        onChanged: (v) {
                          if (v != null && v == true) {
                            _multiKey.currentState!.popupSelectAllItems();
                          } else if (v == false) {
                            _multiKey.currentState!.popupDeselectAllItems();
                          }
                          _handleCheckBoxState();
                        },
                        child: popupWidget,
                      ),
                    );
                  },
                ),
                dropdownBuilder: (context, selectedItems) {
                  Widget item(AwarenessMeiboModel m) => Container(
                        height: 32,
                        padding: const EdgeInsets.only(left: 6),
                        margin: const EdgeInsets.symmetric(
                          horizontal: 2,
                          vertical: 1,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Theme.of(context).primaryColorLight,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SeitoWidget(
                              studentName: '${m.studentName}',
                              studentId: m.studentId ?? 0,
                              photoUrl: m.photoUrl ?? '',
                            ),
                            MaterialButton(
                              height: 20,
                              shape: const CircleBorder(),
                              color: Colors.red[200],
                              minWidth: 20,
                              onPressed: () {
                                _multiKey.currentState?.removeItem(m);
                                _handleCheckBoxState();
                              },
                              child: const Icon(
                                Icons.close_outlined,
                                size: 18,
                              ),
                            ),
                          ],
                        ),
                      );
                  return Wrap(
                    children: selectedItems.map(item).toList(),
                  );
                },
              ),
            );

            // return SizedBox(
            //   width: 300,
            //   child: DropdownSearch<AwarenessMeiboModel>.multiSelection(
            //     key: _multiKey,
            //     onChanged:(List<AwarenessMeiboModel> meibos) async{
            //       final ids = meibos.map((e) => e.studentId??0).toList();
            //       ref.read(awarenessStudentAddProvider.notifier).state = ids;
            //     },
            //     autoValidateMode: AutovalidateMode.always,
            //     validator: (List<AwarenessMeiboModel>? v) {
            //       return v == null || v.isEmpty ? '必須項目です' : null;
            //     },
            //     popupProps: PopupPropsMultiSelection.menu(
            //       showSelectedItems: true,
            //       itemBuilder: (BuildContext context, AwarenessMeiboModel item, bool isSelected){
            //         return Column(children: [
            //             MySpacing.height(8),
            //             Row(children: [
            //               MySpacing.width(8),
            //               SeitoWidget(
            //                 studentName: item.studentName??'',
            //                 studentId: item.studentId??0,
            //                 photoUrl: item.photoUrl ?? '',
            //               ),
            //             ],),
            //             const Divider(color: Colors.black12,),
            //         ],);
            //       },

            //       //disabledItemFn: (String s) => s.startsWith('I'),
            //     ),

            //     dropdownBuilder: (context, selectedItems) {
            //       Widget item(AwarenessMeiboModel m) => Container(
            //             height: 32,
            //             padding: const EdgeInsets.only(left: 6),
            //             margin: const EdgeInsets.symmetric(
            //               horizontal: 2,
            //               vertical: 1,
            //             ),
            //             decoration: BoxDecoration(
            //               borderRadius: BorderRadius.circular(10),
            //               color: Theme.of(context).primaryColorLight,
            //             ),
            //             child: Row(
            //               mainAxisSize: MainAxisSize.min,
            //               children: [
            //                 SeitoWidget(
            //                   studentName: '${m.studentName}',
            //                   studentId: m.studentId??0,
            //                   photoUrl: m.photoUrl ?? '',
            //                 ),
            //                 MaterialButton(
            //                   height: 20,
            //                   shape: const CircleBorder(),
            //                   color: Colors.red[200],
            //                   minWidth: 20,
            //                   onPressed: () {
            //                     _multiKey.currentState?.removeItem( m);
            //                   },
            //                   child: const Icon(
            //                     Icons.close_outlined,
            //                     size: 18,
            //                   ),
            //                 ),
            //               ],
            //             ),
            //           );
            //       return Wrap(
            //         children: selectedItems.map(item).toList(),
            //       );
            //     },

            //     items: meibos,

            //     //clearButtonSplashRadius: 20,
            //     selectedItems: [],
            //     compareFn: (item, selectedItem) {return item.studentId == selectedItem.studentId;} ,
            //   ),
            // );
          },
        );
      },
    );

    // return DropdownSearch<String>(
    //   items: _kizukiSchool,
    //   dropdownSearchDecoration: InputDecoration(
    //     //labelText: "Custom BottomShet mode",
    //     contentPadding: EdgeInsets.fromLTRB(12, 12, 0, 0),
    //     border: OutlineInputBorder(),
    //   ),
    //   onChanged: (String? value){ kizukiController.text = '$value'; },
    //   //selectedItem: "",
    //   popupProps: PopupProps.menu(
    //     searchFieldProps: TextFieldProps(
    //       padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
    //       decoration: InputDecoration(
    //         border: OutlineInputBorder(),
    //         contentPadding: EdgeInsets.fromLTRB(12, 12, 8, 0),
    //       ),
    //     ),
    //     showSearchBox: true,
    //   ),
    // );
  }
}

class _CheckBoxWidget extends StatefulWidget {

  const _CheckBoxWidget({
    required this.child, 
    this.isSelected, 
    this.onChanged,
  });
  
  final Widget child;
  final bool? isSelected;
  final ValueChanged<bool?>? onChanged;

  @override
  CheckBoxState createState() => CheckBoxState();
}

class CheckBoxState extends State<_CheckBoxWidget> {
  bool? isSelected;

  @override
  void initState() {
    super.initState();
    isSelected = widget.isSelected;
  }

  @override
  void didUpdateWidget(covariant _CheckBoxWidget oldWidget) {
    if (widget.isSelected != isSelected) isSelected = widget.isSelected;
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const SizedBox(height: 16,),
            const Text('すべて選択: '),
            Checkbox(
              value: isSelected,
              tristate: true,
              onChanged: (bool? v) {
                v ??= false;
                setState(() {
                  isSelected = v;
                  if (widget.onChanged != null) widget.onChanged?.call(v);
                });
              },
            ),
            MySpacing.height(4),
          ],
        ),
        Expanded(child: widget.child),
      ],
    );
  }
}
