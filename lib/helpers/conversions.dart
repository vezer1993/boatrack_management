import 'package:intl/intl.dart';

import '../resources/formats.dart';

class Conversion{

  static String priceConversion(double price){
    NumberFormat nf = Formats.getCurrencyFormat();
    return nf.format(price);
  }

  static DateTime convertUtcTimeDateTime(String dateTime){
    DateFormat df = Formats.bookingManagerDateTimeFormat();
    return df.parse(dateTime);
  }

  static DateTime convertISOMobileStringToDateTime(String dateTime){
    DateFormat df = Formats.mobileAppDateTimeFormat();
    return df.parse(dateTime);
  }

  static String convertISOTimeToStandardFormat(String dateTime){
    DateFormat df = Formats.mobileAppDateTimeFormat();
    DateFormat dfStandard = Formats.getDateOnlyFormat();


    return dfStandard.format(df.parse(dateTime));
  }

  static String convertISOTimeToStandardFormatWithTime(String dateTime){
    DateFormat df = Formats.mobileAppDateTimeFormat();
    DateFormat dfStandard = Formats.getDateTimeStandardFormat();


    return dfStandard.format(df.parse(dateTime));
  }

  static String convertISOTimeToStandardFormatOnlyTime(String dateTime){
    DateFormat df = Formats.mobileAppDateTimeFormat();
    DateFormat dfStandard = Formats.getTimeStandardFormat();


    return dfStandard.format(df.parse(dateTime));
  }

  static String convertUtcTimeToStandardFormat(String dateTime){
    DateFormat df = Formats.bookingManagerDateTimeFormat();
    DateFormat dfStandard = Formats.getDateOnlyFormat();


    return dfStandard.format(df.parse(dateTime));
  }



}