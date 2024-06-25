

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kyoumutechou/feature/auth/provider/auth_provider.dart';
import 'package:kyoumutechou/helpers/theme/app_theme.dart';

class DantaiSelectionDialog extends ConsumerStatefulWidget {
  const DantaiSelectionDialog(
      {required this.dantaiId, required this.dantais, super.key,});

  final int dantaiId ;
  final List<Map<int, String>> dantais;

  @override
  ConsumerState<DantaiSelectionDialog> createState() =>
      _DantaiSelectionDialogState();
}

class _DantaiSelectionDialogState extends ConsumerState<DantaiSelectionDialog> {
  
  int? dantaiId;

  @override
  void initState() {
    super.initState();

    dantaiId = widget.dantaiId;
  }


  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Container(
        height: 240,
        width: 240 * 2.5,
        decoration: BoxDecoration(
          color:  theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 4),
              alignment: Alignment.center,
              child: const Text(
                '所属の選択',
                style: TextStyle(
                  fontWeight: FontWeight.bold, 
                  fontSize: 18, 
                ),
              ),
            ),
            const Divider(),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(16, 0, 12, 0),
                  alignment: Alignment.center,
                  child: const Text(
                    '所属',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 46,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: DropdownButton<int>(
                      value: dantaiId,
                      isExpanded: true,
                      elevation: 16,
                      style: const TextStyle(color: Colors.black, fontSize: 18),
                      dropdownColor: Colors.white,
                      underline: Container(
                        height: 2,
                        color: Colors.white,
                      ),
                      items: widget.dantais.map((Map<int, String> item) {
                        final key = item.keys.first;
                        final value = ' ${item.values.first}' ;
                        return DropdownMenuItem<int>(
                          value: key,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (int? newValue) {
                        setState(() {
                          dantaiId = newValue;
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(width: 16),
              ],
            ),          
            Expanded(child: Container()),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.close),
                    label: const Text(
                      '閉じる',
                      style: TextStyle(color: Colors.black),
                    ),
                    onPressed: () {
                      ref.read(authNotifierProvider.notifier).logout();
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
                ),

                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 12, 0),
                  child: SizedBox(
                    width: 130,
                    child: ElevatedButton.icon(
                      onPressed: dantaiId == null || dantaiId! < 0
                          ? null
                          : () async {
                              await Hive.box<String>('shusekibo')
                                  .put('dantaiId', '$dantaiId');
                  
                              await ref
                                  .read(authNotifierProvider.notifier)
                                  .changeDantai(dantaiId!);
                  
                              Navigator.of(context).pop(dantaiId);
                            },
                      icon: const Icon(Icons.login_outlined), // 这里假设图标是固定的
                      label: const Text('ログイン'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0056d2),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                ),
                
              ],
            ),
          ],
        ),
      ),
    );
  }
}
