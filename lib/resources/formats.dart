import 'package:intl/intl.dart';

class Formats {

  static getDateOnlyFormat(){

    return DateFormat("dd.MM.yyyy");
  }

  static getDateTimeStandardFormat(){

    return DateFormat("dd.MM.yyyy hh:mm:ss");
  }

  static bookingManagerDateTimeFormat(){
    return DateFormat("yyyy-MM-dd hh:mm:ss");
  }

  static mobileAppDateTimeFormat(){
    return DateFormat("yyyy-MM-ddThh:mm:ss.SSS");
  }

  ///CURRENCY FORMATS
  static getCurrencyFormat(){
    return NumberFormat("#,##0.00", "en_US");
  }

}