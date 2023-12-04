
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 出欠（日）widget
class HealthListWidget extends ConsumerWidget {
  const HealthListWidget({super.key});


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Text('健康リスト');
  }
}
