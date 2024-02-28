
import 'package:flutter/material.dart';
import 'package:kyoumutechou/helpers/widgets/my_text.dart';

class LecternWidget extends StatelessWidget {
  const LecternWidget({
    this.title = '　教　卓　',
    super.key,
  });

  final String? title;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.green.shade200,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
          //border: Border.all(color: Colors.green.shade200),
          borderRadius: BorderRadius.circular(1),
        ),
        width: 200,
        height: 30,
        child: Center(child: MyText.bodyLarge('$title')),
      ),
    );
  }
}
