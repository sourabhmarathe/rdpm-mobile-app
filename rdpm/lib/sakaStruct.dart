class SakaStruct {
  int _day = 0;
  int _month = 0;
  int _year = 0;
  int _weekday = 0;
  bool _leap = false;

  int _startYear = 78;
  List<String> _months = [
    "Chhaitra",
    "Vaishakha",
    "Jyeshtha",
    "Ashadha",
    "Shravana",
    "Bhaadra",
    "Ashwin",
    "Kartika",
    "Agrahayana",
    "Pausha",
    "Magha",
    "Phalguna"
  ];
  List<String> _daysOfWeek = [
    "Raivara",
    "Somvara",
    "Mangalvara",
    "Budhvara",
    "Brahaspativara",
    "Sukravara",
    "Sanivara"
  ];

  int get day {
    return this._day;
  }

  set day(int new_day) {
    this._day = new_day;
  }

  int get month {
    return this._month;
  }

  set month(int new_month) {
    this._month = new_month;
  }

  int get year {
    return this._year;
  }

  set year(int new_year) {
    this._year = new_year;
  }

  get weekday {
    return this._weekday;
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

  int get startYear {
    return this._startYear;
  }

  List<String> months() {
    return this._months;
  }

  String toString() {
    return _daysOfWeek[_weekday] +
        ", " +
        _months[this._month] +
        " " +
        this._day.toString() +
        ", " +
        this._year.toString();
  }
}
