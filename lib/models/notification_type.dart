class NotificationEnum {
  static String cleaning = "cleaning";
  static String arrival = "arrival";
  static String checkin = "checkin";
  static String checkout = "checkout";
  static String issue = "issue";
  static String preCheckin = "pre check-in prep";
  static String postCheckout = "post check-out prep";
  static String service = "service";


  static String getTaskMessage(String type, String yachtName){

    return type + " for yacht " + yachtName;
  }
}