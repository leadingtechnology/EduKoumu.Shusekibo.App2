import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 気づきwidget
class AwarenessPage extends ConsumerStatefulWidget {
  const AwarenessPage({super.key});

  @override
  AwarenessPageState createState() => AwarenessPageState();
}

class AwarenessPageState extends ConsumerState<AwarenessPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('気づき'),
      ),
    );
  }
}
