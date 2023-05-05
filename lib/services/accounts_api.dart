import 'dart:convert';
import 'package:boatrack_management/models/board_task.dart';
import 'package:boatrack_management/models/employeeTask.dart';
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

Future postNewTask(EmployeeTask task, BuildContext context) async {
  var response = await postResponse("/Task", task.toJson(), context) as http.Response;

  if(response.statusCode.toString().startsWith("2")){
    return true;
  }else{
    return false;
  }
}

Future postNewBoardTask(BoardTask task, BuildContext context) async {
  print(task.toJson());
  var response = await postResponse("/BoardTasks", task.toJson(), context) as http.Response;
  print(response.body);

  if(response.statusCode.toString().startsWith("2")){
    return true;
  }else{
    return false;
  }
}

Future getUnresolvedTasks() async {
  Charter temp = await getCharter();
  var response = await getResponse("/Task/list/" + temp.id.toString()) as http.Response;
  var jsonString = response.body;

  //DECODE TO JSON
  var jsonMap = json.decode(jsonString);

  /// PARSE JSON AND ADD TO LIST
  List<EmployeeTask> list = [];
  for(var json in jsonMap){
    EmployeeTask e = EmployeeTask.fromJson(json);
    list.add(e);
  }

  return list;
}

Future getUnresolvedBoardTasks(int id) async {
  var response = await getResponse("/BoardTasks/accounttasks/" + id.toString()) as http.Response;
  var jsonString = response.body;

  print(response.body);
  //DECODE TO JSON
  var jsonMap = json.decode(jsonString);


  /// PARSE JSON AND ADD TO LIST
  List<BoardTask> list = [];
  for(var json in jsonMap){
    BoardTask e = BoardTask.fromJson(json);
    list.add(e);
  }

  return list;
}

Future loginToWeb(String username, String password) async{

  String path = StaticStrings.getPathAccount() + "/" + username + "/" + password;
  var response = await getResponse(path) as http.Response;

  if(response.statusCode.toString().startsWith("2")){
    SessionStorage.saveValue(StaticStrings.getCharterSession(), response.body);
    return response;
  }else{
    return response;
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