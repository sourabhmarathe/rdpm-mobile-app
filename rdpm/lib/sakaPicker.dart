import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

import 'calendar.dart';
import 'sakaStruct.dart';

// Picker model for Saka dates
class SakaPicker extends CommonPickerModel {
  SakaStruct currentSakaTime;

  String digits(int value, int length) {
    return '$value'.padLeft(length, "0");
  }

  SakaPicker({DateTime currentTime}) {
    this.currentTime = currentTime ?? DateTime.now();
    this.currentSakaTime = convertToSakaDate(DateTime.now());
    this.setLeftIndex(this.currentSakaTime.year);
    this.setMiddleIndex(this.currentSakaTime.month);
    this.setRightIndex(this.currentSakaTime.day);
  }

  @override
  String leftStringAtIndex(int index) {
    if (index >= 0 && index < 9999) {
      return this.digits(index, 4);
    } else {
      return null;
    }
  }

  @override
  String middleStringAtIndex(int index) {
    if (index >= 1 && index <= 12) {
      return this.currentSakaTime.months()[index];
    } else {
      return null;
    }
  }

  //TODO: Account for leap years
  @override
  String rightStringAtIndex(int index) {
    if (index >= 1 && index <= 31) {
      return digits(index, 2);
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
    return [10, 4, 2];
  }

  @override
  DateTime finalTime() {
    currentSakaTime.year = currentLeftIndex();
    currentSakaTime.month = currentMiddleIndex();
    currentSakaTime.day = currentRightIndex();
    currentTime = convertToGregorianDate(currentSakaTime);
    return currentTime;
  }
}
