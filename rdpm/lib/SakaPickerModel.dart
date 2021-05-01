import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

import 'calendar.dart';
import 'sakaStruct.dart';

// Picker model for Saka dates
class SakaPickerModel extends CommonPickerModel {
  DateTime maxTime;
  DateTime minTime;
  SakaStruct currentSakaTime;

  SakaPickerModel(
      {DateTime currentTime,
      DateTime maxTime,
      DateTime minTime,
      LocaleType locale})
      : super(locale: locale) {
    this.maxTime = maxTime ?? DateTime(1932, 12, 31);
    this.minTime = minTime ?? DateTime(1972, 1, 1);

    int minMonth = 1;
    int minDay = 1;
    int yearRange = 30;

    this.currentTime = currentTime ?? DateTime.now();
    if (currentTime != null) {
      if (currentTime.compareTo(this.maxTime) > 0) {
        currentTime = this.maxTime;
      } else if (currentTime.compareTo(this.minTime) < 0) {
        currentTime = this.minTime;
      }
    }
    this.currentTime = currentTime;
    this.currentSakaTime = convertToSakaDate(DateTime.now());

    _fillLeftLists();
    _fillMiddleLists();
    _fillRightLists();

    print(currentSakaTime);
    setLeftIndex(yearRange);
    setMiddleIndex(this.currentSakaTime.month - minMonth);
    setRightIndex(this.currentSakaTime.day - minDay);
  }

  // Returns max month of a given month
  //TODO: use this method
  int _maxDayOfCurrentMonth(int month, int year) {
    if (month >= 2 && month <= 5) {
      return 31;
    } else if (month >= 6 && month <= 12) {
      return 30;
    } else {
      if (isSakaLeapYear(year)) {
        return 31;
      } else {
        return 30;
      }
    }
  }

  void _fillLeftLists() {
    int minYear = this.currentSakaTime.year - 30;
    int maxYear = this.currentSakaTime.year + 30;
    print(maxYear);
    this.leftList = List.generate(maxYear - minYear + 1, (int index) {
      return '${minYear + index}';
    });
  }

  void _fillMiddleLists() {
    List<String> months = this.currentSakaTime.months();
    int numMonths = 12;
    this.middleList = List.generate(numMonths, (int index) {
      return '${months[index]}';
    });
  }

  void _fillRightLists() {
    int maxDay = 31;
    int minDay = 1;
    this.rightList = List.generate(maxDay - minDay + 1, (int index) {
      return '${minDay + index}';
    });
  }

  @override
  String leftStringAtIndex(int index) {
    if (index >= 0 && index < leftList.length) {
      return leftList[index];
    } else {
      return null;
    }
  }

  @override
  String middleStringAtIndex(int index) {
    if (index >= 0 && index < middleList.length) {
      return middleList[index];
    } else {
      return null;
    }
  }

  @override
  String rightStringAtIndex(int index) {
    if (index >= 0 && index < 31) {
      return rightList[index];
    } else {
      return null;
    }
  }

  @override
  String leftDivider() {
    return "|";
  }

  @override
  String rightDivider() {
    return "|";
  }

  @override
  List<int> layoutProportions() {
    return [1, 1, 1];
  }

  @override
  DateTime finalTime() {
    currentSakaTime.year = currentLeftIndex();
    currentSakaTime.month = currentMiddleIndex() + 1;
    currentSakaTime.day = currentRightIndex() + 1;
    currentTime = convertToGregorianDate(currentSakaTime);
    return currentTime;
  }
}
