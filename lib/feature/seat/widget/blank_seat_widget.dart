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
        child: SizedBox(
          width: 108,
          height: 78,
          //color: Colors.amber,
          child: Icon(
            Icons.chair_alt_outlined,
            color: Colors.grey[600],
            size: 30,
          ),
        ),
      ),
    );
  }
}
