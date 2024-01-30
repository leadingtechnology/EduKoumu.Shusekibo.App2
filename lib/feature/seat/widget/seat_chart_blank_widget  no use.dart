import 'package:flutter/material.dart';

class SeatChartBlankWidget111 extends StatelessWidget {
  const SeatChartBlankWidget111({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Draggable(
      feedback: buildContainer(),
      childWhenDragging: buildContainer(),
      child: buildContainer(),
    );
  }

  Widget buildContainer() {
    return Container(
      width: 90,
      height: 70,
      padding: const EdgeInsets.fromLTRB(4, 4, 4, 4),
      margin: const EdgeInsets.fromLTRB(2, 2, 2, 2),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
        border: Border.all(color: Colors.green.shade200),
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Center(
        child: Text(
          '(席無し)',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 16,
            color: Colors.black,
            decoration: TextDecoration.none,
          ),
        ),
      ),
    );
  }
}
