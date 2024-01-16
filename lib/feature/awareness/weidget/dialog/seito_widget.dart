
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kyoumutechou/helpers/widgets/my_spacing.dart';


class SeitoWidget extends StatelessWidget {
  SeitoWidget({
    required this.studentName, 
    required this.studentId, 
    required this.photoUrl,
    super.key,
  });
  
  final int studentId;
  final String studentName;
  final String photoUrl;

  final String _baseUrl = dotenv.env['BASE_URL']!;
  String accessToken = Hive.box<String>('shusekibo').get('token').toString();

  @override
  Widget build(BuildContext context) {
    final url = '$_baseUrl$photoUrl';

    return Row(
      children: [
        SizedBox(
            height: 32,
            child: ClipOval(
              child: Image.network(
              url,
              headers: {'Authorization': 'Bearer $accessToken'},
            ),
            ),),
        MySpacing.width(2),
        Text(studentName),
        MySpacing.width(4),
      ],
    );
  }
}
