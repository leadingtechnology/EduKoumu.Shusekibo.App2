
import 'package:flutter/material.dart';
import 'package:kyoumutechou/feature/common/widget/globals.dart';
import 'package:kyoumutechou/helpers/widgets/my_spacing.dart';


class SeitoWidget extends StatelessWidget {
  const SeitoWidget({
    required this.studentName, required this.studentId, super.key,
  });
  
  final int studentId;
  final String studentName;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
            height: 32,
            child: ClipOval(
              child: Image.asset(getPic(studentId)),
            ),),
        MySpacing.width(2),
        Text(studentName),
        MySpacing.width(4),
      ],
    );
  }
}
