import 'dart:convert';

import 'package:boatrack_management/models/check_segment.dart';

import 'charter.dart';

class CheckModel {
  int? id;
  String? name;
  String? boatModel;
  String? model;
  int? charterId;
  Charter? charter;
  List<String>? yachts;

  CheckModel({this.id, this.name, this.boatModel, this.model, this.yachts});

  CheckModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    boatModel = json['boatModel'];
    model = json['model'];
    yachts = json['yachts'].cast<String>();
    charterId = json['charterId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if(id != null){
      data['id'] = id;
    }
    data['name'] = this.name;
    data['model'] = this.model;
    data['charterId'] = this.charterId;
    return data;
  }

  void setModel(List<CheckSegment> segments){
    model = jsonEncode(segments);
    model = model?.replaceAll("\"", "¸");
  }

  List<CheckSegment> getModel(){
    List<CheckSegment> segments = [];

    if(model != null){
      model = model?.replaceAll("¸", "\"");
      var jsonObject = jsonDecode(model.toString());

      for(var object in jsonObject){
        CheckSegment seg = CheckSegment();
        seg.name = object["name"];
        seg.description = object["description"];
        seg.help = object["help"];
        if(object["images"] != null){
          seg.images = jsonDecode(object["images"]);
        }
        seg.outside = object["outside"];

        segments.add(seg);
      }
    }

    return segments;
  }
}