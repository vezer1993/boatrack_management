import 'dart:convert';
import 'package:boatrack_management/models/check_in_out.dart';
import 'package:boatrack_management/models/cleaning.dart';
import 'package:boatrack_management/models/issues.dart';
import 'package:boatrack_management/models/teltonika/TeltonikaDataJSON.dart';
import 'package:boatrack_management/models/yacht_location.dart';
import 'package:boatrack_management/services/charter_api.dart';
import 'package:boatrack_management/services/web_services.dart';
import 'package:boatrack_management/services/web_services_teltonika.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../helpers/session.dart';
import '../models/account.dart';
import '../models/charter.dart';
import '../models/teltonika/TeltonikaData.dart';
import '../models/yacht.dart';
import '../resources/strings.dart';


/// YACHT LIST FOR CHARTER
Future getYachtList() async {

  var jsonString = "";
  bool refresh = false;

  ///TODO: FOR PRODUCTION REFRESH DATA EVERY X MINUTES
  /// CHECK IF LIST IN SESSION
  if(SessionStorage.getValue(StaticStrings.getYachtListSession()) != null && !refresh){
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

Future getYachtForID(int yachtID) async {

  var jsonString = SessionStorage.getValue(StaticStrings.getYachtListSession()).toString();
  //DECODE TO JSON
  var jsonMap = json.decode(jsonString);

  /// PARSE JSON AND ADD TO LIST
  List<Yacht> list = [];
  for(var json in jsonMap){
    Yacht y = Yacht.fromJson(json);
    list.add(y);
  }

  return list.where((element) => element.id == yachtID).first;
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

Future putYachtCheckModel(int yachtID, int checkModelID, BuildContext context) async{
  String path = StaticStrings.getPathYacht() + "/" + yachtID.toString() + StaticStrings.getPathYachtCheckModel();
  Map<String, dynamic> param = {};
  param[StaticStrings.getPathParamYachtCheckModel()] = checkModelID.toString();
  var response = await putResponse(context, path, param) as http.Response;
  if(response.statusCode.toString().startsWith("2")){
    updateYachtList();
    return true;
  }else{
    return false;
  }
}

Future getCheckInOuts(bool checkin, int yachtID) async {

  String path = StaticStrings.getPathCheckInList();
  if(!checkin){
    path = StaticStrings.getPathCheckOutList();
  }
  var response = await getResponse(path + "/" + yachtID.toString()) as http.Response;
  var jsonString = response.body;

  //DECODE TO JSON
  var jsonMap = json.decode(jsonString);

  /// PARSE JSON AND ADD TO LIST
  List<CheckInOut> list = [];
  for(var json in jsonMap){
    CheckInOut y = CheckInOut.fromJson(json);
    list.add(y);
  }

  return list;
}

Future getIssues(int yachtID) async {
  var response = await getResponse(StaticStrings.getPathIssuesList() + "/" + yachtID.toString()) as http.Response;
  var jsonString = response.body;

  //DECODE TO JSON
  var jsonMap = json.decode(jsonString);

  /// PARSE JSON AND ADD TO LIST
  List<IssueItem> list = [];
  for(var json in jsonMap){
    IssueItem y = IssueItem.fromJson(json);
    list.add(y);
  }

  return list;
}

Future getUnresolvedIssues() async {
  Charter ch = await getCharter();
  var response = await getResponse(StaticStrings.getPathUnresolvedIssues() + "/" + ch.id.toString()) as http.Response;
  var jsonString = response.body;
  print(response.body);
  //DECODE TO JSON
  var jsonMap = json.decode(jsonString);

  /// PARSE JSON AND ADD TO LIST
  List<IssueItem> list = [];
  for(var json in jsonMap){
    IssueItem y = IssueItem.fromJson(json);
    list.add(y);
  }

  return list;
}

Future getCleanings(int yachtID) async {
  var response = await getResponse(StaticStrings.getPathCleaningList() + "/" + yachtID.toString()) as http.Response;
  var jsonString = response.body;

  //DECODE TO JSON
  var jsonMap = json.decode(jsonString);

  Charter c = await getCharter();

  /// PARSE JSON AND ADD TO LIST
  List<Cleaning> list = [];
  for(var json in jsonMap){
    Cleaning y = Cleaning.fromJson(json);
    for(Accounts a in c.accounts!){
      if(a.id == y.accountId){
        y.employee = a.name;
      }
    }
    list.add(y);
  }

  return list;
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