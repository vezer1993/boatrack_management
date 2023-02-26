import 'TeltonikaGPS.dart';

class TeltonikaGPSJSON {
  bool? success;
  List<TeltonikaGPS>? data;

  TeltonikaGPSJSON({this.success, this.data});

  TeltonikaGPSJSON.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <TeltonikaGPS>[];
      json['data'].forEach((v) {
        data!.add(TeltonikaGPS.fromJson(v));
      });
    }
  }
}
