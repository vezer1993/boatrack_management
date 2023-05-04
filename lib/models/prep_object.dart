import 'dart:convert';

import 'package:boatrack_management/models/prep_segment.dart';

class PrepObject {
  int? accountId;
  String? document;
  int? yachtId;
  String? timestampData;
  bool? precheckin;
  bool? postcheckin;

  PrepObject(
      {this.accountId,
        this.document,
        this.yachtId,
        this.timestampData,
        this.precheckin,
        this.postcheckin});

  PrepObject.fromJson(Map<String, dynamic> json) {
    accountId = json['accountId'];
    document = json['document'];
    yachtId = json['yachtId'];
    timestampData = json['timestampData'];
    precheckin = json['precheckin'];
    postcheckin = json['postcheckin'];
  }

  List<PrePostSegment> getSegments(){
    List<PrePostSegment> segments = [];

    if(document != null){
      document = document?.replaceAll("¸", "\"");
      var jsonObject = jsonDecode(document.toString());

      for(var object in jsonObject){
        PrePostSegment seg = PrePostSegment();
        seg.name = object["name"];
        seg.description = object["description"];
        seg.rating = object["rating"];
        segments.add(seg);
      }
    }

    return segments;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['accountId'] = this.accountId;
    data['document'] = this.document;
    data['yachtId'] = this.yachtId;
    data['timestampData'] = this.timestampData;
    data['precheckin'] = this.precheckin;
    data['postcheckin'] = this.postcheckin;
    return data;
  }
}