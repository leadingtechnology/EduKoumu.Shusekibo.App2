import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kyoumutechou/feature/common/model/dantai_model.dart';
import 'package:kyoumutechou/feature/common/provider/dantais_provider.dart';

class DantaiDropdownWidget extends ConsumerWidget {
  const DantaiDropdownWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dantaiList = ref.watch(dantaisProvider);
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
