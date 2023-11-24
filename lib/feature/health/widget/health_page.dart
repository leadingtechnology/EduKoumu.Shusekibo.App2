import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 健康観察widget
class HealthPage extends ConsumerStatefulWidget {
  const HealthPage({super.key});

  @override
  HealthPageState createState() => HealthPageState();
}

class HealthPageState extends ConsumerState<HealthPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('健康観察'),
      ),
    );
  }
}
