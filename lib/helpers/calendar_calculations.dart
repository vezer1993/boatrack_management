import '../resources/formats.dart';
import 'package:intl/intl.dart';

class CalendarCalculations {

  //calculating weeks from saturday to saturday
  List<String> calculateBookingWeeks(){

    //Define used variables
    List<String> weeks = [];
    DateFormat df = Formats.getDateOnlyFormat();

    //get the first day of the year
    DateTime date = DateTime(DateTime.now().year, 1, 1);
    date = getNextSaturdayForDate(date);

    int currentYear = date.year;
    while(date.year <= currentYear){
      weeks.add(df.format(date));
      date = DateTime(date.year, date.month, date.day + 7);
    }

    return weeks;
  }

  // Next saturday for given date
  DateTime getNextSaturdayForDate(DateTime date){
    while(date.weekday != 6){
      date = DateTime(date.year, date.month, date.day + 1);
    }
    return date;
  }

  // Returns Week number for today
  int getTodayWeekNumber(){
    return weekNumber(DateTime.now());
  }

  int getWeekNumberForDate(DateTime date){
    return weekNumber(date);
  }

  /// Calculates number of weeks for a given year as per https://en.wikipedia.org/wiki/ISO_week_date#Weeks_per_year
  int numOfWeeks(int year) {
    DateTime dec28 = DateTime(year, 12, 28);
    int dayOfDec28 = int.parse(DateFormat("D").format(dec28));
    return ((dayOfDec28 - dec28.weekday + 10) / 7).floor();
  }

  /// Calculates week number from a date as per https://en.wikipedia.org/wiki/ISO_week_date#Calculation
  int weekNumber(DateTime date) {
    int dayOfYear = int.parse(DateFormat("D").format(date));
    int woy =  ((dayOfYear - date.weekday + 10) / 7).floor();
    if (woy < 1) {
      woy = numOfWeeks(date.year - 1);
    } else if (woy > numOfWeeks(date.year)) {
      woy = 1;
    }
    woy;

    if(date.weekday == 6 || date.weekday == 7){
      woy++;
    }
    return woy;
  }
}