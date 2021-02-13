class SakaStruct {
  int _day = 0;
  int _month = 0;
  int _year = 0;
  int _weekday = 0;
  bool _leap = false;

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

  String toString() {
    //TODO: Check if the date is valid
    String dateStr;

    switch(this.month) {
      case 1:
        dateStr += "Chaitra ";
        break;
      case 2:
        dateStr += "Vaisakha ";
        break;
      case 3:
        dateStr += "Jyēshtha";
        break;
      case 4:
        dateStr += "Āshādha";
        break;
      case 5:
        dateStr += "Shrāvana";
        break;
      case 6:
        dateStr += "Bhaadra";
        break;
      case 7:
        dateStr += "Āshwin";
        break;
      case 8:
        dateStr += "Kārtika";
        break;
      case 9:
        dateStr += "Agrahayana";
        break;
      case 10:
        dateStr = "Pausha";
        break;
      case 11:
        dateStr += "Magha";
        break;
      case 12:
        dateStr += "Phalguna";
        break;
      default:
        break;
    }

    return dateStr + " " + this._day.toString() + ", " + this._year.toString();
  }
}