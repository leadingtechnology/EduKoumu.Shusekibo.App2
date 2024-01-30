import 'package:flutter/material.dart';

class SeatChartBlankChairWidget111 extends StatelessWidget {
  const SeatChartBlankChairWidget111({
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
      //margin: const EdgeInsets.fromLTRB(2, 2, 2, 2),
      decoration: BoxDecoration(
        color: Colors.yellow,
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
      child: Column(
        children: [
          Icon(
            Icons.chair_alt_outlined,
            color: Colors.grey[600],
            size: 40,
          ),
          const Text(
            '空席',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 12,
              color: Colors.black,
              decoration: TextDecoration.none,
            ),
          ),
        ],
      ),
    );
  }
}
