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

Future getIssueForID(String issueID) async {
  var response = await getResponse(StaticStrings.getPathIssue() + "/" + issueID.toString()) as http.Response;
  var jsonString = response.body;
  return IssueItem.fromJson(json.decode(jsonString));;
}

Future putIssueResolve(String issueID, String documentPath, String note, BuildContext context) async {
  String path = StaticStrings.getPathIssue() + "/" + issueID.toString() + "/resolve";
  Map<String, String> param = {};
  param["note"] = note;
  param["document"] = documentPath;
  var response = await putResponse(context, path, param) as http.Response;

  if(response.statusCode.toString().startsWith("2")){
    return true;
  }else{
    return false;
  }
}