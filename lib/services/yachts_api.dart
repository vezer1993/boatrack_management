import 'dart:convert';
import 'package:boatrack_management/models/teltonika/TeltonikaDataJSON.dart';
import 'package:boatrack_management/models/yacht_location.dart';
import 'package:boatrack_management/services/charter_api.dart';
import 'package:boatrack_management/services/web_services.dart';
import 'package:boatrack_management/services/web_services_teltonika.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../helpers/session.dart';
import '../models/charter.dart';
import '../models/teltonika/TeltonikaData.dart';
import '../models/yacht.dart';
import '../resources/strings.dart';


/// YACHT LIST FOR CHARTER
Future getYachtList() async {

  var jsonString = "";

  ///TODO: FOR PRODUCTION REFRESH DATA EVERY X MINUTES
  /// CHECK IF LIST IN SESSION
  if(SessionStorage.getValue(StaticStrings.getYachtListSession()) != null){
    jsonString = SessionStorage.getValue(StaticStrings.getYachtListSession()).toString();
  }else{
    //IF NOT GET RESPONSE
    Charter temp = await getCharter();
    var response = await getResponse(StaticStrings.getPathYachtList() + "/" + temp.id.toString()) as http.Response;
    jsonString = response.body;
    SessionStorage.saveValue(StaticStrings.getYachtListSession(), jsonString);
  }

  //DECODE TO JSON
  var jsonMap = json.decode(jsonString);

  /// PARSE JSON AND ADD TO LIST
  List<Yacht> list = [];
  for(var json in jsonMap){
    Yacht y = Yacht.fromJson(json);
    list.add(y);
  }

  return list;
}

/// UPDATE YACHT LIST
Future updateYachtList() async {

  Charter temp = await getCharter();
  var response = await getResponse(StaticStrings.getPathYachtList() + "/" + temp.id.toString()) as http.Response;
  SessionStorage.saveValue(StaticStrings.getYachtListSession(), response.body);

  //DECODE TO JSON
  var jsonMap = json.decode(response.body);

  /// PARSE JSON AND ADD TO LIST
  List<Yacht> list = [];
  for(var json in jsonMap){
    Yacht y = Yacht.fromJson(json);
    list.add(y);
  }

  return list;
}

/// UPDATE TELTONIKA ID FOR YACHT
Future putYachtTeltonikaID(int yachtID, String teltonikaID, BuildContext context) async{
  String path = StaticStrings.getPathYacht() + "/" + yachtID.toString() + StaticStrings.getPathCharterTeltonika();
  Map<String, String> param = {};
  param[StaticStrings.getPathCharterTeltonikaParam()] = teltonikaID;
  var response = await putResponse(context, path, param) as http.Response;
  if(response.statusCode.toString().startsWith("2")){
    updateYachtList();
    return true;
  }else{
    return false;
  }
}

Future getYachtLocationList(List<Yacht> yachts) async {

  String path = StaticStrings.getTeltonikaDeviceInformation();
  Map<String, String> param = {};
  param["limit"] = yachts.length.toString();
  Charter c = await  getCharter();
  var response = await getTeltonikaResponseWithParam(path, param, c.teltonikaToken.toString()) as http.Response;
  if(response.statusCode.toString().startsWith("2")){
    TeltonikaDataModel model = TeltonikaDataModel.fromJson(json.decode(response.body));
    List<Data> data = model.data!;

    List<YachtLocation> result = [];

    for(Data d in data){
      YachtLocation temp;
      for(Yacht y in yachts){

        if(y.teltonikaId.toString() == d.id.toString()){
          if(d.longitude != null){
            temp = YachtLocation(d.latitude, d.longitude, y);
            result.add(temp);
          }
        }
      }
    }

    return result;
  }else{
    return [];
  }

}