import 'package:intl/intl.dart';

class Formats {

  static getDateOnlyFormat(){

    return DateFormat("dd.MM.yyyy");
  }

  static getDateTimeStandardFormat(){

    return DateFormat("dd.MM.yyyy HH:mm:ss");
  }

  static getTimeStandardFormat(){

    return DateFormat("hh:mm:ss");
  }

  static bookingManagerDateTimeFormat(){
    return DateFormat("yyyy-MM-dd hh:mm:ss");
  }

  static mobileAppDateTimeFormat(){
    return DateFormat("yyyy-MM-ddTHH:mm:ss");
  }

  ///CURRENCY FORMATS
  static getCurrencyFormat(){
    return NumberFormat("#,##0.00", "en_US");
  }

}