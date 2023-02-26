import 'package:google_maps_flutter/google_maps_flutter.dart';

class TeltonikaGPS {
  String? altitude;
  String? createdAt;
  LatLng latLeng = LatLng(0, 0);


  TeltonikaGPS({this.altitude, this.createdAt});

  TeltonikaGPS.fromJson(Map<String, dynamic> json) {
    latLeng = LatLng(double.parse(json['latitude'].toString()), double.parse(json['longitude'].toString()));
    altitude = json['altitude'];
    createdAt = json['created_at'];
  }
}