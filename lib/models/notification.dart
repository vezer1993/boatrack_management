import 'package:boatrack_management/helpers/conversions.dart';

class Notification {
  int? id;
  String? message;
  String? type;
  int? typeId;
  String? timestamp;

  Notification({this.id, this.message, this.type, this.typeId, this.timestamp});

  Notification.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    message = json['message'];
    type = json['type'];
    typeId = json['typeId'];
    timestamp = json['timestamp'];
  }

  String getTimeStamp(){
    return Conversion.convertISOTimeToStandardFormatWithTime(timestamp.toString());
  }
}