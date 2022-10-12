import 'dart:convert';
import 'package:boatrack_management/services/charter_api.dart';
import 'package:boatrack_management/services/web_services.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../helpers/session.dart';
import '../models/account.dart';
import '../models/charter.dart';
import '../models/cleaning.dart';
import '../resources/strings.dart';

Future postNewAccount(Accounts acc, BuildContext context) async {

  var response = await postResponse(StaticStrings.getPathAccount(), acc.toJson(), context) as http.Response;

  if(response.statusCode.toString().startsWith("2")){
    return true;
  }else{
    return false;
  }
}

Future loginToWeb(String username, String password) async{

  String path = StaticStrings.getPathAccount() + "/" + username + "/" + password;
  var response = await getResponse(path) as http.Response;

  if(response.statusCode.toString().startsWith("2")){
    SessionStorage.saveValue(StaticStrings.getCharterSession(), response.body);
    return true;
  }else{
    return false;
  }

}

Future getUserList() async {
  Charter c = await getCharter();
  return c.accounts;
}

Future getSelectedUser(int id) async {
  Charter c = await getCharter();
  return c.accounts?.where((acc) => acc.id == id).first;
}

Future getCleaningsForUser(int userID) async {
  var response = await getResponse(StaticStrings.getPathCleaningForUserList() + "/" + userID.toString()) as http.Response;
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