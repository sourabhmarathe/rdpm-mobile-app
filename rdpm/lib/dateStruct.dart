class DateStruct {
  int _day = 0;
  int _month = 0;
  int _year = 0;
  int _weekday = 0;
  bool _leap = false;

  set year(int new_year) {
    this._year = new_year;
  }

  set weekday(int dow) {
    this._weekday = dow;
  }

  bool get leap {
    return this._leap;
  }

  set leap(bool isLeapYear) {
    this._leap = isLeapYear;
  }
}