import 'dart:convert';
import 'package:boatrack_management/services/web_services.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../helpers/session.dart';
import '../models/account.dart';
import '../models/charter.dart';
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