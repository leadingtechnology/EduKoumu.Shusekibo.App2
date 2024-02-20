import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:kyoumutechou/gen/assets.gen.dart';
import 'package:kyoumutechou/start.dart';

Future<void> main() async {
  await dotenv.load(fileName: Assets.env.envDevelopment);

  await start();
}
