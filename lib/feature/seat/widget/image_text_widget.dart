import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kyoumutechou/feature/attendance/model/attendance_meibo_model.dart';
import 'package:kyoumutechou/helpers/theme/app_theme.dart';
import 'package:kyoumutechou/helpers/widgets/my_container.dart';
import 'package:kyoumutechou/helpers/widgets/my_spacing.dart';
import 'package:kyoumutechou/helpers/widgets/my_text.dart';

class ImageTextWaabbccidget extends StatelessWidget {
  const ImageTextWaabbccidget({
    required this.x,
    required this.y,
    required this.width,
    required this.height,
    required this.url,
    required this.accessToken,
    required this.buttonText,
    required this.onPressed,
    required this.onDrag,
    super.key,
  });

  final double x;
  final double y;
  final double width;
  final double height;
  final String url;
  final String accessToken;
  final String buttonText;
  final void Function()? onPressed;
  final void Function()? onDrag;

  static const margin = 2.0;

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 500),
      left: x,
      top:y,
      child: Draggable(
        feedback: _seatWidget(),
        childWhenDragging: _seatWidget(),
        onDragStarted: onDrag,
        child: _seatWidget(),
        onDraggableCanceled: (velocity, offset) {},
      ),
    );
  }

  Widget _seatWidget() {
    return Container(
      width: width - margin * 2,
      height: height - margin * 2,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0, 5),
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0,5,0,0),
            child: CircleAvatar(
              backgroundImage: NetworkImage(
                url,
                headers: {
                  'Authorization': 'Bearer $accessToken',
                },
              ),
              radius: 30,
            ),
          ),
          Text(buttonText),
        ],
      ),
    );
  }
}

// 占位ウィジェット
class PlaceholderWidget extends StatelessWidget {
  const PlaceholderWidget({
    required this.width, 
    required this.height, 
    super.key,
  });

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(8),
      width: width,
      height: height,
    );
  }
}

Widget singleSeito(AttendanceMeiboModel meibo) {
  final _baseUrl = dotenv.env['BASE_URL']!;
  final accessToken = Hive.box<String>('shusekibo').get('token').toString();
  final url = '$_baseUrl${meibo.photoUrl}';

  return Container(
    padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
    margin: const EdgeInsets.fromLTRB(8, 8, 8, 8),
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
      border: Border.all(
        color: Colors.green.shade200, 
      ),
      borderRadius: BorderRadius.circular(12), 
    ),
    child: Column(
      children: [
        CircleAvatar(
          backgroundImage: NetworkImage(
            url,
            headers: {
              'Authorization': 'Bearer $accessToken',
            },
          ),
          radius: 30,
        ),
        MySpacing.height(8),
        MyText.bodySmall(
          meibo.name ?? '',
          color: theme.colorScheme.primary,
        ),
      ],
    ),
  );
}
