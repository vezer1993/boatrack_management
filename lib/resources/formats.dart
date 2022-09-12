import 'package:intl/intl.dart';

class Formats {

  static getDateOnlyFormat(){

    return DateFormat("dd.MM.yyyy");
  }

  static bookingManagerDateTimeFormat(){
    return DateFormat("yyyy-MM-dd hh:mm:ss");
  }

  ///CURRENCY FORMATS
  static getCurrencyFormat(){
    return NumberFormat("#,##0.00", "en_US");
  }

}