
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum PageType { seat, list }
enum LecternPosition{top, bottom, left, right}

final buttonEnableProvider = StateProvider<bool>((ref) {
  return false; 
});

final isGenderProvider = StateProvider<bool>((ref) {return false;});

final sysBeginDate = StateProvider<DateTime>((ref) {
  return DateTime.now();
});
final sysEndDate = StateProvider<DateTime>((ref) {
  return DateTime.now();
});

final isContactAllowedProvider = StateProvider<bool>((ref) {
  return false;
});
