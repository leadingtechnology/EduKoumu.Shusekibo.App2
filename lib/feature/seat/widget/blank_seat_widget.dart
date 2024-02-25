

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class BlankSeatWidget extends StatelessWidget {
  const BlankSeatWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 110,
      height: 80,
      child: Center(
        child: DottedBorder(
          dashPattern: const [8, 4],
          strokeWidth: 2,
          color: Colors.grey[400]!,
          borderType: BorderType.RRect,
          radius: const Radius.circular(12),
          child: const SizedBox(
            width: 108,
            height: 78,
            //color: Colors.amber,
            child: Text('　'),
          ),
        ),
      ),
    );
  }
}
