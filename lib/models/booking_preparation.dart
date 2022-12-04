import 'package:boatrack_management/models/check_in_out.dart';
import 'package:boatrack_management/models/cleaning.dart';

class BookingPreparation {

  CheckInOut? checkIn;
  CheckInOut? checkOut;
  Cleaning? cleaning;
  bool? guestsArrived;


  BookingPreparation.fromJson(Map<String, dynamic> json) {
    checkIn =
    json['checkin'] != null ? CheckInOut.fromJson(json['checkin']) : null;
    checkOut = json['checkout'] != null ? CheckInOut.fromJson(json['checkout']) : null;
    cleaning = json['cleaning'] != null ? Cleaning.fromJson(json['cleaning']) : null;
    if(json['guestsArrived'] != null){
      guestsArrived = json['guestsArrived'];
    }
  }


}