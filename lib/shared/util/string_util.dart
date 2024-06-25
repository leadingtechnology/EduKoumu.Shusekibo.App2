
class StringUtil {
  // 5.01(日)
  static List<Map<int, String>> parseStringToKeyValueList(String input) {
    final keyValueList = <Map<int, String>>[];

    final pairs = input.trim().split(';');

    for (final pair in pairs) {
      // 按逗号分割每个键值对
      final keyValue = pair.split(',');
      if (keyValue.length == 2) {
        final key = int.parse(keyValue[0].trim());
        final value = keyValue[1].trim();
        keyValueList.add({key: value});
      }
    }
    return keyValueList;
  }

}
