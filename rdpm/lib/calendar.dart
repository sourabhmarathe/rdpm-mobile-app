/* The purpose of this file is to provide translation service between the
* Gregorian and Saka calendars. It will be assumed that the Gregorian calendar
* can be represented using the native DateTime class that comes prepackaged with
* Dart as part of its standard library. We will create a custom SakaTime class
* to handle Indian National Calendar datetime objects.
* */
import 'dart:math';

import 'sakaStruct.dart';

int trunc(double val) {
  if(val >= 0) {
    return val.ceil();
  } else {
    return val.floor();
  }
}

// Modulus function that works for non-integers
int mod(double a, int b) {
  return (a.floor() - (b.floor() * (a/b).floor())).floor();
}

// Return day of the week
int dow(double jdn) {
  return mod((jdn + 1.5).floor().toDouble(), 7);
}

// Return if a year is a leap year in Gregorian
bool isGregorianLeapYear(int year) {
  return ((year % 4) == 0) && (!(((year % 100) == 0) && ((year % 400) != 0)));
}

// Return JDN for a given Gregorian DateTime object
double gregorianToJDN(DateTime dt) {
  int month = dt.month;
  int year = dt.year;
  int day = dt.day;

  double jd = 0;

  if(dt.month < 3) {
    month += 12;
    year -= 1;
  }

  // calculate Chronological Julian Day
  jd = day + (((153 * month) - 457) / 5) + (365 * year) + trunc(year / 4)
      - trunc(year / 100) + trunc(year / 400) + 1721118.5;
  jd += .5;
  return jd;
}

DateTime JDNToGregorian(double jd) {
  double g, r;
  int z, a, b, c, d, m, y;

  // calculate chronological julian day
  //TODO: Check y and d calculation (extra floor() call at end)
  jd -= 0.5;
  z = (jd - 1721118.5).floor();
  r = jd - 1721118.5 - z;
  g = z - .25;
  a = (g / 36524.25).floor();
  b = a - (a / 4).floor();
  y = ((b + g).floor()/365.25).floor();
  c = b + z - (365.25 * y).floor();
  m = trunc(((5 * c) + 456) / 153);
  d = (c - trunc(((153 * m) - 457) / 5) + r).round();
  if (m > 12)
  {
    y += 1;
    m -= 12;
  }

  DateTime dt = DateTime(y, m, d);
  return dt;
}

double GregorianToJDN(DateTime greg) {
  int y = greg.year;
  int m  = greg.month;
  int d = greg.day;

  double jd = 0;

  if (m < 3)
  {
    m += 12;
    y -= 1;
  }
  jd = d + (((153 * m) - 457) / 5) + (365 * y) + trunc(y / 4) - trunc(y / 100)
      + trunc(y / 400) + 1721118.5;
  jd += 0.5; // calculate Chronological Julian Day

  return jd;
}

SakaStruct JDNToIndianCivil(double jdn) {
  SakaStruct date = new SakaStruct();

  int caitra, saka, start, yday, mday;
  DateTime greg;
  double greg_jdn;

  saka = 79 - 1;   // Offset in years from Saka era to Gregorian epoch
  start = 80;      // Day offset between Saka and Gregorian

  date.weekday = dow(jdn);
  jdn += .5; // Calculate chronological julian day

  jdn = jdn.floor() + 0.5;
  greg = JDNToGregorian(jdn);       // Gregorian date for Julian day
  date.leap = isGregorianLeapYear(greg.year);   // Is this a leap year?
  date.year = greg.year - saka;            // Tentative year in Saka era
  greg_jdn = GregorianToJDN(greg); // jdn at start of Gregorian year
  //TODO: Check if yday is correctly calculated
  yday = (jdn - greg_jdn).round(); // Day number (0 based) in Gregorian year
  caitra = date.leap ? 31 : 30;          // Days in Caitra this year

  if (yday < start)
  {
    //  Day is at the end of the preceding Saka year
    date.year--;
    date.leap = isGregorianLeapYear(date.year+78);
    yday += caitra + (31 * 5) + (30 * 3) + 10 + start;
  }

  yday -= start;
  if (yday < caitra)
  {
    date.month = 1;
    date.day = yday + 1;
  } else
  {
    mday = yday - caitra;
    if (mday < (31 * 5))
    {
      date.month = (mday / 31).floor() + 2;
      date.day = (mday % 31) + 1;
    } else
    {
      mday -= 31 * 5;
      date.month = (mday / 30).floor() + 7;
      date.day = (mday % 30) + 1;
    }
  }
  return date;
}

double IndianCivilToJDN(SakaStruct date) {
  int day = date.day;
  int month = date.month;
  int year = date.year;

  int caitra, gyear, m;
  double start, jdn;
  bool leap;

  gyear = year + 78;
  leap = isGregorianLeapYear(gyear);
  start = GregorianToJDN(
      DateTime(gyear, 3, isGregorianLeapYear(gyear) ? 21 : 22));
  caitra = leap ? 31 : 30;

  if (month == 1)
  {
    jdn = start + (day - 1);
  } else
  {
    jdn = start + caitra;
    m = month - 2;
    m = min(m, 5);
    jdn += m * 31;
    if (month >= 8)
    {
      m = month - 7;
      jdn += m * 30;
    }
    jdn += day - 1;
  }

  jdn += 0.5; // calculate Chronological Julian Day

  return jdn;

}

DateTime convertToGregorianDate(SakaStruct dt) {
  int day = dt.day;
  int month = dt.month;
  int year = dt.year;

  if (year < 79) {
    print('This date is before the start of Saka year 1.\n'
        'Try 22 Mar 79 onwards');
  }
  else if (year == 79 && month < 4 && day < 22) {
    print('This date is before the start of Saka year 1.\n'
        'Try 22 Mar 79 onwards');
  }

  double jdn = IndianCivilToJDN(dt);
  return JDNToGregorian(jdn);
}

SakaStruct convertToSakaDate(DateTime dt) {
  int day = dt.day;
  int month = dt.month;
  int year= dt.year;

  if (year < -79) {
    print('This date is before the start of Gregorian year 1.\n'
        'Try 10 \u092a\u094c\u0937  -79 onwards');
  }
  else if (year == -79 && month < 11 && day < 10) {
    print('This date is before the start of Gregorian year 1.\n'
        'Try 10 \u092a\u094c\u0937  -79 onwards');
  }

  double jdn = GregorianToJDN(dt);
  return JDNToIndianCivil(jdn);
}