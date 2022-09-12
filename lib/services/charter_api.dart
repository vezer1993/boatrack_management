import 'dart:convert';
import 'package:boatrack_management/services/web_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../helpers/session.dart';
import '../models/charter.dart';
import '../resources/strings.dart';

Future getCharter() async {
  var jsonString = "";

  ///TODO: FOR PRODUCTION REFRESH DATA EVERY X MINUTES
  /// CHECK IF LIST IN SESSION
  if(SessionStorage.getValue(StaticStrings.getCharterSession()) != null){
    jsonString = SessionStorage.getValue(StaticStrings.getCharterSession()).toString();
  }
  //DECODE TO JSON
  var jsonVar = json.decode(jsonString);
  Charter c = Charter.fromJson(jsonVar);

  return c;
}

Future updateCharter() async {

  Charter c = await getCharter();

  var response = await getResponse(StaticStrings.getPathCharter() + "/" + c.id.toString()) as http.Response;
  SessionStorage.saveValue(StaticStrings.getCharterSession(), response.body);

  //DECODE TO JSON
  var jsonVar = json.decode(response.body);
  c = Charter.fromJson(jsonVar);

  return c;
}

Future putCharterTeltonikaID(int charterID, String teltonikaID, BuildContext context) async{
  String path = StaticStrings.getPathCharter() + "/" + charterID.toString() + StaticStrings.getPathCharterTeltonika();
  Map<String, String> param = {};
  param[StaticStrings.getPathCharterTeltonikaParam()] = teltonikaID;
  var response = await putResponse(context, path, param) as http.Response;
  if(response.statusCode.toString().startsWith("2")){
    return true;
  }else{
    return false;
  }
}