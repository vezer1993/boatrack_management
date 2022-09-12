import 'package:boatrack_management/services/web_services.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/charter.dart';
import '../resources/strings.dart';
import 'package:boatrack_management/models/check_model.dart';
import 'dart:convert';
import 'charter_api.dart';

Future postNewCheckModel(CheckModel model, BuildContext context) async {

  Charter temp = await getCharter();
  model.charterId = temp.id;

  var response = await postResponse(StaticStrings.getPathModels(), model.toJson(), context) as http.Response;

  if(response.statusCode.toString().startsWith("2")){
    return true;
  }else{
    return false;
  }
}

Future putCheckModel(CheckModel model, BuildContext context) async {

  http.Response response = await putResponseNoParam(context, StaticStrings.getPathModels() + "/" + model.id.toString(), model.toJson());

  if(response.statusCode.toString().startsWith("2")){
    return true;
  }else{
    print(response.body);
    return false;
  }
}

Future deleteCheckModel(CheckModel model, BuildContext context) async {
  http.Response response = await deleteResponse(StaticStrings.getPathModels() + "/" + model.id.toString(), context);

  if(response.statusCode.toString().startsWith("2")){
    return true;
  }else{
    print(response.body);
    return false;
  }
}

Future getCheckModels() async {
  Charter temp = await getCharter();
  http.Response response = await getResponse(StaticStrings.getPathModels() + "/" + temp.id.toString());

  var jsonMap = json.decode(response.body);

  List<CheckModel> models = [];

  for(var json in jsonMap){
    CheckModel model = CheckModel.fromJson(json);
    models.add(model);
  }
  return models;
}