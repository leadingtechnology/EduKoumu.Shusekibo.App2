import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kyoumutechou/feature/awareness/provider/awareness_code_provider.dart';
import 'package:kyoumutechou/feature/awareness/provider/awareness_meibo_provider.dart';
import 'package:kyoumutechou/feature/boxes.dart';
import 'package:kyoumutechou/shared/http/app_exception.dart';


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
              onChanged: (String? newValue) {},
            ),
            Text(name),
          ],
        ),
      ),
    );
  }  

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(awarenessCodeListProvider);
    
    return state.when(
      loading: () {
        return const Center(child: CircularProgressIndicator());
      },
      error: (AppException error) { return Text('$error'); },
      loaded: () {
        final codeList = Boxes.getBunruiBox.values.toList();
        
        return codeList.isEmpty
            ? Container(color: Colors.red,)
            :
        Wrap(
          children: codeList
              .map(
                (e) => _buildRadioButton(ref, '${e.code}', '${e.name}'),
              )
              .toList(),
        );
      },
    );
  }
}
