import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 出欠（時限）widget
class AttendanceTimedPage extends ConsumerStatefulWidget {
  const AttendanceTimedPage({super.key});

  @override
  AttendanceTimedPageState createState() => AttendanceTimedPageState();
}

class AttendanceTimedPageState extends ConsumerState<AttendanceTimedPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('出欠（時限）'),
      ),
    );
  }
}
