import 'package:intl/intl.dart';

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
    day = NumberFormat('00').format(date.day);
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

  // yyyy-mm-dd
  static String getStringDate(DateTime date) {
    return '${date.year}-${NumberFormat('00').format(date.month)}-${NumberFormat('00').format(date.day)}' ;
  } 

  // R04.05.01
  static String getJapaneseDate(DateTime date){
    
    String year, month, day; 
    year = _convertYearRoman(date.year);
    month = NumberFormat('00').format(date.month);
    day =  NumberFormat('00').format(date.day);

    return '$year.$month.$day';
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
