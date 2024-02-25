

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class BlankSeatWidget extends StatelessWidget {
  const BlankSeatWidget({
    required this.width,
    required this.height,
    super.key,
  });

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
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
