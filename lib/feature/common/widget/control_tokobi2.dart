import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kyoumutechou/feature/common/provider/tokobis_provider.dart';
import 'package:kyoumutechou/helpers/theme/app_theme.dart';

class ControlTokobi2 extends ConsumerWidget {
  const ControlTokobi2({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(tokobisProvider);

    return state.when(
      loading: () {return const SizedBox();},
      error: (error) {return Text('$error');},
      loaded: () {
        final tokobi = ref.watch(tokobiProvider);
        return Text(
          //'${DateUtil.getDay(tokobi.tokobi??DateTime.now())}:${tokobi.isEditable}',
          '.',
          style: TextStyle(
            color: theme.colorScheme.surface,
            fontSize: 30,
          ),
        );
      },
    );
  }
}
