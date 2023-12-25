import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kyoumutechou/feature/awareness/provider/awareness_meibo_provider.dart';


class AwarenessDialogMiddleWidget extends ConsumerWidget {
  const AwarenessDialogMiddleWidget({required this.controller, super.key});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final juyo = ref.watch(awarenessJuyoProvider);

    return SizedBox(width: 520, child: Stack(children: [
      
      // input kizuki contents
      TextFormField(
        controller: controller,
        keyboardType: TextInputType.multiline,
        maxLength: 300,
        maxLines: 11,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return '';
          }
          return null;
        },
      ),
      
      // show importent checkbo. 
      Positioned(
        bottom: -14,
        child: SizedBox(
          width: 120,
          child: CheckboxListTile(
            title:const Text('重要', style: TextStyle(fontSize: 14),),
            value:juyo,
            controlAffinity: ListTileControlAffinity.leading,
            onChanged: (bool? value) {
              ref.read(awarenessJuyoProvider.notifier).state = value!;
            },
          ),
        ),
      ),
    ],),);
  }
}
