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
    this.maxTime = maxTime ?? DateTime(2049, 12, 31);
    this.minTime = minTime ?? DateTime(1970, 1, 1);

    int minMonth = 1;
    int minDay = 1;

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
    setLeftIndex(this.currentSakaTime.year - this.currentSakaTime.startYear);
    setMiddleIndex(this.currentTime.month - minMonth);
    setRightIndex(this.currentTime.day - minDay);
  }

  // Returns max month of a given month
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
    for (int ii = this.currentSakaTime.year - 5; ii < 10; ii++) {
      this.leftList.add(ii.toString());
    }
  }

  void _fillMiddleLists() {
    this.middleList = this.currentSakaTime.months();
  }

  void _fillRightLists() {
    int maxDay =
        _maxDayOfCurrentMonth(currentMiddleIndex(), currentRightIndex());
    int minDay = 1;
    for (int ii = minDay; ii <= maxDay; ii++) {
      this.rightList.add(ii.toString());
    }
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
    if (index >= 1 && index <= middleList.length) {
      return middleList[index];
    } else {
      return null;
    }
  }

  @override
  String rightStringAtIndex(int index) {
    if (index >= 1 && index <= 31) {
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
    return [4, 1, 1];
  }

  @override
  DateTime finalTime() {
    currentSakaTime.year = int.parse(leftList[currentLeftIndex()]);
    currentSakaTime.month = int.parse(middleList[currentMiddleIndex()]);
    currentSakaTime.day = int.parse(rightList[currentRightIndex()]);
    currentTime = convertToGregorianDate(currentSakaTime);
    return currentTime;
  }
}
