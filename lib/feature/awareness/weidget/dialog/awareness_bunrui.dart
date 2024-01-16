import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kyoumutechou/feature/awareness/provider/awareness_meibo_provider.dart';
import 'package:kyoumutechou/feature/boxes.dart';
import 'package:kyoumutechou/feature/common/provider/dantais_provider.dart';


class AwarenessBunrui extends ConsumerWidget {
  const AwarenessBunrui({super.key});

  Widget _buildRadioButton(WidgetRef ref, String value, String name) {
    return InkWell(
      onTap: () {
        ref.read(awarenessBunruiProvider.notifier).state = value;
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8,4,8,4),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Radio<String>(
              value: value,
              groupValue: ref.watch(awarenessBunruiProvider),
              onChanged: (String? newValue) {
                ref.read(awarenessBunruiProvider.notifier).state = newValue!;
              },
            ),
            Text(name),
          ],
        ),
      ),
    );
  }  

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dantaiId = ref.watch(dantaiProvider).id;
    final box = Boxes.getBunruiBox();

    final keys = box.keys.toList().where(
          (element) =>
              element.toString().startsWith('$dantaiId-'),
        );
    
    if (keys.isEmpty) {
      return const SizedBox();
    }

    final codeList = keys.map(box.get).toList(); 
    codeList.sort((a, b) => '${a?.code}'.compareTo('${b?.code}'),);


    return codeList.isEmpty
        ? Container(
            color: Colors.red,
          )
        : Wrap(
            children: codeList
                .map(
                  (e) => _buildRadioButton(ref, '${e?.code}', '${e?.name}'),
                )
                .toList(),
          );
  }
}
