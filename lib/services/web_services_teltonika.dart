import 'dart:convert';
import 'package:boatrack_management/helpers/lottie/lottie_manager.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../resources/strings.dart';

Future getTeltonikaResponseWithParam(String path, Map<String, dynamic> param, String token) async {
  var client = http.Client();
  path = StaticStrings.getTeltonikaApiVersion() + path;
  var url = Uri.https(StaticStrings.getTeltonikaApiURL().toString(), path.toString(), param);

  return await client.get(url, headers: createHeaders(token));
}

Future getTeltonikaGPSRoute(String path, Map<String, dynamic> param, String token) async {
  var client = http.Client();
  path = StaticStrings.getTeltonikaApiVersion() + path;
  var url = Uri.https(StaticStrings.getTeltonikaApiURL().toString(), path.toString(), param);

  return await client.get(url, headers: createHeaders(token));
}


Map<String, String> createHeaders(String token) {
  return {
    "Accept": "application/json",
    "Authorization": "Bearer " + token.toString(),
  };
}