# rdpm-mobile-app
Flutter based application for RDPM

## About
This repo contains the source code for a mobile app that converts dates between Gregorian and Saka calendars.

## Installing Flutter
Go to flutter's website for information on installing flutter: https://flutter.dev/docs/get-started/install

Use Android Studion as an IDE to develop and simulate the app during development: https://developer.android.com/studio

## Source Code
The following is a quick explanation about what each dart file does. They can all be found under rdpm/lib/.
### main.dart
This is the UI page for the app. It is responsible for handling interactions with the user. Since this app only has one page, this will be the only source file with UI oriented code on it.
### calendar.dart
This file contains the algorithms for converting between dart's standard library DateTime objects and our custom SakaStruct objects. The conversion works by translating a given date to a common Julian Chronological Day (jdn) and coverting that to either Gregorian or Saka time. There are also some helper functions in this file for getting this done.
### sakaPicker.dart
This file contains a custom implementation of CommonPickerModel. More information can be found here: https://pub.dev/packages/flutter_datetime_picker
This will allow the app to display a Saka months/days and its years in main.dart when a user wants to translate a Saka date into a Gregorian date.
### sakaStruct.dart
This file provides a simple class to track days/months/year. It's intended to be a Saka counterpart to a Gregorian DateTime object. It also contains the Saka names for months of the year and days of the week.
