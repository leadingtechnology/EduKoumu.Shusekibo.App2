
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum PageType { seat, list }

final buttonEnableProvider = StateProvider<bool>((ref) {
  return false; 
});
