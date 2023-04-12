import 'dart:convert';

import 'package:flutter/material.dart';

class CheckSegment{

  String? name;
  String? description;
  String? help;
  String? parentGroup;
  List<dynamic> images = [];

  TextEditingController? nameEditingController;
  TextEditingController? descriptionEditingController;
  TextEditingController? helpEditingController;
  bool edit = false;


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['name'] = name;
    data['description'] = description;
    data['help'] = help;
    data['parentGroup'] = parentGroup;
    if(images.isNotEmpty){
      data['images'] = jsonEncode(images);
    }
    return data;
  }
}