import 'package:intl/intl.dart';
import 'package:tuple/tuple.dart';

class DateUtil {
  // 5.01(日)
  static String getWeekDate(DateTime date) {
    String week, month, day;
    month = date.month.toString();
    day = NumberFormat('00').format(date.day);
    week = DateFormat.E('ja').format(date).toString();
    return '$month.$day（$week）';
  }

  // 8月29日(月)
  static String getJpMonthDayWeek(DateTime date) {
    String week, month, day;
    month = date.month.toString();
    day = date.day.toString();
    week = DateFormat.E('ja').format(date).toString();
    return '$month月$day日（$week）';
  }

  // (yyyy)2023
  static String getYear(DateTime date) {
    return date.year.toString();
  }

  // (yyyy)12
  static String getMonth(DateTime date) {
    return NumberFormat('00').format(date.month);
  }

  // (yyyy)12
  static String getDay(DateTime date) {
    return NumberFormat('00').format(date.day);
  }

// (yyyy-mm-dd hh:mm:ss)
  static String getStringDateWithMinus(DateTime date) {
    return '${date.year}-${NumberFormat('00').format(date.month)}-${NumberFormat('00').format(date.day)}';
  }

  // yyyyMMdd_HHmmss.SSS
  static String getDatetimeStamp() {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
    final formattedDate = DateFormat('yyyyMMdd_HHmmss.SSS').format(dateTime);

    return formattedDate;
  }

  // yyyy-mm-dd
  static String getStringDate(DateTime date) {
    return '${date.year}-${NumberFormat('00').format(date.month)}-${NumberFormat('00').format(date.day)}';
  }

  // R04.05.01
  static String getJapaneseDate(DateTime date) {
    String year, month, day;
    year = _convertYearRoman(date.year);
    month = NumberFormat('00').format(date.month);
    day = NumberFormat('00').format(date.day);

    return '$year.$month.$day';
  }

  // 05.01 08:00
  static String getStringDateWithTime(DateTime? date) {
    final targetDate = date ?? DateTime.now();
    return DateFormat('MM.dd HH:mm').format(targetDate);
  }

  // 8月29日
  static String getMonthDay(DateTime? date) {
    final targetDate = date ?? DateTime.now();
    return DateFormat('M月d日').format(targetDate);
  }  

//  static List<DateTime> getTokobis(){
//    final now = DateTime.now();
//    final year = now.year;
//    final month = now.month;
//    final day = now.day;
//    final daysInMonth = DateTime(year, month + 1, 0).day;
//    final firstDay = DateTime(year, month, 1);
//    final lastDay = DateTime(year, month, daysInMonth);
//    final firstDayOfWeek = firstDay.weekday;
//    final lastDayOfWeek = lastDay.weekday;
//    final firstMonday = firstDay.subtract(Duration(days: firstDayOfWeek - 1));
//    final lastSunday = lastDay.add(Duration(days: DateTime.daysPerWeek - lastDayOfWeek));
//
//    final days = lastSunday.difference(firstMonday).inDays + 1;
//    final weeks = (days / DateTime.daysPerWeek).ceil();
//
//    final List<DateTime> dates = [];
//    for (var i = 0; i < weeks; i++) {
//      for (var j = 0; j < DateTime.daysPerWeek; j++) {
//        dates.add(firstMonday.add(Duration(days: j + i * DateTime.daysPerWeek)));
//      }
//    }
//
//    return dates;
//  }

  // last day of prior month.
  // static DateTime? getLastDayOfPriorMonth(DateTime date) {

  //   // 当月１日からdateまで出勤日数の算出
  //   final firstDayOfMonth = DateTime(date.year, date.month);
  //   var workingDays = 0;
  //   for (DateTime i = firstDayOfMonth;
  //       i.isBefore(date);
  //       i = i.add(Duration(days: 1))) {
  //     // 月から金までの出勤日数をカウント
  //     if (i.weekday != DateTime.saturday && i.weekday != DateTime.sunday) {
  //       workingDays++;
  //     }
  //   }

  //   if (workingDays < 3 ) {
  //     if (date.month == 4) {
  //       return null;
  //     }

  //     final previousMonth = DateTime(date.year, date.month - 1);
  //     return previousMonth;
  //   }

  //   return null;
  // }

  // begindate , enddate (4/1~3/31)
  static Tuple2<DateTime, DateTime> calculateFiscalYear(
    DateTime? date,
  ) {

    int startYear;
    DateTime fiscalYearStart;
    DateTime fiscalYearEnd;

    date ??= DateTime.now();

    if (date.month < 4) {
      startYear = date.year - 1;
      fiscalYearStart = DateTime(startYear, 4);
      fiscalYearEnd = DateTime(date.year, 3, 31);
    } else {
      startYear = date.year;
      fiscalYearStart = DateTime(startYear, 4);
      fiscalYearEnd = DateTime(startYear + 1, 3, 31);
    }

    return Tuple2(fiscalYearStart, fiscalYearEnd);
  }

  static String _convertYearJapanese(int year) {
    if (year < 1868) {
      return '${NumberFormat('00').format(year)}';
    } else if (year < 1912) {
      return '明治${NumberFormat('00').format(year - 33 - 1900)}年';
    } else if (year < 1926) {
      return '大正${NumberFormat('00').format(year - 11 - 1900)}年';
    } else if (year < 1989) {
      return '昭和${NumberFormat('00').format(year - 25 - 1900)}年';
    } else if (year < 2019) {
      return '平成${NumberFormat('00').format(year + 12 - 2000)}年';
    } else {
      return '令和${NumberFormat('00').format(year - 18 - 2000)}年';
    }
  }

  static String _convertYearRoman(int year) {
    if (year < 1868) {
      return '${NumberFormat('00').format(year)}';
    } else if (year < 1912) {
      return 'M${NumberFormat('00').format(year - 33 - 1900)}';
    } else if (year < 1926) {
      return 'T${NumberFormat('00').format(year - 11 - 1900)}';
    } else if (year < 1989) {
      return 'S${NumberFormat('00').format(year - 25 - 1900)}';
    } else if (year < 2019) {
      return 'H${NumberFormat('00').format(year + 12 - 2000)}';
    } else {
      return 'R${NumberFormat('00').format(year - 18 - 2000)}';
    }
  }
}
