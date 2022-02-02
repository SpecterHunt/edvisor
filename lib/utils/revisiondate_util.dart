// ignore_for_file: avoid_print
import 'package:intl/intl.dart';

class ReviseDateUtil {
  static var curDate = DateTime.now();
  static var newFormat = DateFormat('dd-MM-yyyy');
  static var formattedCurDate = newFormat.format(curDate);

  // static late DateTime firstRevDate;
  // static late DateTime secondRevDate;
  List<String> revisionDates({required String difficulty}) {
    List<int> dateList = [];
    List<String> revDateList = [];
    switch (difficulty) {
      case "Easy":
        {
          dateList = [1, 7, 30, 60];
          break;
        }
      case "Medium":
        {
          dateList = [1, 7, 14, 30, 60];
          break;
        }
      case "Hard":
        {
          dateList = [1, 2, 7, 14, 30, 60];
          break;
        }
    }
    // revDateList.add(formattedCurDate);

    for (int i = 0; i < dateList.length; i++) {
      var temp = curDate.add(Duration(days: dateList[i]));
      var tempDate = newFormat.format(temp);
      revDateList.add(tempDate);
    }
    return revDateList;

    // firstRevDate = curDate.add(const Duration(days: 1));
    // secondRevDate = curDate.add(const Duration(days: 7));
    // print(firstRevDate);
    // print(secondRevDate);
  }
}
