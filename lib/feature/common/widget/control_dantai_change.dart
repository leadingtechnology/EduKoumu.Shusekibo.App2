import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kyoumutechou/feature/common/provider/dantai_changed_provider.dart';


class ControlDantaiChange extends ConsumerWidget {
  const ControlDantaiChange({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(dantaiChangedProvider);

    return state.when(
      loading: () {return const SizedBox();},
      error: (error) {return Text('$error');},
      loaded: () {
        return const Text('- OK -');
      },
    );
  }
}
